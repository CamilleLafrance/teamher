//
//  CatalogFeaturedCell.swift
//  TeamHer
//
//  Created by apprenant45 on 27/03/2023.
//

import SwiftUI

struct CatalogFeaturedCell: View {
    
    var game: GameAPI
    var cover: GameCover
    var coverURL : String { cover.url.replacing("//", with: "https://").replacing("thumb", with: "720p") }
//    var artwork: GameArtwork
//    var artworkURL : String { artwork.url.replacing("//", with: "https://").replacing("thumb", with: "720p") }
    
    var cornerRadius: CGFloat = 20
    var minSize: CGFloat = 270
    var maxSize: CGFloat = 350
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(Color("IndigoClair"))
                .frame(minWidth: maxSize, maxWidth: maxSize, minHeight: minSize, maxHeight: maxSize)
                .fixedSize(horizontal: true, vertical: true)
            
            AsyncImage(url: URL(string: coverURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(width: maxSize, height: 130)
            .cornerRadius(cornerRadius, corners: [.topLeft, .topRight])
            .fixedSize(horizontal: true, vertical: true)
            .offset(y: -75)
            
            VStack (alignment: .leading){
                Text(game.name)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .underline()
                    .frame(maxWidth: maxSize, maxHeight: 175,
                           alignment: .topLeading)
                    .fixedSize(horizontal: true, vertical: true)
//                    .offset(y: 80)
                    
                Text("\(Int(game.rating ?? 50))/100")
                    .foregroundColor(.black)
                    .frame(maxWidth: 330, maxHeight: 100, alignment: .topLeading)
                    .fixedSize(horizontal: true, vertical: true)
                    .padding(.top, 3)
//                    .offset(y: 75)
                    .italic()
            
                Text(game.summary)
                    .foregroundColor(.black)
                    .frame(maxWidth: 330, maxHeight: 175, alignment: .topLeading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 3)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
//                    .offset(y: 65)
            }
            .padding([.leading, .trailing], 30)
            .padding(.top, 50)
            .offset(y: 35)
        }
    }
}

struct CatalogFeaturedCell_Previews: PreviewProvider {
    static var previews: some View {
        CatalogFeaturedCell(game: GameAPI(name: "League of Legends", summary: "Choose from a selection of 9 classes, each with entertaining personalities and a different set of gameplay mechanics, to capture or defend the objective within numerous game modes against the enemy team, with a variety of unlockable and tradable weapons and cosmetics which add a layer of customization to each player\'s experience.", rating: 75, url: "https://www.igdb.com/games/league-of-legends"), cover: GameCover(url: "//images.igdb.com/igdb/image/upload/t_thumb/co1hxc.jpg"))
    }
}

