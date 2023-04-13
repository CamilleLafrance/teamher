//
//  ProfilePersonalityView.swift
//  TeamHer
//
//  Created by } 69 on 24/03/2023.
//

import SwiftUI

struct ProfilePersonalityView: View {
    
    var info : String = "Exemple"
    
    var body: some View {
        Section {
            Text(info)
                .padding(.horizontal, 10)
                .padding(.vertical, 9)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(20)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.top, 10)
    }
}

struct ProfilePersonalityView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePersonalityView()
    }
}
