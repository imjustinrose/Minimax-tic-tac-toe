//
//  AI.swift
//  tictactoe
//
//  Created by Justin Rose on 4/17/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

class AI: Player {
    func maximize(_ newBoard: [Marker], with depth: Int) -> Int {
        var newBoard = newBoard
        var bestScore = -10_000
        
        for spot in board.availableSpots(of: newBoard) {
            newBoard[spot] = .ai
            bestScore = max(bestScore, minimax(newBoard, depth: depth-1, player: .human))
            newBoard[spot] = .none
        }
        
        return bestScore
    }
    
    func minimize(_ newBoard: [Marker], with depth: Int) -> Int {
        var newBoard = newBoard
        var bestScore = 10_000
        
        for spot in board.availableSpots(of: newBoard) {
            newBoard[spot] = .human
            bestScore = min(bestScore, minimax(newBoard, depth: depth-1, player: .ai))
            newBoard[spot] = .none
        }
        
        return bestScore
    }
    
    func minimax(_ newBoard: [Marker], depth: Int, player: PlayerType) -> Int {
        let spots = board.availableSpots(of: newBoard)
        
        if board.winner(is: .ai, of: newBoard) { return 10 }
        if board.winner(is: .human, of: newBoard) { return -10 }
        if depth == 0 { return 0 }
        guard !spots.isEmpty else { return 0 }
        
        return player == .ai ? maximize(newBoard, with: depth) : minimize(newBoard, with: depth)
    }
    
    func findBestMove(_ newBoard: [Marker]) -> Int {
        var newBoard = newBoard
        var optimal: (value: Int, move: Int) = (-1_000, -1_000)
        
        for spot in board.availableSpots(of: newBoard) {
            newBoard[spot] = .ai
            let moveValue = minimax(newBoard, depth: 5, player: .human)
            newBoard[spot] = .none
            
            if moveValue > optimal.value {
                optimal.move = spot
                optimal.value = moveValue
            }
        }
        
        return optimal.move
    }
}
