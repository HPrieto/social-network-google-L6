//
//  RegistrationView.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 23/12/22.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            
            NavigationLink(destination: ProfilePhotoSelectorView(),
                           isActive: $viewModel.didAuthenticateUser,
                           label: { })
            
            AuthHeaderView(title1: "Sign up", title2: "Create a profile, follow other accounts, make our own videos, and more.")
            
            VStack(spacing: 40) {
                CustomInputField(placeholderText: "Email",
                                 textCase: .lowercase,
                                 keyboardType: .emailAddress,
                                 textContentType: .emailAddress,
                                 text: $email)
                
                CustomInputField(placeholderText: "Username",
                                 textCase: .lowercase,
                                 keyboardType: .default,
                                 textContentType: .username,
                                 text: $username)
                
                CustomInputField(placeholderText: "Full name",
                                 textContentType: .name,
                                 textInputAutoCapital: .words,
                                 text: $fullname)
                
                CustomInputField(placeholderText: "Password",
                                 textContentType: .newPassword,
                                 isSecureField: true,
                                 text: $password)
            }
            .padding(32)
            
            Button {
                print("Sign Up")
                viewModel.register(withEmail: email,
                                   password: password,
                                   fullname: fullname,
                                   username: username)
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color.themeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                    
                    Text("Log In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)

        }
        .ignoresSafeArea()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
