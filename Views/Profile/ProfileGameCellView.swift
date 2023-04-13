//
//  ProfileGameCellView.swift
//  TeamHer
//
//  Created by Apprenant 69 on 24/03/2023.
//

import SwiftUI

struct ProfileGameCellView: View {    
    var favoriteGame : FavoriteGame
    @State private var modalGame : Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            Button {
                modalGame = true
            } label: {
                VStack {
                    Image(favoriteGame.game?.image ?? "defaultBanner")
                        .resizable()
                        .scaledToFit()
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 20))
                .frame(maxWidth: 250, maxHeight: 180)
            }
            .sheet(isPresented: $modalGame) {
                ProfileFavGameDetail(favoriteGame: favoriteGame, dismissModal: $modalGame)
            }
            Text(favoriteGame.game?.name ?? "Default")
        }
        .padding(.bottom)
    }
}

struct ProfileGameCellView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let favoriteGameEx = FavoriteGame(context: viewContext)
        
        
        return ProfileGameCellView(
            favoriteGame: favoriteGameEx)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
