//
//  CALayerExtension.swift
//  Firebase Messenger
//
//  Created by Brett Chapin on 2/10/20.
//  Copyright © 2020 Black Rose Productions. All rights reserved.
//

import UIKit

extension CALayer {
    func addShadow(opacity: Float = 0.2, radius: CGFloat = 5, offset: CGSize = .init(width: 0, height: 5)) {
        self.shadowOpacity = opacity
        self.shadowColor = UIColor.black.cgColor
        self.shadowRadius = radius
        self.shadowOffset = offset
        self.masksToBounds = false
        
        if cornerRadius != 0 {
            self.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            addShadowWithRadius(radius: cornerRadius)
        }
    }
    
    func addBorder(width: CGFloat, color: UIColor = .black) {
        self.borderColor = color.cgColor
        self.borderWidth = width
    }
    
    func addCornerRadius(radius: CGFloat) {
        self.cornerRadius = radius
    }
    
    func addShadowWithRadius(radius: CGFloat) {
        if let contents = self.contents {
            
            masksToBounds = false
            sublayers?.filter({ $0.frame.equalTo(self.bounds) }).forEach{ $0.addCornerRadius(radius: radius) }
            self.contents = nil
            
            if let sublayer = sublayers?.first, sublayer.name == ContentsLayerName {
                sublayer.removeFromSuperlayer()
            }
            
            let contentLayer = CALayer()
            contentLayer.name = ContentsLayerName
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.addCornerRadius(radius: radius)
            contentLayer.masksToBounds = true
            
            insertSublayer(contentLayer, at: 0)
        }
    }

}
