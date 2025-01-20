//
//  VideoFeedViewModel.swift
//  SocialNetwork
//
//  Created by Heriberto Prieto on 1/16/25.
//

import Foundation

class VideoFeedViewModel: ObservableObject {
    @Published var posts = [VideoPost]()
    let service = VideoPostService()
    let userService = UserService()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        service.fetchPosts { posts in
            self.posts = posts
            
            for index in 0 ..< posts.count {
                let uid = posts[index].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.posts[index].user = user
                }
            }
        }
    }
}
