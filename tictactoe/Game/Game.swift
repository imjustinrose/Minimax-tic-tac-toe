//
//  Game.swift
//  tictactoe
//
//  Created by Justin Rose on 4/17/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import Foundation

class Game {
    private lazy var human = Human(on: Game.board)
    private lazy var ai = AI(on: Game.board)
    
    static let shared = Game()
    static let board = Board()
    static var currentPlayer: PlayerType = .human
    var hasStarted = false
    
    var playerChanged: (_ player: PlayerType) -> Void = { _ in }
    var aiSelected: (_ location: Int) -> Void = { _ in }
    var hasWinner: ((PlayerType) -> Void)?
    var isDraw: (() -> Void)?
    var started: ((PlayerType) -> Void) = { _ in }
    
    init() {
        Game.board.markerPlaced = { self.nextPlayer() }
        Game.board.isDraw = { [weak self] in self?.isDraw?() }
        Game.board.hasWinner = { [weak self] winner in self?.hasWinner?(winner) }
    }
    
    func nextPlayer() {
        Game.currentPlayer = Game.currentPlayer.next
        playerChanged(Game.currentPlayer)
        
        let delay = Double(Float(arc4random()) / Float(UInt32.max)) + 1
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            Game.currentPlayer.isAI ? self.aiSelected(self.ai.findBestMove(Game.board.board)) : nil
        }
    }
    
    func restart() {
        end()
        Game.board.reset()
        start()
        
        let delay = Double(Float(arc4random()) / Float(UInt32.max)) + 1
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            Game.currentPlayer.isAI ? self.aiSelected(self.ai.findBestMove(Game.board.board)) : nil
        }
    }
    
    func start() {
        hasStarted = true
        started(Game.currentPlayer)
    }
    
    func end() {
        hasStarted = false
    }
}
