//
//  ContactsRow.swift
//  TeamHer
//
//  Created by Imen Ksouri on 25/03/2023.
//

import SwiftUI

struct ContactsRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var match: Match
    var body: some View {
        HStack{
            Image(match.matchImage)
                .resizable()
                .scaledToFill()
                .mask(Circle())
                .frame(width: 50, height: 15)
                .padding()
                .overlay(Circle().stroke((Color.accentColor), lineWidth: 3))
            HStack {
                Text(match.matchedUser?.userAlias ?? "Anonymous")
                    .bold()
                    .foregroundColor(.accentColor)
                Spacer()
            }
            
        }
        .frame(height: 50)
    }
}

struct ContactsRow_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let match = Match(context: viewContext)
        ContactsRow(match: match)
    }
}
