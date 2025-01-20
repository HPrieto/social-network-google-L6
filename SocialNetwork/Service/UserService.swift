//
//  UserService.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 24/12/22.
//

import Firebase

struct UserService {
    
    func fetchUser(withUsername username: String, completion: @escaping(Result<User, Error>) -> Void) {
        let usersRef = Firestore.firestore().collection("users")
        let query = usersRef.whereField("username", isEqualTo: username)
        query.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG UserService.fetchUser error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let documents = snapshot?.documents, let document = documents.first {
                var user: User
                
                do {
                    user = try document.data(as: User.self)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                    print("DEBUG UserService.fetchUser error: \(error.localizedDescription)")
                }
            } else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found."])))
            }
        }
    }
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        print("DEBUG Fetching user: \(uid)")
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                var user: User
                
                do {
                    user = try snapshot.data(as: User.self)
                } catch {
                    print ("Error fetchUser: \(error)")
                    return
                }
                
                completion(user)
            }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) { 
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self)})
                
                completion(users)
            }
    }
    
    func fetchUsers(whereField field: String, isEqualTo value: [Any], completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users").whereField(field, isEqualTo: value)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self)})
                completion(users)
            }
    }
}

extension UserService {
    
    func updateUser(uid: String, fieldsToUpdate fields: [String: Any], completion: @escaping(Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
            let userRef = db.collection("users").document(uid)
            
            userRef.updateData(fields) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
}
