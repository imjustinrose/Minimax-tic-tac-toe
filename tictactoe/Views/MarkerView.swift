//
//  MarkerView.swift
//  tictactoe
//
//  Created by Justin Rose on 4/17/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

@IBDesignable class MarkerView: UIView {
    var marker: Marker = .none {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentMarker: String? {
        willSet {
            if let newMarker = Marker(rawValue: newValue?.lowercased() ?? "") {
                marker = newMarker
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        switch marker {
        case .ai: #colorLiteral(red: 1, green: 0.3568627451, blue: 0.3647058824, alpha: 1).set()
        case .human: #colorLiteral(red: 0.4509803922, green: 0.7529411765, blue: 0.7882352941, alpha: 1).set()
        case .none: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0).set()
        }
        
        context.fillEllipse(in: bounds)
    }
}
