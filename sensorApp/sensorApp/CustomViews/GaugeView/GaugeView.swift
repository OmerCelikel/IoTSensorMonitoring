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
            updateLabel()
            startAnimation()
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

        // Draw the red portion
        let colorPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: colorEndAngle, clockwise: true)
        colorPath.lineWidth = 20
        temperatureToRGB(temperature: value).setStroke()
        colorPath.stroke()
        
        // Draw the gray portion
        let grayPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: colorEndAngle, endAngle: endAngle, clockwise: true)
        grayPath.lineWidth = 20
        UIColor.lightGray.setStroke()
        grayPath.stroke()

        // Add label to the center of the gauge
        label.frame = CGRect(x: center.x - 50, y: center.y - 15, width: 100, height: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        addSubview(label)
        
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
    
    func startAnimation() {
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0
        strokeAnimation.toValue = value / maxValue
        strokeAnimation.duration = 2.5
        strokeAnimation.fillMode = .forwards
        strokeAnimation.isRemovedOnCompletion = false
        self.layer.add(strokeAnimation, forKey: "strokeAnimation")
    }

    
}