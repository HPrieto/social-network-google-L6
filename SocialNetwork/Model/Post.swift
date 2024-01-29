//
//  Post.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 25/12/22.
//

import Firebase
import FirebaseFirestore

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    
    var user: User?
    var didLike: Bool? = false
}
