//
//  Game+Extension.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import Foundation

extension Game {
    var gameGenre: GameGenre {
        get { return GameGenre(rawValue: Int(self.genre)) ?? .nonSpecified }
        set { self.genre = Int16(newValue.rawValue) }
    }

    var gamePlatform: Platform {
        get { return Platform(rawValue: Int(self.platform)) ?? .nonSpecified }
        set { self.platform = Int16(newValue.rawValue) }
    }

    var gameImage: String {
        return image ?? "DefaultImage"
    }

    var gameMap: String {
        return map ?? "Non spécifié"
    }

    var gameName: String {
        return name ?? "Nom"
    }

    var gamePublisher: String {
        return publisher ?? "Editeur"
    }

    var gameURL: String {
        return url ?? ""
    }
}
