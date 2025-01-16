//
//  CustomInputField.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 23/12/22.
//

import SwiftUI

struct CustomInputField: View {
    let placeholderText: String
    var textCase: Text.Case?
    var keyboardType: UIKeyboardType?
    var textContentType: UITextContentType?
    var textInputAutoCapital: TextInputAutocapitalization?
    var isSecureField: Bool? = false
    @Binding var text: String
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                        .textContentType(textContentType != nil ? textContentType : .none)
                } else {
                    TextField(placeholderText, text: $text, onEditingChanged: { _ in
                        text = setTextCase(text: text)
                    })
                    .keyboardType(keyboardType != nil ? keyboardType! : .default)
                    .textContentType(textContentType != nil ? textContentType : .none)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(textInputAutoCapital != nil ? textInputAutoCapital : .none)
                    .onChange(of: text) { newValue in 
                        text = setTextCase(text: text)
                    }
                }
            }
            
            Spacer()
            
            Divider()
                .background(Color(.darkGray))
        }
        .frame(height: 48)
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(placeholderText: "Email", isSecureField: false, text: .constant(""))
    }
    
}

extension CustomInputField {
    
    func setTextCase(text: String) -> String {
        if let textCase = textCase {
            if textCase == .uppercase {
                return text.uppercased()
            } else if textCase == .lowercase {
                return text.lowercased()
            }
        }
        return text
    }
}
