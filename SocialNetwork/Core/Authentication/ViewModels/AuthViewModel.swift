//
//  AuthViewModel.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 23/12/22.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    private var tempUserSession: FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    //MARK: - Login
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error as? NSError {
                print("Error code: \(error.code)")
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            print("DEBUG: Did Log user in.. \(String(describing: self.userSession?.email))")
        }
    }
    
        //MARK: - Register
    func register(withEmail email: String, password: String, fullname: String, username: String, birthday: Date) {
        let userRef = Firestore.firestore().collection("users")
        let query = userRef.whereField("username", isEqualTo: username)
        
        query.getDocuments { snapshot, error in
            if let error = error as? NSError {
                print("DEBUG AuthViewModel.register error(\(error.code)): \(error.localizedDescription)")
            }
            
            if let documents = snapshot?.documents, !documents.isEmpty {
                print("Username is already taken.")
                return
            }
            self.createUser(withEmail: email, password: password, username: username, fullName: fullname, birthday: birthday)
        }
    }
    
        //MARK: - Logout
    func logout() {
        didAuthenticateUser = false
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
    
    func resetPassword(completion: @escaping ((Error?) -> Void)) {
        guard let currentUser = currentUser else {
            completion(NSError(domain: "", code: 404, userInfo: ["": ""]))
            return
        }
        Auth.auth().sendPasswordReset(withEmail: currentUser.email, completion: completion)
    }
}

fileprivate extension AuthViewModel {
    
    func createUser(withEmail email: String, password: String, username: String, fullName: String, birthday: Date) {
        let usersRef = Firestore.firestore().collection("users")
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error as? NSError {
                // Print debug description of the error
                print("Password must contain an upper case character, Password must contain a numeric character")
                print("DEBUG Error: \(error.debugDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.tempUserSession = user
              
            let userData = ["email": email,
                            "username": username.lowercased(),
                            "fullname": fullName,
                            "uid": user.uid,
                            "birthday": birthday
            ]
            
            usersRef.document(user.uid).setData(userData) { error in
                if let error = error {
                    print("DEBUG AuthViewModel.createUser error: \(error.localizedDescription)")
                }
                self.didAuthenticateUser = true
            }
        }
    }
}

extension NSError {
    
    public var firAuthError: FirebaseAuthError? {
        // Example: Extract meaningful parts of the string using regular expressions
        do {
            // Extract the main error domain
            let domainRegex = try NSRegularExpression(pattern: #"Error Domain=(.*?) Code"#)
            let domainMatch = domainRegex.firstMatch(in: debugDescription, options: [], range: NSRange(location: 0, length: debugDescription.count))
            
            // Extract the main error code
            let codeRegex = try NSRegularExpression(pattern: #"Code=(\d+)"#)
            let codeMatch = codeRegex.firstMatch(in: debugDescription, options: [], range: NSRange(location: 0, length: debugDescription.count))
            
            // Extract the description
            let descriptionRegex = try NSRegularExpression(pattern: #"\"(.*?)\" UserInfo"#)
            let descriptionMatch = descriptionRegex.firstMatch(in: debugDescription, options: [], range: NSRange(location: 0, length: debugDescription.count))
            
            // Extract the underlying error message
            let underlyingMessageRegex = try NSRegularExpression(pattern: #"message = \"(.*?)\";"#)
            let underlyingMessageMatch = underlyingMessageRegex.firstMatch(in: debugDescription, options: [], range: NSRange(location: 0, length: debugDescription.count))
            
            // Convert matches to strings
            let domain = domainMatch.flatMap { Range($0.range(at: 1), in: debugDescription) }.map { String(debugDescription[$0]) }
            let code = codeMatch.flatMap { Range($0.range(at: 1), in: debugDescription) }.map { Int(debugDescription[$0]) } ?? 0
            let description = descriptionMatch.flatMap { Range($0.range(at: 1), in: debugDescription) }.map { String(debugDescription[$0]) }
            let underlyingMessage = underlyingMessageMatch.flatMap { Range($0.range(at: 1), in: debugDescription) }.map { String(debugDescription[$0]) }
            
            // Return parsed struct
            return FirebaseAuthError(
                domain: domain ?? "Unknown",
                code: code ?? 0,
                description: description ?? "No description available",
                underlyingError: FirebaseAuthError.UnderlyingError(
                    domain: "FIRAuthInternalErrorDomain",
                    code: 3,
                    data: nil,
                    message: underlyingMessage ?? "No message available",
                    errors: [
                        FirebaseAuthError.UnderlyingError.ErrorDetail(
                            domain: "global",
                            message: "PASSWORD_DOES_NOT_MEET_REQUIREMENTS",
                            reason: "invalid"
                        )
                    ]
                )
            )
        } catch {
            print("Failed to parse debug description: \(error.localizedDescription)")
            return nil
        }
    }
}


public struct FirebaseAuthError: Codable {
    let domain: String
    let code: Int
    let description: String
    let underlyingError: UnderlyingError?
    
    struct UnderlyingError: Codable {
        let domain: String
        let code: Int
        let data: String?
        let message: String
        let errors: [ErrorDetail]
        
        struct ErrorDetail: Codable {
            let domain: String
            let message: String
            let reason: String
        }
    }
}
