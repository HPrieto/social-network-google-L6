//
//  BorderedDatePicker.swift
//  SocialNetwork
//
//  Created by Heriberto Prieto on 1/21/25.
//

import SwiftUI

struct BorderedDatePicker: View {
    
    var title: String
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                
                DatePicker(
                    self.title,
                    selection: $selectedDate,
                    in: ...Date(),
                    displayedComponents: [.date]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                
                Spacer()
                
                
            }
            
            Spacer()
            
            Divider()
                .background(Color(.lightGray))
        }
        .frame(height: 48)
    }
}

struct BorderedDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        BorderedDatePicker(title: "Birthday", selectedDate: .constant(Date()))
    }
}
