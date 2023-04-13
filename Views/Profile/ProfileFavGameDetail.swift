//
//  ProfileFavGameDetail.swift
//  TeamHer
//
//  Created by Camille Lafrance on 24/03/2023.
//

import SwiftUI

struct ProfileFavGameDetail: View {
    var favoriteGame : FavoriteGame
    @Binding var dismissModal : Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.accentColor)
//                    .padding(.bottom, -100)
                VStack() {
                    VStack {
                        Image(favoriteGame.game?.gameImage ?? "defaultBanner")
                            .resizable()
                            .scaledToFit()
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 10))
                    }
                    .frame(maxHeight: 300)
//                    .padding(.top, -100)
                    ScrollView {
                        VStack (alignment: .leading ) {
                            RowViewGame(label: "Identifiant", info: favoriteGame.favoriteGameUserName)
                            RowViewGame(label: "Main", info: favoriteGame.favoriteGameMain)
                            RowViewGame(label: "Rôle préféré", info: favoriteGame.favoriteGameRole)
                            RowViewGame(label: "Ce que j'aime à propos de ce jeu", info: favoriteGame.favoriteGameReview)
                        }
                        .padding(.bottom)
//                        HStack(alignment: .center) {
//
//                            Button {
//                                //
//
//                            } label: {
//                                Text("Voir dans le Catalogue")
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.white)
//                                    .background(
//                                        RoundedRectangle(cornerRadius: 15)
//                                            .foregroundColor(.blue)
//                                            .frame(width: 230, height: 65))
//                            }
//                        }//STACK BUTTON
//                        .padding(.vertical)
                    }
                }//END VSTACK TOUT
                .navigationTitle(favoriteGame.game?.gameName ?? "Default")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Retour") {
                            dismissModal = false
                        }
                        .foregroundColor(.accentColor)
                    }
                }
            }//END ZSTACK TOUT
        }
    }
}

struct ProfileFavGameDetail_Previews: PreviewProvider {
    static var previews: some View {
            let viewContext = PersistenceController.preview.container.viewContext
            let favoriteGameEx = FavoriteGame(context: viewContext)
            return ProfileFavGameDetail(
                favoriteGame: favoriteGameEx,
                dismissModal: .constant(false))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

        
    }
}

struct RowViewGame: View {
    @State var label : String = "Default"
    @State var info : String = "XXXXXXX"
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label)
                .fontWeight(.bold)
            Text(info)
//                .frame(maxWidth: 500)
        }
        .padding(.vertical)
        .foregroundColor(.white)
    }
}
