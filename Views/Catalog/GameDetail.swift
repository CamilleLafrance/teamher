//
//  GameDetail.swift
//  TeamHer
//
//  Created by apprenant45 on 27/03/2023.
//

import SwiftUI

struct GameDetail: View {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    var matches: FetchedResults<Match>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var discussions: FetchedResults<Discussion>
    
    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "name == 'Magalie'"),
        animation: .default)
    private var users: FetchedResults<User>
    
    var allDiscussions: [Discussion] {
        discussions.map { $0 }
    }

    var discussion : Discussion? { match?.getDiscussion(in: allDiscussions)}

    var user : User {
        users[0]
    }

    var match: Match? {
            if let matches = user.matchesReceived  as? Set<Match> {
                return Array(matches).filter { $0.matchAlias == "Penny09" }[0]
            }
            return Match()
        }
    
    var game: CurrentGame
    var coverURL : String { game.image.replacing("//", with: "https://").replacing("thumb", with: "720p") }
    var vertPadding: CGFloat = 2
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("IndigoClair")
                    .ignoresSafeArea()
                VStack {
                    AsyncImage(url: URL(string: coverURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 150, height: 200)
                    .cornerRadius(15, corners: .allCorners)
                    .padding(.top, 10)
                    //                Spacer()
                    
                    Section {
                        Text("Nombre de joueurs / joueuses")
                            .fontWeight(.bold)
                            .underline()
                            .padding(.vertical, vertPadding)
                            .frame(width: 370, alignment: .leading)
                        
                        Text("\(game.playersMin) sur \(game.playersMax)")
                            .frame(width: 370, alignment: .leading)
                            .padding(.vertical, vertPadding)
                        
                        Text("Mode de jeu")
                            .fontWeight(.bold)
                            .underline()
                            .padding(.vertical, vertPadding)
                            .frame(width: 370, alignment: .leading)
                        
                        Text(game.mode)
                            .frame(width: 370, alignment: .leading)
                            .padding(.vertical, vertPadding)
                        
                        Text("Description")
                            .fontWeight(.bold)
                            .underline()
                        //                        .padding(5)
                            .frame(width: 370, alignment: .leading)
                        
                        Text(game.description)
                            .padding(.vertical, vertPadding)
                            .frame(width: 370, alignment: .leading)
                    }
                    .offset(y: 20)
                    
                    Spacer()
                    if game.image != "//images.igdb.com/igdb/image/upload/t_thumb/co1y08.jpg" {
                        NavigationLink {
                            
                            MessagesDetailView( discussion: discussion, user: user, match: match)
                            
                        } label: {
                            HStack {
                                Text("Contacter")
                                    .fontWeight(.heavy)
                            }
                            .font(.title3)
                            .foregroundColor(.white)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.accentColor)
                                .frame(width: 180, height: 65)
                        ) //  BUTTON
                    } else {
                        HStack {
                            Text("Tu as créé cette partie")
                                .fontWeight(.heavy)
                        }
                        .font(.title3)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.accentColor)
                                .frame(width: 350, height: 65)
                        )
                    }
                    
                    Spacer()
                }
                .navigationTitle(game.name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        GameDetail(game: fortnite).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
