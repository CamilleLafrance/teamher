//
//  DiscussionType.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import Foundation

enum DiscussionType : Int {
    case team, personal
}

extension DiscussionType : CaseIterable {
    var label: String {
        switch self {
        case .team:
            return "Discussions d'équipe"
        case .personal:
            return "Discussions privées"
        }
    }
}
