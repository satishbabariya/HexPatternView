//
//  HexPatternView.swift
//  HexPatternView
//
//  Created by Satish Babariya on 02/10/17.
//  Copyright © 2017 satishbabariya. All rights reserved.
//

import Foundation
import UIKit

public class HexPatternView : UIView {
    
    public var color: UIColor = UIColor.black {
        didSet {
            self.updatePattern(animated: false)
        }
    }
    public var cellWidthFactor: CGFloat = 0.2 {
        didSet {
            self.updatePattern(animated: false)
        }
    }
    public var cellWidthMin: CGFloat = 50 {
        didSet {
            self.updatePattern(animated: false)
        }
    }
    public var cellWidthMax: CGFloat? {
        didSet {
            self.updatePattern(animated: false)
        }
    }
    public var pattern: UIBezierPath? {
        didSet {
            self.updatePattern(animated: false)
        }
    }
    
    private func setPattren() {
        if let pattern = self.pattern {
            var newWidth = self.frame.width * self.cellWidthFactor
            if newWidth < self.cellWidthMin {
                newWidth = self.cellWidthMin
            }
            if self.cellWidthMax != nil {
                if newWidth > self.cellWidthMax! {
                    newWidth = self.cellWidthMax!
                }
            }
            let patternBezierPath = pattern
            patternBezierPath.resizeTo(width: newWidth)
            let patternImage = patternBezierPath.convertToImage(fill: false, stroke: true, color: self.color)
            self.backgroundColor = UIColor.init(patternImage: patternImage)
        }
    }
    
    func updatePattern(animated: Bool) {
        if animated {
            Animation.animate(0.3, animations: {
                self.setPattren()
            })
        } else {
            self.setPattren()
        }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
    }
    
    public init(pattern: UIBezierPath) {
        super.init(frame: CGRect.zero)
        self.pattern = pattern
        self.updatePattern(animated: false)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.updatePattern(animated: true)
    }
    
    public func setRhombusPattern() {
        self.pattern = BezierPathFigure.patterns.rhombus()
    }
}

class Animation {
    
    static func animate(_ duration: TimeInterval,
                        animations: (() -> Void)!,
                        delay: TimeInterval = 0,
                        options: UIViewAnimationOptions = [],
                        withComplection completion: (() -> Void)! = {}) {
        
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: options,
            animations: {
                animations()
        }, completion: { finished in
            completion()
        })
    }
    
    static func animateWithRepeatition(_ duration: TimeInterval,
                                       animations: (() -> Void)!,
                                       delay: TimeInterval = 0,
                                       options: UIViewAnimationOptions = [],
                                       withComplection completion: (() -> Void)! = {}) {
        
        var optionsWithRepeatition = options
        optionsWithRepeatition.insert([.autoreverse, .repeat])
        
        self.animate(
            duration,
            animations: {
                animations()
        },
            delay:  delay,
            options: optionsWithRepeatition,
            withComplection: {
                completion()
        })
    }
}

public class BezierPathFigure {
    
    struct patterns {
        
        static func rhombus(color: UIColor = .black) -> UIBezierPath {
            BezierPath.setContext()
            let strokeColor = color
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 72.67, y: 49.96))
            bezierPath.addLine(to: CGPoint(x: 44, y: 49.96))
            bezierPath.addLine(to: CGPoint(x: 58.19, y: 25.11))
            bezierPath.addLine(to: CGPoint(x: 44, y: 0.27))
            bezierPath.addLine(to: CGPoint(x: 72.67, y: 0.27))
            bezierPath.addLine(to: CGPoint(x: 87, y: 25.11))
            bezierPath.addLine(to: CGPoint(x: 72.67, y: 49.96))
            bezierPath.close()
            bezierPath.move(to: CGPoint(x: 15.33, y: 0.27))
            bezierPath.addLine(to: CGPoint(x: 44, y: 0.27))
            bezierPath.addLine(to: CGPoint(x: 29.81, y: 25.11))
            bezierPath.addLine(to: CGPoint(x: 44, y: 49.96))
            bezierPath.addLine(to: CGPoint(x: 15.33, y: 49.96))
            bezierPath.addLine(to: CGPoint(x: 1, y: 25.11))
            bezierPath.addLine(to: CGPoint(x: 15.33, y: 0.27))
            bezierPath.close()
            bezierPath.move(to: CGPoint(x: 1, y: 25))
            bezierPath.addLine(to: CGPoint(x: 30, y: 25))
            bezierPath.addLine(to: CGPoint(x: 1, y: 25))
            bezierPath.close()
            bezierPath.move(to: CGPoint(x: 58, y: 25))
            bezierPath.addLine(to: CGPoint(x: 87, y: 25))
            bezierPath.addLine(to: CGPoint(x: 58, y: 25))
            bezierPath.close()
            strokeColor.setStroke()
            bezierPath.lineWidth = 1
            bezierPath.lineCapStyle = .square
            bezierPath.stroke()
            BezierPath.endContext()
            return bezierPath
        }
    }
}

public struct BezierPath {
    
    public static func setContext() {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
    }
    
    public static func endContext() {
        UIGraphicsEndImageContext()
    }
}

extension UIBezierPath {
    
    func resizeTo(width: CGFloat) {
        let currentWidth = self.bounds.width
        let relativeFactor = width / currentWidth
        self.apply(CGAffineTransform(scaleX: relativeFactor, y: relativeFactor))
    }
    
    func convertToImage(fill: Bool, stroke: Bool, color: UIColor = .black) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.bounds.width, height: self.bounds.height), false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context!.setStrokeColor(color.cgColor)
        context!.setFillColor(color.cgColor)
        if stroke {
            self.stroke()
        }
        if fill {
            self.fill()
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

