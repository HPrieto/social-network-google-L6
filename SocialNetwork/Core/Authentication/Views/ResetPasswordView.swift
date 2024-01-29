//
//  ResetPasswordView.swift
//  SocialNetwork
//
//  Created by Heriberto Prieto (Personal) on 1/21/24.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var email: String = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            AuthHeaderView(title1: "Forgot Password", title2: "Enter your email below to receive a reset password link.")
            
            VStack(spacing: 40) {
                CustomInputField(placeholderText: "Email",
                                 textCase: .lowercase,
                                 keyboardType: .emailAddress,
                                 textContentType: .emailAddress,
                                 text: $email)
            }
            .padding(32)
            
            Button {
                print("Reset Password")
                
            } label: {
                Text("Reset")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color.themeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
