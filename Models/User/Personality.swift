//
//  Personality.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import Foundation

enum Personality : Int, Identifiable {
    case active, careful, cheerful, creative, goofball, hotHeaded, selfAssured, adventurous, perfectionist, ambitious, clumsy, lazy, overachiever, loner, strategist, outgoing, introvert, reactive, nonSpecified
    var id : Self { self }
}

extension Personality: CaseIterable {
    var label: String {
        switch self {
        case .active:
            return "Actif.ve"
        case .careful:
            return "Prudent.e"
        case .cheerful:
            return "Joyeux.se"
        case .creative:
            return "Créatif.ve"
        case .goofball:
            return "Blagueur.se"
        case .hotHeaded:
            return "Tête brûlée"
        case .selfAssured:
            return "Confiant.e"
        case .adventurous:
            return "Aventureux.se"
        case .perfectionist:
            return "Perfectionniste"
        case .ambitious:
            return "Ambitieux.se"
        case .clumsy:
            return "Maladroit.e"
        case .lazy:
            return "Paresseux.se"
        case .overachiever:
            return "Jusqu'au-boutiste"
        case .loner:
            return "Solitaire"
        case .strategist:
            return "Stratège"
        case .outgoing:
            return "Extraverti.e"
        case .introvert:
            return "Introverti.e"
        case .reactive:
            return "Réactif.ve"
        case .nonSpecified:
            return "Non spécifié"
        }
    }
}
