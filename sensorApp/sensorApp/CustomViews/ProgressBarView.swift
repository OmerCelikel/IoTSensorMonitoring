//
//  ProgressBarView.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 5.04.2023.
//
import UIKit
class ProgressBarView: UIView {

    var progress: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - 10

        let startAngle = CGFloat(-Double.pi / 2)
        let endAngle = startAngle + CGFloat(progress * Double.pi)

        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        path.lineWidth = 10
        path.lineCapStyle = .round

        UIColor.blue.setStroke()
        path.stroke()
    }
}
