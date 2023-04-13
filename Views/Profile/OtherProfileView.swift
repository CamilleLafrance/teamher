//
//  OtherProfileView.swift
//  TeamHer
//
//  Created by Apprenant 69 on 24/03/2023.
//

import SwiftUI

struct OtherProfileView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var users: FetchedResults<User>

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var favGames: FetchedResults<FavoriteGame>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)    
    private var discussions: FetchedResults<Discussion>
    
    var allDiscussions: [Discussion] {
        discussions.map { $0 }
    }
    
    var discussion : Discussion? { match.getDiscussion(in: allDiscussions)}
    
    var profile: User {
        users.map { $0 }.filter { $0.userName == "Magalie" }[0]
    }
    
    var match: Match
    var recommendationNumber : Int = 4
    @State var showModalGame : Bool = false
    
    var user : User {
        match.getUser(in: users.map {$0}) ?? User(context: viewContext)
    }
    
    var favoriteGames: [FavoriteGame] {
        if let favGames = user.favoriteGames as? Set<FavoriteGame> {
            return Array(favGames)
        }
        return [FavoriteGame]()
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack { // TOUTE LA PAGE}
                VStack { // HAUT DE PAGE
                    ZStack { //BANNIERE + NOM
                        Image(user.userBanner)
                            .resizable()
                            .clipShape(Rectangle())
                            .frame(width: 390, height: 150)
                            .padding(.bottom, 100)
                        HStack (alignment: .bottom){ //IMAGE PROFIL + PRENOM
                            ZStack { //PHOTO PROFIL + RECO SCORE
                                Image(user.userImage)
                                    .resizable()
                                    .frame(maxWidth: 150, maxHeight: 150)
                                    .clipShape(Circle()) 
                                Text("\(recommendationNumber)")
                                    .foregroundColor(.white)
                                    .fontWeight(.light)
                                    .font(.headline)
                                    .background(
                                        Circle()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.accentColor)
                                            .overlay (
                                                Circle ()            .stroke(Color.blue, lineWidth: 4))
                                    )
                                    .padding([.top, .leading], 105.0)
                            }//END ZSATCK PHOTO PROFIL
                            VStack (alignment: .leading) { //NOM ET ALIAS
                                Text(user.userName)
                                    .font(.headline)
                                    .padding(.vertical, 2.0)
                                    .foregroundColor(.accentColor)
                                Text(user.userAlias)
                                    .foregroundColor(.secondary)
                            }// END VSTACK NOM ET ALIAS
                            .padding(.leading, 40)
                        }//HSTACK IMAGE PROFIL + PRENOM
                        .padding([.top, .leading, .trailing], 30.0)
                    }// END ZSTACK
                } //END VSTACK HAUT DE PAGE
                VStack(alignment: .leading) { // DESCRIPTION
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.headline)
                            .padding(.bottom, 1)
                        Text(user.descriptionUser)
                            .fontWeight(.light)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 40)
                    VStack { //INFOS
                        ProfileInfoRowView(label: "Age", info: "\(user.age)")
                        Divider()
                        ProfileInfoRowView(label: "Genre", info: user.userGender.label)
                        Divider()
                        ProfileInfoRowView(label: "Pronom", info: user.userPronoun)
                        Divider()
                        ProfileInfoRowView(label: "Ville", info: user.userLocation)
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical)
                } //END VSTACK DESCRIPTION + INFO
                VStack (alignment: .center) {//PERSONNALITE
                    Text("Personnalité")
                        .font(.title3)
                        .padding(.bottom, -9.0)
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            //PERSONNALITE
                            ProfilePersonalityView(info: user.userPersonality1.label)
                            ProfilePersonalityView(info: user.userPersonality2.label)
                            ProfilePersonalityView(info: user.userPersonality3.label)
                        }//END HSTACK PERSONNALITE
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .padding(.leading, 20)
                }//END VSTACK PERSONNALITE
                .padding(.top)
                
                VStack { //VGAMES
                    if !favoriteGames.isEmpty {
                        Text("Jeux")
                            .font(.title3)
                            .padding(.bottom, 10)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(favoriteGames, id: \.self) { favoriteGame in
                                    ProfileGameCellView(favoriteGame: favoriteGame)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.horizontal, 20)
                    }
                }// END VSTACK GAMES
                .padding(.bottom, 30)
                NavigationLink { //RECOMMANDER BUTTON
                    RecommendListView()
                } label: {
                    HStack {
                        Text("Recommander")
                            .fontWeight(.heavy)
                        Image(systemName: "sparkles")
                    }
                    .font(.title3)
                    .foregroundColor(.white)
                }
                .frame(width: 220, height: 60)
                .foregroundColor(Color.white)
                .background(Color("AccentColor"))
                .cornerRadius(20)
            } //VSTACK TOUTE LA PAGE
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { //ENVOYER MESSAGE
                    NavigationLink {
                        MessagesDetailView(discussion: discussion, user: profile, match: match)
                    } label: {
                        Image(systemName: "paperplane")
                    }
                }//TOOLBAR
                ToolbarItem(placement: .navigationBarTrailing) { //SIGNALER
                    ReportView()
                }//TOOLBAR
            }//TOOLBAR
        }
    }
}

struct OtherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let match = Match(context: viewContext)
        return OtherProfileView(match: match).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
