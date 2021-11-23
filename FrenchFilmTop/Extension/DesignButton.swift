//
//  DesignButton.swift
//  FrenchFilmTop
//
//  Created by ineta.magone on 23/11/2021.
//

import UIKit

@IBDesignable class DesignButton: BounceButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
}
