//
//  ProfileInfoRowView.swift
//  TeamHer
//
//  Created by Apprenant 69 on 24/03/2023.
//

import SwiftUI

struct ProfileInfoRowView: View {
    
    var label : String = "Default"
    var info : String = "X"
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(info)
        }
    }
}

struct ProfileInfoRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProfileInfoRowView()
        }
        .listStyle(.plain)
    }
}
