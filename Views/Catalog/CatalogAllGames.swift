//
//  CatalogAllGames.swift
//  TeamHer
//
//  Created by apprenant45 on 28/03/2023.
//

import SwiftUI

struct CatalogAllGames: View {
    
    let apiCaller = IGDB_APICaller()
    
    @State var game : [GameAPI] = []
    @State var coverArray : [GameCover] = []
    @State var cover : GameCover
    var coverURL : String { cover.url.replacing("//", with: "https://").replacing("thumb", with: "720p") }
    
    @State private var searchText = ""
    
    var gameSearchResults: [GameAPI] {
        if searchText.isEmpty {
            return game
        } else {
            return game.filter {  $0.name.contains(searchText)  }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("IndigoClair")
                    .ignoresSafeArea()
                List {
                    ForEach(gameSearchResults) { item in
                        NavigationLink {
                            CatalogDetail(game: item, cover: GameCover(url: "\(coverURL)"))
                        } label : {
                            Text(item.name)
                                .lineLimit(1)
                        }
                    } // FOR EACH
                } // LIST
                .background(Color("IndigoClair"))
                .scrollContentBackground(.hidden)
                .navigationTitle("Catalogue")
            }
            .task {
                do {
                    game = try await apiCaller.GetGamesAlpha(42)
                    coverArray = try await apiCaller.GetCovers(42)
                }
                catch {
                    print("\(error)")
                }
            } // APICALLER CURRENT GAMES TASK
        } // NAVIGATION STACK
        .searchable(text: $searchText)
    }
}

struct CatalogAllGames_Previews: PreviewProvider {
    static var previews: some View {
        CatalogAllGames(cover: GameCover(url: "//images.igdb.com/igdb/image/upload/t_thumb/co1hxc.jpg"))
    }
}
