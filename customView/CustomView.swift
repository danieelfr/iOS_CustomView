//
//  CustomView.swift
//  customView
//
//  Created by Daniel on 4/25/17.
//  Copyright © 2017 DanielFR. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class CustomView: UIView {

    var backgroundLayer, pieOverLayer: CAShapeLayer!
    
    var lineWidth: Double = 0.0
    
    @IBInspectable
    var piePercentage:Double = 34 {
        willSet(newPiePercentage) { updatePiePercentage(newPiePercentage)}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lineWidth = Double(self.frame.size.width) / 2
        
        if !(backgroundLayer != nil) {
            backgroundLayer = CAShapeLayer()
            layer.addSublayer(backgroundLayer)
            
            let rect = CGRectInset(bounds, CGFloat(lineWidth / 2.0), CGFloat(lineWidth / 2.0))
            
            let path = UIBezierPath(ovalInRect: rect)
            
            backgroundLayer.path = path.CGPath
            
            backgroundLayer.fillColor = nil
            backgroundLayer.lineWidth = CGFloat(lineWidth)
            backgroundLayer.strokeColor = UIColor(white: 0.5, alpha: 0.3).CGColor
            
            
        }
        
        backgroundLayer.frame = layer.bounds
        
        if !(pieOverLayer != nil) {
            
            pieOverLayer = CAShapeLayer()
            layer.addSublayer(pieOverLayer)
            
            let rect = CGRectInset(bounds, CGFloat(lineWidth / 2.0), CGFloat(lineWidth / 2))
  
            let path = UIBezierPath(ovalInRect: rect)
            
            pieOverLayer.path = path.CGPath
            pieOverLayer.fillColor = nil
            pieOverLayer.lineWidth = CGFloat(lineWidth)
            pieOverLayer.strokeColor = UIColor(red: 49/255, green: 209/255, blue: 102/255, alpha: 1).CGColor
            pieOverLayer.anchorPoint = CGPointMake(0.5, 0.5)
            pieOverLayer.transform = CATransform3DRotate(pieOverLayer.transform, CGFloat(-M_PI/2), 0, 0, 1)
            
        }
        
        pieOverLayer.frame = layer.bounds
        
        self.updateLayerProperties()
    }
    
    func updateLayerProperties() {
        
        if (pieOverLayer != nil) {
            
            self.pieOverLayer.strokeEnd = CGFloat(piePercentage / 100)
        }
    }
    
    func updatePiePercentage(newPiePercentage: Double) {
        
        if (pieOverLayer != nil) {
            
            CATransaction.begin()
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = ((newPiePercentage/100) - (self.piePercentage/100)) * 3
            animation.fromValue = self.piePercentage / 100
            animation.toValue = newPiePercentage / 100
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            CATransaction.setCompletionBlock({ () -> Void in
                CATransaction.begin()
                CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
                self.pieOverLayer.strokeEnd = CGFloat(newPiePercentage / 100)
                CATransaction.commit() })
            
            self.pieOverLayer.addAnimation(animation, forKey: "animateStrokeEnd")
            CATransaction.commit()
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
