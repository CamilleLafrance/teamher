//
//  GameAPIModel.swift
//  TeamHer
//
//  Created by apprenant45 on 27/03/2023.
//

import Foundation
import CoreData

struct GameAPI: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var summary: String
    var rating: Double?
    var url: String  
}

extension GameAPI {
    enum CodingKeys: CodingKey {
        case name, summary, rating, url
    }
}

