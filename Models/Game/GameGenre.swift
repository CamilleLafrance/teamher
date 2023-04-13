//
//  GameGenre.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import Foundation

enum GameGenre : Int {
    case pvp, fps, pointAndClick, action, adventure, rpg, simulation, strategy, nonSpecified
}

extension GameGenre: CaseIterable {
    var label: String {
        switch self {
        case .pvp:
            return "PvP"
        case .fps:
            return "FPS"
        case .pointAndClick:
            return "Point and click"
        case .action:
            return "Action"
        case .adventure:
            return "Aventure"
        case .rpg:
            return "Jeux de rôles"
        case .simulation:
            return "Simulation"
        case .strategy:
            return "Stratégie"
        case .nonSpecified:
            return "Non spécifié"
        }
    }
}
