//
//  GameCell.swift
//  TeamHer
//
//  Created by apprenant45 on 27/03/2023.
//

import SwiftUI

struct GameCell: View {
    var currentGames: CurrentGame
    
    var coverURL : String { currentGames.image.replacing("//", with: "https://").replacing("thumb", with: "720p") }

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: coverURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(width: 150, height: 200)
            .cornerRadius(10)
//            Text(currentGame.name)
//                .font(.title3)
//                .fontWeight(.bold)
//                .frame(maxWidth: 140)
                
        }
    }
}

struct GameCell_Previews: PreviewProvider {
    static var previews: some View {
        GameCell(currentGames: fortnite)
    }
}
