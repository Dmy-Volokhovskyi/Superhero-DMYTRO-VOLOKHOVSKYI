//
//  UIView+Gradiend.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 18/02/2022.
//

import Foundation
import UIKit

extension UIView {

    func addGradient(colors: [UIColor] = [.black, UIColor.clear], locations: [NSNumber] = [0.27,1], startPoint: CGPoint = CGPoint(x: 1.0, y: 0.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0), type: CAGradientLayerType = .axial , frame : CGRect){

        let gradient = CAGradientLayer()

        gradient.frame = frame
        gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)

        // Iterates through the colors array and casts the individual elements to cgColor
        // Alternatively, one could use a CGColor Array in the first place or do this cast in a for-loop
        gradient.colors = colors.map{ $0.cgColor }

        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint

        // Insert the new layer at the bottom-most position
        // This way we won't cover any other elements
        self.layer.insertSublayer(gradient, at: 0)
    }
}
