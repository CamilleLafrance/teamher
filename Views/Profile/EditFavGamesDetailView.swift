//
//  EditFavGamesDetailView.swift
//  TeamHer
//
//  Created by Apprenant 69 on 28/03/2023.
//

import SwiftUI

struct EditFavGamesDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentationMode
    
    // Fetch Favorite Game
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    
    private var favGames: FetchedResults<FavoriteGame>
    
    // Fetch User
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    
    private var users: FetchedResults<User>
    
    var user : User
    
    var userFavorite: [FavoriteGame] {
        if let favGames = user.favoriteGames as? Set<FavoriteGame> {
            return Array(favGames)
        }
        return [FavoriteGame]()
    }
    
    var favoriteGme : FavoriteGame
    
    var body: some View {
        NavigationStack {
            
            List {
                RowViewGamesDetail(label: "Identifiant", info: favoriteGme.favoriteGameUserName)
                RowViewGamesDetail(label: "Main", info: favoriteGme.favoriteGameMain)
                RowViewGamesDetail(label: "Rôle préféré", info: favoriteGme.favoriteGameRole)
                RowViewGamesDetail(label: "Ce que j'en pense", info: favoriteGme.favoriteGameReview)
                    
            }//END ROWVIEW
            .listStyle(.inset)
            .navigationTitle(favoriteGme.game?.name ?? "Default Game Name")
            .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                HStack {
                    Button("Annuler") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: 110.0, height: 35)
                    .border(Color("AccentColor"), width: 1)
                    .cornerRadius(10)
                    Spacer()
                    Button("Enregistrer") {
                        if viewContext.hasChanges {
                            try? self.viewContext.save()
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: 110.0, height: 35)
                    .foregroundColor(Color.white)
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                }.padding()
            }
            .padding(.bottom, 450.0)
            
        }//END NAVIGATIONSTACK
    }
}

struct EditFavGamesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let favoriteGameEx = FavoriteGame(context: viewContext)
        let user = User(context: viewContext)
        
        return EditFavGamesDetailView(
            user: user, favoriteGme: favoriteGameEx)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct RowViewGamesDetail: View {
    
    var label : String = "Default"
    
    @State var info : String = "..."
    
    var body: some View {
        
        HStack { //ROWVIEW
            Text(label)
            
            TextField("", text: $info)
                .foregroundColor(.secondary)
                .padding(.leading)
                .frame(maxHeight: 200)
                .lineLimit(15, reservesSpace: true)
            
            Spacer()
            if !info.isEmpty {
                Button {
                    info = ""
                }label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

// Cette structure sert-elle ?
struct DescriptionGamesExtractedView: View {
    
    var label : String = "Default"
    
    @State var info : String = "X"
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            Text(label)
            
            HStack {
                
                TextEditor(text: $info)
                    .foregroundColor(.secondary)
                    .padding(.leading)
                    .frame(width: 280, height: 100)
                    .lineLimit(15, reservesSpace: true)
                
                Spacer()
                
                if !info.isEmpty {
                    Button {
                        
                        info = ""
                        
                    }label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.secondary)
                    } //BOUTON EFFACER
                }// IF POUR AFFICHER BOUTON
            }//STACK
        } //VSTACK
    }
}
