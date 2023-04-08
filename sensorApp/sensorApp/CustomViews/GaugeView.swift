//
//  GaugeView.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 6.04.2023.
//

import UIKit

@IBDesignable class GaugeView: UIView {
    
    @IBInspectable var minValue: CGFloat = 0
    @IBInspectable var maxValue: CGFloat = 100
    @IBInspectable var value: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var gaugeColor: UIColor = UIColor.red
    @IBInspectable var needleColor: UIColor = UIColor.black
    
    private var radius: CGFloat = 0
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let angle = CGFloat.pi/4 // 60 degrees
        let startAngle = angle + CGFloat.pi/2
        let endAngle = 2*CGFloat.pi - angle + CGFloat.pi/2
        
        radius = min(bounds.width, bounds.height)/2 - 20
        let gaugePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        gaugePath.lineWidth = 25
        gaugeColor.setStroke()
        gaugePath.stroke()
        
        let valueAngle = (value - minValue) / (maxValue - minValue) * (endAngle - startAngle) + startAngle
        let valuePath = UIBezierPath()
        valuePath.move(to: center)
        valuePath.addLine(to: CGPoint(x: center.x + (radius - 30)*cos(valueAngle), y: center.y + (radius - 30)*sin(valueAngle)))
        valuePath.lineWidth = 2
        needleColor.setStroke()
        valuePath.stroke()
    }
    
    private func setupView() {
        backgroundColor = UIColor.clear
        isOpaque = false
    }
}

