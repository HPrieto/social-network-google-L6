//
//  ProfileEditView.swift
//  SocialNetwork
//
//  Created by Heriberto Prieto (Personal) on 1/29/24.
//

import SwiftUI

struct ProfileEditView: View {
    @State private var fullname: String = ""
    @State private var username: String = ""
    @State private var birthday: Date
    @State private var birthdayText: String
    @State private var profileDescription: String = ""
    @State private var email: String
    @State private var phoneNumber: String = ""
    @State private var gender: String = ""
    
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
        self.fullname = user.fullname
        self.username = user.username
        self.birthday = user.birthday
        self.profileDescription = user.profileDescription ?? ""
        self.email = user.email
        self.phoneNumber = user.phoneNumber ?? ""
        self.birthday = user.birthday
        self.birthdayText = user.birthday.formattedToMMDDYYYY
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // headerView
            
            profilePhotoView
            
            Divider()
            
            profileInfoView
            
            Divider()
            
            profilePrivateInfoView
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 21, height: 18)
                        .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Edit Profile")
                    .font(.system(size: 18, weight: .semibold))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                        .fontWeight(.medium)
                }
            }
        }
    }
    
    func saveData() {
        let currentUser = self.viewModel.user
        var fieldsToUpdate: [String: Any] = [:]
        
        if fullname != currentUser.fullname {
            fieldsToUpdate["fullname"] = fullname
        }
        
        if profileDescription != currentUser.profileDescription {
            fieldsToUpdate["profileDescription"] = profileDescription
        }
        
        if phoneNumber != currentUser.phoneNumber {
            fieldsToUpdate["phoneNumber"]
        }
        
        
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(user:
                            User(
                                id: NSUUID().uuidString,
                                username: "sergeydeveloper",
                                fullname: "Sergey Developer",
                                birthday: Date(),
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
                
                CustomInputField(placeholderText: "Name", text: $fullname)
                    .keyboardType(.default)
            }
            
            HStack {
                Text("Username")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Username", text: $username)
                    .keyboardType(.default)
            }
            
            HStack {
                Text("Birthday")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Birthday", text: $birthdayText)
            }
            
            HStack {
                Text("Bio")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Bio", text: $profileDescription)
                    .keyboardType(.default)
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
                    .keyboardType(.emailAddress)
            }
            
            HStack {
                Text("Phone")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Phone", text: $phoneNumber)
                    .keyboardType(.phonePad)
            }
            
            HStack {
                Text("Gender")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Gender", text: $gender)
                    .keyboardType(.default)
            }
            
        }
        .padding(.horizontal)
    }
}

extension Date {
    
    var formattedToMMDDYYYY: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" // Specify the format you want
        return dateFormatter.string(from: self) // Convert the date to a string
    }
}
