//
//  ProfileView.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 21/12/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State private var selectedFiler: PostFilterViewModel = .posts
    @State private var showSettings: Bool = false
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            headerView
            
            actionButtons
            
            userInfoDetails
            
            NavigationLink {
                ProfileEditView(user: viewModel.user)
            } label: {
                HStack {
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline).bold()
                        .frame(width: 120, height: 32)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 0.75))
            .padding(.horizontal)
    
            postFilterBar
    
            postsView
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(id: NSUUID().uuidString,
                               username: "HPrietoDev",
                               fullname: "Heriberto Prieto",
                               birthday: Date(),
                               email: "sergey.developer@gmail.com",
                               profileImageUrl: ""))
    }
}

extension ProfileView {
    
    var headerView: some View {
        HStack(alignment: .center, spacing: 12) {
            
            HStack(spacing: 4) {
                Image(systemName: "lock")
                    .font(.system(size: 16, weight: .medium))
                
                Text(viewModel.user.username)
                    .font(.system(size: 21, weight: .semibold))
            }
            .padding(.leading)
            
            Spacer()
            
            Button {
                self.showSettings = true
            } label: {
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .frame(width: 21, height: 18)
                    .foregroundColor(.black)
            }
            .padding(.trailing)
            .confirmationDialog("", isPresented: $showSettings) {
                NavigationLink {
                    //
                } label: {
                    HStack {
                        Image(systemName: "cog")
                        
                        Text("Settings")
                    }
                }
            }
        }
    }
    
    var actionButtons: some View {
//        HStack(spacing: 12) {
//            Spacer()
//            
//            Image(systemName: "bell.badge")
//                .font(.title3)
//                .padding(6)
//                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
//        
//            Button {
//                //
//            } label: {
//                Text(viewModel.actionButtonTitle)
//                    .font(.subheadline).bold()
//                    .frame(width: 120, height: 32)
//                    .foregroundColor(.black)
//                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 0.75))
//            }
//        }
//        .padding(.trailing)
        
        HStack(spacing: 12) {
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 96, height: 96) // Adjust size as needed
                .clipShape(Circle())
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            HStack {
                
                VStack {
                    
                    Text("54")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    
                    Text("Posts")
                        .font(.system(size: 13))
                    
                }
                
                Spacer()
                
                VStack {
                    
                    Text("834")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    
                    Text("Followers")
                        .font(.system(size: 13))
                    
                }
                
                Spacer()
                
                VStack {
                    
                    Text("162")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    
                    Text("Following")
                        .font(.system(size: 13))
                    
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var userInfoDetails: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("\(viewModel.user.fullname)")
                .fontWeight(.semibold)
            
            Text("Test description \nTest description line 2.")
                .font(.system(size: 16, weight: .regular))
        }
        .padding(.horizontal)
        
//        VStack(alignment: .leading, spacing: 4) {
//            HStack {
//                Text(viewModel.user.fullname)
//                    .font(.title2).bold()
//                
//                Image(systemName: "checkmark.seal.fill")
//                    .foregroundColor(Color.themeColor)
//            }
//            
//            Text("@\(viewModel.user.username)")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//            
//            Text("It-entrepreneur")
//                .font(.subheadline)
//                .padding(.vertical)
//            
//            HStack(spacing: 24) {
//                HStack {
//                    Image(systemName: "mappin.and.ellipse")
//                    Text("Nicosia, CY")
//                }
//                HStack {
//                    Image(systemName: "link")
//                    Text("sergeyleschev.github.io")
//                }
//            }
//            .font(.caption)
//            .foregroundColor(.gray)
//                //
//            UserStatsView()
//                .padding(.vertical)
//        }
//        .padding(.horizontal)
    }
    
    var postFilterBar: some View {
        HStack {
            ForEach(PostFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFiler == item ? .semibold : .regular)
                        .foregroundColor(selectedFiler == item ? .black : .gray)
                    
                    if selectedFiler == item {
                        Capsule()
                            .foregroundColor(Color.themeColor)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFiler = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
    var postsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.posts(forFilter: self.selectedFiler)) { post in
                    PostRowView(post: post)
                        .padding() 
                }
            }
        }
    }
}
