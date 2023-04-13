//
//  MatchViewModal.swift
//  TeamHer
//
//  Created by Camille Lafrance on 27/03/2023.
//

import SwiftUI

struct MatchViewModal: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Binding var matchDone: Bool
    
    var match: Match
    
    // Fetched discussions
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    
    private var discussions: FetchedResults<Discussion>
    
    var allDiscussions: [Discussion] {
        discussions.map { $0 }
    }
    
    var discussion : Discussion? { match.getDiscussion(in: allDiscussions)}
    
    // Fetched user
    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "name == 'Magalie'"),
        animation: .default)
    
    private var users: FetchedResults<User>
    
    var user : User {
        users[0]
    }
    
    // Styled button
    struct ChatButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(Color.white)
                .bold()
                .frame(maxWidth: 359.0, maxHeight: 60)
                .background(Color("AccentColor"))
                .cornerRadius(10)
                .padding()
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("IndigoClair")
                    .ignoresSafeArea()
                VStack {
                    Text("It's a match !")
                        .font(.largeTitle)
                        .padding()
                    HStack {
                        Spacer()
                        Image((match.matchedUser?.userImage ?? "magalie"))
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 80, maxHeight: 80)
                        Spacer()
                        Image((match.matchingUser?.userImage ?? "magalie"))
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 80, maxHeight: 80)
                        Spacer()
                    }
                    .padding()
                    VStack {
                        HStack(spacing: 3) {
                            Text("Tu as matché avec")
                            Text(match.matchAlias) // MATCH ALIAS
                            Text(" !")
                        }
                        Text("Présente-toi")
                    }
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                    NavigationLink(destination: MessagesDetailView( discussion: discussion, user: user, match: match)) {
                        Text("Lui écrire...")
                            .font(.title2)
                    }
                    .buttonStyle(ChatButton())
                    .onTapGesture {
                        dismiss()
                        matchDone.toggle()
                    }
                    Button("Fermer") {
                        self.matchDone.toggle()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        
    }
}

struct MatchViewModal_Previews: PreviewProvider {
    static var previews: some View {
        let match = Match(context: PersistenceController.preview.container.viewContext)
        return MatchViewModal(matchDone: .constant(false), match: match).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
