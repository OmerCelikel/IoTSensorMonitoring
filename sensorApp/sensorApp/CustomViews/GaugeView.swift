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
//            updateLabel()
        }
    }
    @IBInspectable var gaugeColor: UIColor = UIColor.red

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
        let gaugePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        gaugePath.lineWidth = 25
        gaugeColor.setStroke()
        gaugePath.stroke()

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


//        updateLabel()
    }

    private func setupView() {
        backgroundColor = UIColor.clear
        isOpaque = false
    }

//    private func updateLabel() {
//        let formattedValue = String(format: "%.1f", value)
//        label.text = "\(formattedValue) °C"
//    }
}
