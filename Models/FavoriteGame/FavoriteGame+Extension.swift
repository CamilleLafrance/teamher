//
//  FavoriteGame+Extension.swift
//  TeamHer
//
//  Created by Camille Lafrance on 24/03/2023.
//

import Foundation

extension FavoriteGame {
    var favoriteGameMain: String {
        return main ?? "Non spécifié"
    }
    
    var favoriteGameReview: String {
        return review ?? "..."
    }
    
    var favoriteGameRole: String {
        return role ?? "Non spécifié"
    }
    
    var favoriteGameUserName: String {
        return userName ?? "Nom"
    }
}
