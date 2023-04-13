//
//  EditFavGamesList.swift
//  TeamHer
//
//  Created by Apprenant 69 on 28/03/2023.
//

import SwiftUI

struct EditFavGamesList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    
    private var favGames: FetchedResults<FavoriteGame>
    
    var user : User
    
    var userFavorite: [FavoriteGame] {
        if let favGames = user.favoriteGames as? Set<FavoriteGame> {
            return Array(favGames)
        }
        return [FavoriteGame]()
    }
    
    var body: some View {

        NavigationStack {
            
            List {
                ForEach(userFavorite){ fav in
                    NavigationLink {
                        
                        EditFavGamesDetailView(user: user, favoriteGme: fav)
                        
                    } label: {
                        Text(fav.game?.name ?? "Default")
                    }
                }
                .onDelete(perform: deleteGames)

            } //END ROWVIEW
            .listStyle(.inset)
            .navigationTitle("Jeux favoris")
            .navigationBarTitleDisplayMode(.inline)
        }//END NAVIGATIONSTACK
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
    
    private func deleteGames(offsets: IndexSet) {
        withAnimation {
            offsets.map { userFavorite[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

struct EditFavGamesList_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let viewContext = PersistenceController.preview.container.viewContext
        let user = User(context: viewContext)
        
        return EditFavGamesList(user: user)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    
    }
}


