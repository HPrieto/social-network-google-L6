//
//  AuthHeaderView.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 23/12/22.
//

import SwiftUI

struct AuthHeaderView: View {
    let title1: String
    let title2: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                Text(title1)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 1)
                
                Text(title2)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
            }
            .padding(.leading)
            .foregroundColor(.black)
            // .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight]))
            
            Spacer()
        }
        .padding(.leading)
        .padding(.top, 128)
        
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(title1: "Hello", title2: "Welcome back")
    }
}
