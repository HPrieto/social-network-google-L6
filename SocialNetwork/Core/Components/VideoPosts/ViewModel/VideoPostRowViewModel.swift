//
//  VideoPostRowViewModel.swift
//  SocialNetwork
//
//  Created by Heriberto Prieto on 1/16/25.
//

import Foundation

class VideoPostRowViewModel: ObservableObject {
    @Published var post: VideoPost
    private let service = VideoPostService()
    
    
    init(post: VideoPost) {
        self.post = post
        self.checkIfUserLikedPost()
    }
    
    func likePost() {
        service.likePost(post) {
            self.post.didLike = true
        }
    }
    
    func unlikePost() {
        service.unlikePost(post) {
            self.post.didLike = false
        }
    }
    
    func checkIfUserLikedPost() {
        service.checkIsUserLikedPost(post) { didLike in
            if didLike {
                self.post.didLike = true
            }
        }
    }
}
