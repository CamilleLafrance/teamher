//
//  CatalogView.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import SwiftUI

struct CatalogView: View {
    @State private var game : [GameAPI] = []
    @State private var cover : [GameCover] = []
    @State private var artwork : [GameArtwork] = []
    @State var showGamePublisher : Bool = false
    
    @EnvironmentObject var currentGames: AllCurrentGames
    let apiCaller = IGDB_APICaller()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Section {
                    Text("Parties en cours")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(width: 390, alignment: .leading)
                    
                    VStack {
                        ScrollView (.horizontal) {
                            
                            LazyHGrid(rows: [GridItem()], spacing: 25) {
                                ForEach(currentGames.allCurrentGamesArray, id: \.self) { game in
                                    NavigationLink {
                                        GameDetail(game: game)
                                    } label :{
                                        GameCell(currentGames: game)
                                    } // NAVLINK
                                } // FOREACH
                            } // LAZYHGRID
                        } // VSTACK
                        .padding(.trailing, 20)
                        
                        Button {
                            showGamePublisher = true
                        } label: {
                            Text("Créer une partie")
                                .foregroundColor(.white)
                        }
                        .offset(x: -10)
                        .buttonStyle(.borderedProminent)
                        .padding(10)
                        
                    } // VSTACK
                } // SECTION Parties en cours
                .padding(.leading, 30)
                
                Spacer()
                
                Section {
                    ScrollView {
                        Text("Catalogue")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 360, alignment: .leading)
                        
                        Text("Notre catalogue est encore en anglais mais nous travaillons sur la traduction ! ")
                            .padding(.top, 1)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .opacity(0.8)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 400))], spacing: 20) {
                            ForEach(Array(zip(game, cover)), id: \.0) { item in
                                NavigationLink {
                                    CatalogDetail(game: item.0, cover: item.1)
                                } label : {
                                    CatalogFeaturedCell(game: item.0, cover: item.1)
                                }
                            } // FOREACH
                        } // LAZYVGRID
                        NavigationLink {
                            CatalogAllGames(cover: GameCover(url: ""))
                        } label: {
                            Text("Voir tout le catalogue")
                                .padding(20)
                        }
                    } // SCROLLVIEW
                } // SECTION CATALOGUE
                .task {
                    do {
                        game = try await apiCaller.GetGames(5)
                        cover = try await apiCaller.GetCovers(5)
                        //                      artwork = try await apiCaller.GetArtworks(5)
                    }
                    catch {
                        print("\(error)")
                    }
                } // APICALLER CURRENT GAMES TASK
                
                .navigationTitle("Let's play")
            } // SCROLLVIEW
            .sheet(isPresented: $showGamePublisher) {
                ShowPostModal(showGamePublisherModal: self.$showGamePublisher)
            }
        } // NAVSTACK
    } // BODY
} // VIEW


struct ShowPostModal: View {
    @EnvironmentObject var currentGames: AllCurrentGames
    @State var gameTitle: String = ""
    @State var gameDescription: String = ""
    @State var gameMode: String = ""
    @State var gamePlayersMin: String = ""
    @State var gamePlayersMax: String = ""
    var editorHeight: CGFloat = 220
    @State var showPopupTryAgain: Bool = false
    @State var showPopupPublished: Bool = false
    @State var messageRight: String = "Partie publiée !"
    @State var messageWrong: String = "Merci de remplir tous les champs !"
    @Binding var showGamePublisherModal : Bool
    @FocusState private var articleDescriptionIsFocused: Bool
    
    
    func checkFilled() -> Bool {
        if gameTitle.isEmpty || gameDescription.isEmpty {
            return false
        } else {
            return true
        }
    } // FUNCTION
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    VStack (alignment: .leading){
                        HStack  {
                            if gameTitle.isEmpty {
                                Image(systemName: "circle")
                                    .foregroundColor(.accentColor)
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.accentColor)
                            }
                            Text("Titre")
                                .onTapGesture {
                                    articleDescriptionIsFocused = false
                                }
                        } // HSTACK
                        .padding(.top, 15)
                        
                        Section {
                            TextField("Overwatch 2", text: $gameTitle)
                                .textFieldStyle(.roundedBorder)
                                .disableAutocorrection(true)
                                .focused($articleDescriptionIsFocused)
                        } footer: {
                            Text("50 caractères max.")
                                .foregroundColor(Color(.gray))
                                .font(.caption)
                                .frame(width: 350, height: 10, alignment: .trailing)
                                .padding(.top, 15)
                        } // SECTION
                    } // VSTACK
                    .listRowSeparator(.hidden)
                    
                    Section {
                        VStack (alignment: .leading){
                            HStack  {
                                if gamePlayersMin.isEmpty && gamePlayersMax.isEmpty {
                                    Image(systemName: "circle")
                                        .foregroundColor(.accentColor)
                                } else {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                }
                                Text("Nombre de joueurs / joueuses")
                                    .onTapGesture {
                                        articleDescriptionIsFocused = false
                                    }
                            } // HSTACK
//                            .padding(.top, 15)
                            
                            Section {
                                HStack {
                                    TextField("", text: $gamePlayersMin)
                                        .textFieldStyle(.roundedBorder)
                                        .disableAutocorrection(true)
                                        .focused($articleDescriptionIsFocused)
                                        .frame(width: 50, height: 50)
                                    Text("sur")
                                    TextField("", text: $gamePlayersMax)
                                        .textFieldStyle(.roundedBorder)
                                        .disableAutocorrection(true)
                                        .focused($articleDescriptionIsFocused)
                                        .frame(width: 50, height: 50)
                                }
//                                .offset(x: 40)
                            } // SECTION
                        } // VSTACK
                        .listRowSeparator(.hidden)
                    } // SECTION PLAYERSMINMAX
                    
                    VStack (alignment: .leading){
                        HStack  {
                            if gameMode.isEmpty {
                                Image(systemName: "circle")
                                    .foregroundColor(.accentColor)
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.accentColor)
                            }
                            Text("Mode de jeu")
                                .onTapGesture {
                                    articleDescriptionIsFocused = false
                                }
                        } // HSTACK
                        .padding(.top, 5)
                        
                        Section { // GAME MODE
                            TextField("Trio / No Build", text: $gameMode)
                                .textFieldStyle(.roundedBorder)
                                .disableAutocorrection(true)
                                .focused($articleDescriptionIsFocused)
                        } footer: {
                            Text("50 caractères max.")
                                .foregroundColor(Color(.gray))
                                .font(.caption)
                                .frame(width: 350, height: 10, alignment: .trailing)
                                .padding(.top, 15)
                        } // SECTION
                    } // VSTACK
                    .listRowSeparator(.hidden)
                    
                    Section { // GAME DESCRIPTION
                        VStack (alignment: .leading){
                            HStack  {
                                if gameDescription.isEmpty {
                                    Image(systemName: "circle")
                                        .foregroundColor(.accentColor)
                                } else {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.accentColor)
                                }
                                Text("Description")
                                    .onTapGesture {
                                        articleDescriptionIsFocused = false
                                    }
                            } // HSTACK
                            ZStack {
                                TextEditor(text: $gameDescription)
                                    .frame(height: editorHeight)
                                    .disableAutocorrection(true).focused($articleDescriptionIsFocused)
                                
                                
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(.gray), lineWidth: 0.18)
                                    .frame(width: 350, height: editorHeight, alignment: .top)
                                
                                if gameDescription.isEmpty {
                                    Text("Ex.: Rejoignez-nous pour une partie sans pression :3")
                                        .foregroundColor(Color.gray)
                                        .opacity(0.4)
                                        .padding([.top, .leading, .trailing], 8.0)
                                        .frame(width: 350, height: editorHeight, alignment: .topLeading)
                                } else {
                                    Text("")
                                } // IF ELSE
                            } // VSTACK
                        } // ZSTACK
                    } footer: {
                        Text("750 caractères max.")
                            .foregroundColor(Color.gray)
                            .font(.caption)
                            .frame(width: 350, height: 5, alignment: .trailing)
                    }
                    // SECTION
                    .listRowSeparator(.hidden)

                } // LIST
                .listStyle(.plain)
                
                Spacer()
            } // VSTACK
            .navigationTitle("Créer une partie")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showGamePublisherModal = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if checkFilled() == true {
                            currentGames.addCurrentGame(newGame: CurrentGame(name: gameTitle, image: "//images.igdb.com/igdb/image/upload/t_thumb/co1y08.jpg", mode: gameMode, playersMin: gamePlayersMin, playersMax: gamePlayersMax, description: gameDescription))
                            showPopupPublished = true
                        } else {
                            showPopupTryAgain = true
                        }
                    } label: {
                        Text("Valider")
                    }
                    .font(.title3)
                }
            }//TOOLBAR
            .alert("Merci de remplir tous les champs", isPresented: $showPopupTryAgain) {
                Button(action: {
                }) {
                    Text("OK")
                }
            } // ALERTE
            
            .alert("Ta partie a bien été publiée !", isPresented: $showPopupPublished) {
                Button(action: {
                    showGamePublisherModal = false
                    print(currentGames)
                }) {
                    Text("OK")
                } // BUTTON
            } // ALERTE
        } // NAVVIEW
    } // BODY VIEW
} // SHOWPOSTMODAL


struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
            .environmentObject(AllCurrentGames(allCurrentGamesArray: currentGamesList))
    }
}
