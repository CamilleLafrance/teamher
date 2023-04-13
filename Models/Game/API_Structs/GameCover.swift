//
//  GameCover.swift
//  TeamHer
//
//  Created by apprenant45 on 27/03/2023.
//

import Foundation

struct GameCover: Codable, Hashable {
    var url: String
}

extension GameCover {
    enum CodingKeys: CodingKey {
        case url
    }
}
