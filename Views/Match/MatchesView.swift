//
//  MatchesView.swift
//  TeamHer
//
//  Created by Camille Lafrance on 24/03/2023.
//



import SwiftUI
import CoreData

struct MatchesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "thumb == FALSE"),
        animation: .default)
    var matches: FetchedResults<Match>
    
    var gridLayout: [GridItem] {
        [GridItem(.adaptive(minimum: 100))]
    }
    
    @State var isMatchPage = false
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    Capsule()
                        .fill(Color("IndigoClair"))
                        .frame(width: geometry.size.width * 3, height: geometry.size.height * 3)
                    VStack {
                        ScrollView {
                            Section("Sélectionne tes futurs camarades de jeu") {
                                LazyVGrid(columns: gridLayout, spacing: 10) {
                                    ForEach(matches, id: \.id) { match in
                                        NavigationLink(destination: MatchView(matchDone: $isMatchPage, match: match)) {
                                            MatchesViewRow(match: match)
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                        .navigationTitle("Avec qui vas-tu jouer ?")
                    }
                }
            }
        }
    }
}

struct MatchesViewRow: View {
    var match: Match
    var body: some View {
        HStack {
            Image(match.matchedUser?.userImage ?? "defaultImage")
                .resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 130, maxHeight: 130)
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
