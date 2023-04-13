//
//  CurrentGameModel.swift
//  TeamHer
//
//  Created by apprenant45 on 28/03/2023.
//

import Foundation

class CurrentGame: Identifiable, ObservableObject, Hashable {
    static func == (lhs: CurrentGame, rhs: CurrentGame) -> Bool {
        return lhs.name == rhs.name /*&& lhs.image == rhs.image*/
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
//        hasher.combine(image)
    }
    
    init(name: String, image: String, mode: String, playersMin: String, playersMax: String, description: String) {
        self.name = name
        self.image = image
        self.mode = mode
        self.playersMin = playersMin
        self.playersMax = playersMax
        self.description = description
    }
    
    var id = UUID()
    var name: String
    var image: String
    var mode: String
    var playersMin: String
    var playersMax: String
    var description: String
    
}

var apex = CurrentGame(name: "Apex Legends", image: "//images.igdb.com/igdb/image/upload/t_thumb/co1wzo.jpg", mode: "Duo", playersMin: "1", playersMax: "3", description: "Salut, je commence tout juste Apex et je galère un peu, j'aurais bien besoin d'une team safe :)")

var fortnite = CurrentGame(name: "Fortnite", image: "//images.igdb.com/igdb/image/upload/t_thumb/co2ekt.jpg", mode: "Team / No build", playersMin: "2", playersMax: "4", description: "Coucou on est deux filles et on adore Fortnite en no build, qui nous rejoint ? :)")

var valorant = CurrentGame(name: "Valorant", image: "//images.igdb.com/igdb/image/upload/t_thumb/co2mvt.jpg", mode: "Competitive", playersMin: "3", playersMax: "5", description: "Team confirmée mais on peut ajouter des gens avec plaisir")

var among = CurrentGame(name: "Among Us", image: "//images.igdb.com/igdb/image/upload/t_thumb/co45rg.jpg", mode: "Online", playersMin: "6", playersMax: "15", description: "Who is the impostor ? 👀")

var genshin = CurrentGame(name: "Genshin Impact", image: "//images.igdb.com/igdb/image/upload/t_thumb/co480t.jpg", mode: "", playersMin: "0", playersMax: "2", description: "Je recherche une personne pour m'aider à battre un boss pls")

var league = CurrentGame(name: "League Of Legends", image: "//images.igdb.com/igdb/image/upload/t_thumb/co49wj.jpg", mode: "ARAM", playersMin: "0", playersMax: "5", description: "Hello, je suis une noob mais j'aimerais m'améliorer :3")

var rocket = CurrentGame(name: "Rocket League", image: "//images.igdb.com/igdb/image/upload/t_thumb/co4ut4.jpg", mode: "Soccar", playersMin: "0", playersMax: "3", description: "Vroumvrrrroum qui veut rouler ? 🤣")

var fallGuys = CurrentGame(name: "Fall guys", image: "//images.igdb.com/igdb/image/upload/t_thumb/co4vs3.jpg", mode: "", playersMin: "10", playersMax: "60", description: "Pour une partie sans pression !")

var overwatch = CurrentGame(name: "Overwatch 2", image: "//images.igdb.com/igdb/image/upload/t_thumb/co5tkm.jpg", mode: "Assault", playersMin: "3", playersMax: "5", description: "Hello je peux aider des débutant.es !")

var dota = CurrentGame(name: "Dota 2", image: "//images.igdb.com/igdb/image/upload/t_thumb/co68l6.jpg", mode: "Ranked All Picked", playersMin: "2", playersMax: "5", description: "Débutantes dans Dota recherchent partenaires de jeu !")

var baldur = CurrentGame(name: "Baldur's Gate", image: "", mode: "Multiplayer", playersMin: "1", playersMax: "4", description: "Hellooo je connais pass le jeu mais trop envie d'y jouer. Qui veut m'aider ? :p")


class AllCurrentGames: Identifiable, ObservableObject {
    internal init(allCurrentGamesArray: [CurrentGame]) {
        self.allCurrentGamesArray = allCurrentGamesArray
    }

    @Published var allCurrentGamesArray: [CurrentGame]

    func addCurrentGame(newGame: CurrentGame) {

        allCurrentGamesArray.insert(newGame, at: 0)

    }
}

var currentGamesList = [apex, fortnite, valorant, among, genshin, league, rocket, fallGuys, overwatch, dota]
