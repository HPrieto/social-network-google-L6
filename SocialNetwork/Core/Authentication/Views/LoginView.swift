//
//  LoginView.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 22/12/22.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
           //header here
            AuthHeaderView(title1: "Login", title2: "Manage your account, check notifications, comment on posts and more.")
            
            VStack(spacing: 40) {
                CustomInputField(placeholderText: "Email",
                                 textCase: .lowercase,
                                 keyboardType: .emailAddress,
                                 textContentType: .emailAddress,
                                 text: $email)
                
                
                CustomInputField(placeholderText: "Password",
                                 textCase: .lowercase,
                                 keyboardType: .default,
                                 textContentType: .password,
                                 isSecureField: true,
                                 text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
            
            HStack {
                NavigationLink {
                    ForgotPasswordView()
                        .navigationBarHidden(false)
                        .navigationBarBackButtonHidden(false)
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.themeColor)
                        .padding(.top)
                        .padding(.leading, 32)
                }
                
                Spacer()
            }
            
            Button {
                print("Log In")
                viewModel.login(withEmail: email, password: password)
            } label: {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color.themeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            NavigationLink  {
                SignupBirthdayView()
                    .navigationBarHidden(false)
                    .navigationBarBackButtonHidden(false) // Hides the default back button
            } label: {
                HStack {
                    Text("Don't have an account?")
                        .font(.footnote)
                    
                    Text("Sign Up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color.themeColor)

        }
        .ignoresSafeArea()
        
         
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
