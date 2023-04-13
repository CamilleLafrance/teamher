//
//  User+Extension.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import Foundation

extension User {
    var userGender: Gender {
        get { return Gender(rawValue: Int(self.gender)) ?? .nonSpecified }
        set { self.gender = Int16(newValue.rawValue) }
    }
    
    var userPersonality1 : Personality {
            get { return Personality(rawValue: Int(self.personality1)) ?? .nonSpecified }
            set { self.personality1 = Int16(newValue.rawValue) }
        }

    var userPersonality2 : Personality {
        get { return Personality(rawValue: Int(self.personality2)) ?? .nonSpecified }
        set { self.personality2 = Int16(newValue.rawValue) }
    }

    var userPersonality3 : Personality {
        get { return Personality(rawValue: Int(self.personality3)) ?? .nonSpecified }
        set { self.personality3 = Int16(newValue.rawValue) }
    }
    
    var userName: String {
        return name ?? "Nom"
    }
    
    var userAlias: String {
        return alias ?? "Alias"
    }
    
    var userImage: String {
        return image ?? "defaultImage"
    }
    
    var userBanner: String {
        return banner ?? "defaultBanner"
    }
    
    var userLocation: String {
        return location ?? "Non spécifié"
    }
    
    var userPronoun: String {
        return pronoun ?? "Non spécifié"
    }
    
    var descriptionUser: String {
        return userDescription ?? "Non spécifié"
    }
    
}
