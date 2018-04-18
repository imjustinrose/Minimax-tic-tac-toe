//
//  Board.swift
//  tictactoe
//
//  Created by Justin Rose on 4/17/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

class Board {
    var board = [Marker](repeating: .none, count: 9)
    var count: Int { return board.count }
    
    var markerPlaced: (() -> Void)?
    var hasWinner: ((PlayerType) -> Void)?
    var isDraw: (() -> Void)?
    
     func place(_ marker: Marker, at location: Int) {
        guard 0 ..< board.count ~= location else { return }
        board[location] = marker
        markerPlaced?()
        checkState()
    }
    
    func availableSpots(of board: [Marker]) -> [Int] {
        return board.enumerated().filter { $0.element == .none }.map { $0.offset }
    }
    
    func winner(is player: PlayerType, of board: [Marker]) -> Bool {
        let player = player.marker
        
        return ((board[0] == player && board[1] == player && board[2] == player) ||
                (board[3] == player && board[4] == player && board[5] == player) ||
                (board[6] == player && board[7] == player && board[8] == player) ||
                (board[0] == player && board[3] == player && board[6] == player) ||
                (board[1] == player && board[4] == player && board[7] == player) ||
                (board[2] == player && board[5] == player && board[8] == player) ||
                (board[0] == player && board[4] == player && board[8] == player) ||
                (board[2] == player && board[4] == player && board[6] == player)) ? true : false
    }
    
    func checkState() {
        if winner(is: .ai, of: board) { hasWinner?(.ai); return }
        if winner(is: .human, of: board) { hasWinner?(.human); return }
        if availableSpots(of: board).isEmpty { isDraw?(); return }
    }
    
    func reset() {
        board = [Marker](repeating: .none, count: 9)
    }
}
