//
//  PlayerType.swift
//  tictactoe
//
//  Created by Justin Rose on 4/17/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

enum PlayerType {
    case ai, human
    
    var next: PlayerType { return self == .ai ? .human : .ai }
    var isAI: Bool { return self == .ai }
    var isHuman: Bool { return self == .human }
    var marker: Marker {
        switch self {
        case .ai: return .ai
        case .human: return .human
        }
    }
}
