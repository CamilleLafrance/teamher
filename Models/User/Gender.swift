//
//  Gender.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import Foundation

enum Gender : Int, Identifiable {
    case female, male, nonBinary, genderFluid, intersex, nonSpecified
    var id : Self { self }
}

extension Gender: CaseIterable {
    var label: String {
        switch self {
        case .female:
            return "Femme"
        case .male:
            return "Homme"
        case .nonBinary:
            return "Non-Binaire"
        case .genderFluid:
            return "Gender fluid"
        case .intersex:
            return "Intersexe"
        case .nonSpecified:
            return "Non spécifié"
        }
    }
}
