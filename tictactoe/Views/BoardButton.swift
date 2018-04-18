//
//  BoardButton.swift
//  tictactoe
//
//  Created by Justin Rose on 4/17/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class BoardButton: UIButton {
    var marker: Marker = .none {
        didSet {
            guard let superview = superview else { return }
            
            for subview in superview.subviews {
                guard let markerView = subview as? MarkerView else { break }
                markerView.currentMarker = marker.rawValue
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTarget(self, action: #selector(placeMarker), for: .touchUpInside)
    }
    
    @objc private func placeMarker(_ sender: UIButton) {
        guard marker == .none else { return }
        
        marker = Game.currentPlayer.marker
        Game.board.place(marker, at: sender.tag)
    }
}
