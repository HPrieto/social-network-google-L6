//
//  ProfileEditView.swift
//  SocialNetwork
//
//  Created by Heriberto Prieto (Personal) on 1/29/24.
//

import SwiftUI

struct ProfileEditView: View {
    @State private var name = ""
    @State private var username = ""
    @State private var birthday: Date?
    @State private var bio = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var gender = ""
    
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
        self.name = user.fullname
        self.username = user.username
        // self.birthday = user.birthday
        // self.bio = user.bio
        self.email = user.email
        // self.phone = user.phone
        // self.gender = user.gender
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            headerView
            
            profilePhotoView
            
            Divider()
            
            profileInfoView
            
            Divider()
            
            profilePrivateInfoView
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(user: User(id: NSUUID().uuidString,
                               username: "sergeydeveloper",
                               fullname: "Sergey Developer",
                               profileImageUrl: "",
                               email: "sergey.developer@gmail.com"))
    }
}

extension ProfileEditView {
    
    var headerView: some View {
        HStack(alignment: .center, spacing: 12) {
            
            Button {
                mode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 21, height: 18)
                    .foregroundColor(.black)
            }
            .padding(.trailing)
            
            Spacer()
            
            Text("Edit Profile")
                .font(.system(size: 18, weight: .semibold))
            
            Spacer()
            
            Button {
                mode.wrappedValue.dismiss()
            } label: {
                Text("Done")
                    .fontWeight(.medium)
            }
        }
        .padding(.horizontal)
    }
    
    var profilePhotoView: some View {
        HStack {
            Spacer()
            
            VStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 95, height: 95) // Adjust size as needed
                    .clipShape(Circle())
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                Button {
                    print("Changing photo")
                } label: {
                    
                    Text("Change Profile Photo")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    var profileInfoView: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Name")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Name", text: $name)
            }
            
            HStack {
                Text("Username")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Username", text: $username)
            }
            
            HStack {
                Text("Birthday")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Birthday", text: $username)
            }
            
            HStack {
                Text("Bio")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Bio", text: $bio)
            }
            
        }
        .padding(.horizontal)
    }
    
    var profilePrivateInfoView: some View {
        VStack(alignment: .leading) {
            
            Text("Private Information")
                .font(.system(size: 15))
                .fontWeight(.semibold)
            
            HStack {
                Text("Email")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Email", text: $email)
            }
            
            HStack {
                Text("Phone")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Phone", text: $phone)
            }
            
            HStack {
                Text("Gender")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Gender", text: $gender)
            }
            
        }
        .padding(.horizontal)
    }
}
