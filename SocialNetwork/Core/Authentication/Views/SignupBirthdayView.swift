//
//  SignupBirthdayView.swift
//  SocialNetwork
//
//  Created by Heriberto Prieto (Personal) on 1/28/24.
//

import SwiftUI

struct SignupBirthdayView: View {
    @State private var selectedDate = Date()
    @State private var dateString = ""
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    let startDate = Calendar.current.date(from: DateComponents(year: 1900)) ?? Date()
    let endDate = Date()
    private var isOfAge: Bool {
        return Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date() >= selectedDate
    }
    
    var body: some View {
        VStack {
            
            NavigationLink(destination: ProfilePhotoSelectorView(),
                           isActive: $viewModel.didAuthenticateUser,
                           label: { })
            
            AuthHeaderView(title1: "When's your birthday?", title2: "Must be atleast 18 years of age. Your birthday won't be shown publicly.")
            
            VStack(spacing: 40) {
                CustomInputField(placeholderText: "Birthday",
                                 textCase: .lowercase,
                                 keyboardType: .default,
                                 textContentType: .dateTime,
                                 text: $dateString)
                .disabled(true)
            }
            .padding(32)
            
            NavigationLink {
                SignupView(birthday: selectedDate)
                    .navigationBarHidden(false)
                    .navigationBarBackButtonHidden(false) // Hides the default back button
            } label: {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(isOfAge ? Color.themeColor : .gray)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            .disabled(!isOfAge)
            
            
            Spacer()
            
            HStack {
                
                DatePicker("", selection: $selectedDate, in: startDate ... endDate, displayedComponents: .date)
                    .padding() // Adds some padding around the DatePicker
                    .datePickerStyle(WheelDatePickerStyle())
                    .onChange(of: selectedDate) { _ in
                        updateDateString()
                    }
                
            }
        }
        .ignoresSafeArea()
    }
    
    private func updateDateString() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        dateString = formatter.string(from: selectedDate)
    }
}

struct SignupViewBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        SignupBirthdayView()
    }
}
