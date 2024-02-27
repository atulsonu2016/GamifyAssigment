//
//  ShadowView.swift
//  Assigment
//
//  Created by Atul Sharan on 23/02/24.
//

import Foundation
import UIKit

import UIKit

class CustomShadowView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    
    // MARK: - Inspectable Properties
    
    @IBInspectable var fillColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 2) {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
    
    private func setupShadow() {
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            // Create a rounded rect path
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            shadowLayer.path = path.cgPath
            
            // Set shadow properties
            shadowLayer.fillColor = fillColor.cgColor
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowPath = path.cgPath
            shadowLayer.shadowOffset = shadowOffset
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
}
