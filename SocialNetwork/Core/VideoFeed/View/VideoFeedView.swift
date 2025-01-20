//
//  VideoFeedView.swift
//  SocialNetwork
//
//  Created by Heriberto Prieto on 1/16/25.
//

import SwiftUI

struct VideoFeedView: View {
    @State private var showNewPostView = false
    @ObservedObject var viewModel = VideoFeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.posts) { post in
                        VideoPostRowView(post: post)
                            .padding()
                    }
                }
            }
            
            Button {
                print("New post")
                showNewPostView.toggle()
            } label: {
                Image("newPost")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .padding()
            }
            .background(Color.themeColor)
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .padding(.trailing, 10)
            .padding(.bottom, 20)
            .fullScreenCover(isPresented: $showNewPostView, onDismiss: {
                viewModel.fetchPosts()
            }) {
               NewPostView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
       
    }
}

struct VideoFeedView_Previews: PreviewProvider {
    static var previews: some View {
        VideoFeedView()
    }
}
