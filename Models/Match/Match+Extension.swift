//
//  Match+Extension.swift
//  TeamHer
//
//  Created by Imen Ksouri on 25/03/2023.
//

import CoreData
import Foundation

// COMPUTED PROPERTIES
extension Match {
    
    var matchAlias: String {
        return self.matchedUser?.userAlias ?? "Anonymous"
    }
    
    var matchName: String {
        return self.matchedUser?.userName ?? "Anonymous"
    }
    
    var matchImage: String {
        return self.matchedUser?.userImage ?? "defaultImage"
    }
    
    public override var description: String {
        return "Match(Match: \(matchAlias))"
    }
}

// METHODS
extension Match {
    func getDiscussion(in discussions: [Discussion]) -> Discussion? {
        if let index = discussions.map ({ $0.partnerName }).firstIndex(of : self.matchAlias) {
            let discussion = discussions[index]
            return discussion
        }
        return nil
    }
    
    func getUser(in users: [User]) -> User? {
        if let index = users.map ({ $0.userAlias }).firstIndex(of : self.matchAlias) {
            let user = users[index]
            return user
        }
        return nil
    }
    
}
