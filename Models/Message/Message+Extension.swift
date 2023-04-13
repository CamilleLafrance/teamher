//
//  Message+Extension.swift
//  TeamHer
//
//  Created by Camille Lafrance on 24/03/2023.
//

import Foundation
import SwiftUI

extension Message {
    var messageContent: String {
        return content ?? "Message..."
    }
    
    var authorName: String {
        self.author?.userName ?? "Anonymous"
    }
}
