//
//  Platform.swift
//  TeamHer
//
//  Created by Imen Ksouri on 24/03/2023.
//

import Foundation

enum Platform : Int {
    case windows, playStation, xBox, nintendoSwitch, macOs, mobile, playStationVR, oculus, nonSpecified
}

extension Platform: CaseIterable {
    var label: String {
        switch self {
        case .windows:
            return "Windows"
        case .playStation:
            return "PlayStation"
        case .xBox:
            return "XBox"
        case .nintendoSwitch:
            return "Nintendo Switch"
        case .macOs:
            return "MacOS"
        case .mobile:
            return "Mobile"
        case .playStationVR:
            return "PlayStationVR"
        case .oculus:
            return "Oculus"
        case .nonSpecified:
            return "Non spécifié"
        }
    }
}
