//
//  SpeedometerProgressView.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 5.04.2023.
//

import UIKit

class SpeedometerProgressView: UIView {
    
    private let progressLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    
    var progressColor = UIColor.blue {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor = UIColor.lightGray {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    var lineWidth: CGFloat = 10.0 {
        didSet {
            progressLayer.lineWidth = lineWidth
            trackLayer.lineWidth = lineWidth
        }
    }
    
    var minimumValue: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var maximumValue: CGFloat = 100.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var progress: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.width / 2.0, y: bounds.height)
        let radius = (bounds.width - lineWidth) / 2.0
        
        let startAngle = CGFloat.pi
        let endAngle = 0.0
        
        let trackPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        
        trackLayer.path = trackPath.cgPath
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(trackLayer)
        
        let progressEndAngle = startAngle - Double(progress / maximumValue) * (startAngle - endAngle)
        
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(progressEndAngle), clockwise: true)
        
        progressLayer.path = progressPath.cgPath
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(progressLayer)
    }
    
}

