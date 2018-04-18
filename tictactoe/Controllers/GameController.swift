//
//  GameController.swift
//  tictactoe
//
//  Created by Justin Rose on 4/17/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var helperLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCallbacks()
    }
    
    func setupCallbacks() {
        Game.shared.aiSelected = { location in
            self.placeMarker(at: location)
        }
        
        Game.shared.started = { player in
            self.helperLabel.text = player.isHuman ? "It's your move" : "I'm thinking..."
            self.boardView.isUserInteractionEnabled = player.isHuman ? true : false
        }
        
        Game.shared.isDraw = {
            self.helperLabel.text = "It's a draw!"
            self.boardView.isUserInteractionEnabled = false
        }
        
        Game.shared.hasWinner = { player in
            self.helperLabel.text = player.isHuman ? "You won!" : "AI wins!"
            self.boardView.isUserInteractionEnabled = false
        }
        
        Game.shared.playerChanged = { player in
            self.helperLabel.text = player.isHuman ? "It's your move" : "I'm thinking..."
            self.boardView.isUserInteractionEnabled = player.isHuman ? true : false
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        Game.shared.restart()
        clearBoard()
    }
}

// MARK: - Board
extension GameController {
    private func placeMarker(at location: Int) {
        for horizontalStackView in self.boardView.subviews {
            for verticalStackView in horizontalStackView.subviews {
                for parentView in verticalStackView.subviews {
                    for subview in parentView.subviews {
                        guard let button = subview as? BoardButton,
                            button.tag == location else { continue }
                        
                        button.sendActions(for: .touchUpInside)
                    }
                }
            }
        }
    }
    
    private func clearBoard() {
        for horizontalStackView in self.boardView.subviews {
            for verticalStackView in horizontalStackView.subviews {
                for parentView in verticalStackView.subviews {
                    for subview in parentView.subviews {
                        guard let button = subview as? BoardButton,
                            button.marker != .none else { continue }
                        
                        button.marker = .none
                    }
                }
            }
        }
    }
}

