//
//  User.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 24/12/22.
//

import FirebaseFirestore
import Firebase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let birthday: Date
    let email: String
    var profileImageUrl: String?
    var profileDescription: String?
    var phoneNumber: String?
}

extension User {
    var avatarUrl: String {
        profileImageUrl ?? "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
    }
        
    var isCurrentUser: Bool {
        Auth.auth().currentUser?.uid == id
    }
}
