//
//  GaugeView.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 6.04.2023.
//

import UIKit

@IBDesignable class GaugeView: UIView {
    
    @IBInspectable var minValue: CGFloat = -15
    @IBInspectable var maxValue: CGFloat = 60
    @IBInspectable var value: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
            updateLabel()
        }
    }
    
    private var radius: CGFloat = 0
    private let label = UILabel()
    
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
        
        // Calculate the end angle for the color portion based on the value
        let valueRange = maxValue - minValue
        let valueRatio = (value - minValue) / valueRange
        let colorEndAngle = startAngle + (endAngle - startAngle) * valueRatio
        
        let colorPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: colorEndAngle, clockwise: true)
        colorPath.lineWidth = 15
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        let minColorGauge = UIColor(red: 2/255.0, green: 201/255.0, blue: 255/255.0, alpha: 1.0)
        let maxColorGauge = UIColor(red: 147/255.0, green: 148/255.0, blue: 255/255.0, alpha: 1.0)
        gradientLayer.colors = [UIColor.white.cgColor, minColorGauge.cgColor ,maxColorGauge.cgColor, UIColor.purple.cgColor]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = colorPath.cgPath
        shapeLayer.lineWidth = 18
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineCap = .round
        gradientLayer.mask = shapeLayer
        layer.addSublayer(gradientLayer)
        
        // Draw the gray portion
        let grayStartAngle = colorEndAngle
        let grayEndAngle = endAngle
        let grayPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: grayStartAngle, endAngle: grayEndAngle, clockwise: true)
        grayPath.lineWidth = 18
        let lightGray = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.6)
        lightGray.setStroke()
        grayPath.stroke()
        
        // Add label to the center of the gauge
        label.frame = CGRect(x: center.x - 50, y: center.y - 15, width: 100, height: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(label)

        let valueString = String(format: "%.1f °C", value)
        let font = UIFont.boldSystemFont(ofSize: 30)
        let attributes = [NSAttributedString.Key.font: font]
        let size = valueString.size(withAttributes: attributes)
        let point = CGPoint(x: center.x - size.width/2, y: center.y - size.height/2)
        valueString.draw(at: point, withAttributes: attributes)
        updateLabel()
    }
    
    
    private func setupView() {
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    private func updateLabel() {
        
        if value < minValue || value > maxValue {
            value = 0
        }
    }
    
    private func temperatureToRGB(temperature: CGFloat) -> UIColor {
        let minTemperature: CGFloat = 0
        let maxTemperature: CGFloat = 100
        let blueColor = UIColor.blue
        let redColor = UIColor.red
        
        let ratio = (temperature - minTemperature) / (maxTemperature - minTemperature)
        let redValue = ratio
        let blueValue = 1 - ratio
        
        let red = redValue * redColor.cgColor.components![0] + blueValue * blueColor.cgColor.components![0]
        let green = redValue * redColor.cgColor.components![1] + blueValue * blueColor.cgColor.components![1]
        let blue = redValue * redColor.cgColor.components![2] + blueValue * blueColor.cgColor.components![2]
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
