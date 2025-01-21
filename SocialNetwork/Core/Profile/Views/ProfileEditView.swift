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
                    self.viewModel.updateCurrentUser(
                        fullname: self.fullname,
                        profileDescription: self.profileDescription,
                        phoneNumber: self.phoneNumber,
                        birthday: self.birthday)
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                        .fontWeight(.medium)
                }
            }
        }
        
        .navigationBarBackButtonHidden(true)
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(user:
                            User(id: NSUUID().uuidString, username: "sergeydeveloper", fullname: "Sergey Developer", birthday: Date(),email: "sergey.developer@gmail.com")
        )
    }
}

extension ProfileEditView {
    
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
            }
            
            HStack {
                Text("Username")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "Username", text: $username)
                    .disabled(true)
            }
            
            NavigationLink {
                VStack {
                    DatePicker(
                        "Birthday",
                        selection: $birthday,
                        in: ...Date(),
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .onChange(of: birthday) { newValue in
                        self.birthdayText = self.birthday.formattedToMMDDYYYY
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Birthday")
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
            } label: {
                HStack {
                    Text("Birthday")
                        .font(.system(size: 15))
                        .frame(width: 100, alignment: .leading)
                        .foregroundStyle(Color.black)
                    
                    CustomInputField(placeholderText: "", text: $birthdayText)
                }
            }
            
            NavigationLink {
                ProfileEditBioView(bio: $profileDescription)
            } label: {
                HStack {
                    Text("Bio")
                        .font(.system(size: 15))
                        .frame(width: 100, alignment: .leading)
                        .foregroundColor(.black)
                    
                    CustomInputField(placeholderText: "Bio", isNavigationField: true, text: $profileDescription)
                }
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
                    .disabled(true)
            }
            
            HStack {
                Text("Phone")
                    .font(.system(size: 15))
                    .frame(width: 100, alignment: .leading)
                
                CustomInputField(placeholderText: "(XXX) XXX-XXXX", keyboardType: .phonePad, text: $phoneNumber)
                    
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

extension Date {
    
    var formattedToMMDDYYYY: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" // Specify the format you want
        return dateFormatter.string(from: self) // Convert the date to a string
    }
}

extension String {
    
    public var formattedPhoneNumber: String {
        // Remove any non-numeric characters
        let digits = self.filter { $0.isNumber }
        
        // Format based on length
        switch digits.count {
        case 0...3:
            return digits
        case 4...6:
            return "(\(digits.prefix(3))) \(digits.suffix(digits.count - 3))"
        case 7...10:
            let areaCode = digits.prefix(3)
            let prefix = digits[digits.index(digits.startIndex, offsetBy: 3)..<digits.index(digits.startIndex, offsetBy: 6)]
            let lineNumber = digits.suffix(digits.count - 6)
            return "(\(areaCode)) \(prefix)-\(lineNumber)"
        default:
            let areaCode = digits.prefix(3)
            let prefix = digits[digits.index(digits.startIndex, offsetBy: 3)..<digits.index(digits.startIndex, offsetBy: 6)]
            let lineNumber = digits[digits.index(digits.startIndex, offsetBy: 6)..<digits.index(digits.startIndex, offsetBy: 10)]
            let extras = digits.suffix(digits.count - 10)
            return "(\(areaCode)) \(prefix)-\(lineNumber) \(extras)"
        }
    }
}
