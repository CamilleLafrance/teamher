//
//  Discussion+Extension.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import Foundation

// COMPUTED PROPERTIES
extension Discussion {
    var type: DiscussionType {
        get { return DiscussionType(rawValue: Int(self.discussionType)) ?? .personal }
        set { self.discussionType = Int16(newValue.rawValue) }
    }
    
    public override var description: String {
        return "Discussion(discussionType: \(type.label), user: \(userName), partner: \(partnerName))"
    }
    
    var userName: String {
        return self.user?.name ?? "Anonymous"
        
    }
    
    var messagesSent: [Message] {
        if let messages = self.user?.messagesSent as? Set<Message> {
            return Array(messages).filter { $0.discussion == self }
        }
        return [Message]()
    }
    
    var messagesReceived: [Message] {
        if let messages = self.user?.messagesReceived as? Set<Message> {
            return Array(messages).filter { $0.discussion == self }
        }
        return [Message]()
    }
    
    var allMessages: [Message] {
        if let messages = self.messages as? Set<Message> {
            return Array(messages).sorted { $0.dateCreated ?? Date() < $1.dateCreated ?? Date() }
        }
        return [Message]()
    }
    
    var lastMessage: String {
        allMessages.last?.content ?? ""
    }
    
    var lastDate: Date {
        allMessages.last?.dateCreated ?? Date()
    }
    
    var partner: User? {
        if messagesSent.count > 0 {
            return messagesSent[0].recipient
        } else if messagesReceived.count > 0 {
            return messagesReceived[0].author
        }
        return nil
    }
    
    var partnerName: String {
        return partner?.userAlias ?? "Alias"
    }
    
    var partnerImage: String {
        return partner?.userImage ?? "defaultImage"
    }
    
}

// METHODS
extension Discussion {
    func retrieveMatchFor(alias: String) -> Match? {
        let matchesReceived = self.user?.matchesReceived?.allObjects as! [Match]
        if let index = matchesReceived.map({ $0.matchAlias }).firstIndex(of: alias) {
            let match = matchesReceived[index]
            return match
        }
        return nil
    }
}
