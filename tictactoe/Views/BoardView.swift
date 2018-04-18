//
//  BoardView.swift
//  tictactoe
//
//  Created by Justin Rose on 4/17/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

@IBDesignable class BoardView: UIView {
    @IBInspectable var boardOutline: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    @IBInspectable var lineWidth: CGFloat = 1
    
    override func draw(_ rect: CGRect) {
        boardOutline.set()
        drawBoardOutline()
    }
    
    func drawBoardOutline() {
        let height = bounds.height
        let width = bounds.width
        let thirdWidth = width / 3
        
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        // Horizontal lines
        path.move(to: CGPoint(x: 0, y: thirdWidth))
        path.addLine(to: CGPoint(x: width, y: thirdWidth))
        path.move(to: CGPoint(x: 0, y: width - thirdWidth))
        path.addLine(to: CGPoint(x: width, y: width - thirdWidth))
        
        // Vertical lines
        path.move(to: CGPoint(x: thirdWidth, y: 0))
        path.addLine(to: CGPoint(x: thirdWidth, y: height))
        path.move(to: CGPoint(x: width - thirdWidth, y: 0))
        path.addLine(to: CGPoint(x: width - thirdWidth, y: height))
        
        path.stroke()
    }
}
