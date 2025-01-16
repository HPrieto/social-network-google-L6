//
//  MainTabView.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 21/12/22.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            FeedView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                }.tag(0)
            
            ExploreView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            
            NotificationsView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "heart")
                }.tag(2)
            
            ProfileView(user: User(id: NSUUID().uuidString,
               username: "HPrietoDev",
               fullname: "Heriberto Prieto",
               profileImageUrl: "",
               email: "sergey.developer@gmail.com"))
            .onTapGesture {
                self.selectedIndex = 3
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
            }.tag(3)
                
        } 
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
