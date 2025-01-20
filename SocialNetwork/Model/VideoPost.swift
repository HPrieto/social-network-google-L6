//
//  VideoPost.swift
//  SocialNetwork
//
//  Created by Heriberto Prieto on 1/16/25.
//

import Firebase
import FirebaseFirestore

struct VideoPost: Identifiable, Decodable {
    @DocumentID var id: String?
    let videoURL: String
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    
    var user: User?
    var didLike: Bool? = false
}
