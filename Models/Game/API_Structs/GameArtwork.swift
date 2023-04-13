//
//  GameArtwork.swift
//  TeamHer
//
//  Created by apprenant45 on 28/03/2023.
//

import Foundation

struct GameArtwork: Codable {
    var url: String
}

extension GameArtwork {
    enum CodingKeys: CodingKey {
        case url
    }
}
