//
//  CatalogDetail.swift
//  TeamHer
//
//  Created by apprenant45 on 27/03/2023.
//

import SwiftUI

struct CatalogDetail: View {
    
    var game : GameAPI
    var cover : GameCover
//    @State var artwork : [GameArtwork] = []
    
    var coverURL : String { cover.url.replacing("//", with: "https://").replacing("thumb", with: "720p") }
    
    let apiCaller = IGDB_APICaller()
    
    var body: some View {
        ZStack {
            Color("IndigoClair")
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    Text(game.name)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.bottom, 8)
                        .multilineTextAlignment(.center)
                    
                    HStack{
//                        Text("Note de difficulté :")
//                            .italic()
//                            .fontWeight(.semibold)
                        Text("\(Int(game.rating ?? 50))/100")
                    }
                    .italic()
                    
                    Text(game.summary)
                        .padding(30)
                    
                    Text("Pour plus d'informations:")
                    
                    Link("Lien IGDB",
                         destination: URL(string: game.url)!)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    
                }
            }
        }

    }
}

struct CatalogDetail_Previews: PreviewProvider {
    static var previews: some View {
        CatalogDetail(game: GameAPI(name: "League of Legends", summary: "Enter the land of TowerFall with your friends and engage in the noble and brutal tradition of bow-and-arrow combat. TowerFall is an archery combat platformer for 1-4 players, with an arcade co-op mode and hilarious, intense versus matches. The core mechanics are simple and accessible, but combat is fast and fierce. The focus is on player mastery and friendly rivalry.\n \n TowerFall Ascension is an enhanced version of the original Ouya release.TowerFall Ascension was initially released on PlayStation 4 and Windows, through Steam, in March 2014, with Mac and Linux versions available soon after.A Vita and Xbox One version have also been released.\n \n The original Ouya game was eventually updated with Ascension's content in August 2014, according to the archived page, but the page's release date was later changed to November 2016. \n \n A Nintendo Switch version of the game, under the original title of TowerFall, was released in 2018 with all the content from Acension and the Dark World expansion as well as some new exclusive features and updates.", url: "https://www.igdb.com/games/league-of-legends"), cover: GameCover(url: "//images.igdb.com/igdb/image/upload/t_thumb/co49wj.jpg"))
    }
}
