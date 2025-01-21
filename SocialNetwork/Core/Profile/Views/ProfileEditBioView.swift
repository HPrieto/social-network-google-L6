//
//  ProfileEditBioView.swift
//  SocialNetwork
//
//  Created by Heriberto Prieto on 1/20/25.
//

import SwiftUI

struct ProfileEditBioView: View {
    @Binding public var bio: String
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack {
            CustomInputField(placeholderText: "Tell others about yourself", text: $bio)
                .keyboardType(.default)
                .focused($isTextFieldFocused)
                .padding()
            
            Spacer()
        }.toolbar {
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
                Text("Bio")
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isTextFieldFocused = true
            }
        }
        .navigationBarBackButtonHidden()
    }
}
