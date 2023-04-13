//
//  ProfileView.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import CoreData
import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [], predicate: NSPredicate(format: "name == 'Magalie'"),
        animation: .default)
    private var users: FetchedResults<User>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)    
    private var favGames: FetchedResults<FavoriteGame>
    
    var levelOfRecommendation : Int {
        return 4
    }
    
    var user : User { users[0] }
    
    var favoriteGames: [FavoriteGame] {
        if let favGames = user.favoriteGames as? Set<FavoriteGame> {
            return Array(favGames)
        }
        return [FavoriteGame]()
        
    }
    @State var showModalEdit : Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView(.vertical) {
                VStack { // TOUTE LA PAGE}
                    VStack { // HAUT DE PAGE
                        ZStack { //BANNIERE + NOM
                            Image(user.banner ?? "ex1")
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
                                    Text("\(levelOfRecommendation)")
                                        .foregroundColor(.white)
                                        .fontWeight(.light)
                                        .font(.headline)
                                        .background(
                                            Circle()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.accentColor)
                                                .overlay (
                                                    Circle ().stroke(Color.blue, lineWidth: 4))
                                            
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
                            ProfileInfoRowView(label: "Genre", info: "\(user.userGender.label)")
                            Divider()
                            ProfileInfoRowView(label: "Pronom", info: "\(user.userPronoun)")
                            Divider()
                            ProfileInfoRowView(label: "Ville", info: "\(user.userLocation)")
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
                                ProfilePersonalityView(info: "\(user.userPersonality1.label)")
                                ProfilePersonalityView(info: "\(user.userPersonality2.label)")
                                ProfilePersonalityView(info: "\(user.userPersonality3.label)")
                            }//END HSTACK PERSONNALITE
                            .padding(.horizontal)
                        }
                        .padding(.leading, 35)
                    }//END VSTACK PERSONNALITE
                    .padding(.top)
                    VStack { //VGAMES
                        if !favoriteGames.isEmpty {
                            Text("Jeux favoris")
                                .font(.title3)
                                .padding(.bottom, 10)
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(favoriteGames, id: \.self) { favoriteGame in
                                        ProfileGameCellView(favoriteGame: favoriteGame/*, modalGame: $showModalGame*/)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .padding(.horizontal, 20)
                        }
                    }// END VSTACK GAMES
                    .padding(.bottom, 30)
                } //VSTACK TOUTE LA PAGE
                .navigationTitle("Mon profil")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button { showModalEdit = true }
                        label: { Text("Modifier") }
                        .sheet(isPresented: $showModalEdit) {
                            EditProfileView(user: user, dismissModal: $showModalEdit)
                        }//SHEET
                    }//TOOLBAR
                }//TOOLBAR
            } //END SCROLLVIEW
        }//END NAV STACK  
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
