//
//  HomeTableViewCell.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 26.04.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gasNameLabel: UILabel!
    @IBOutlet weak var gasValueLabel: UILabel!
    
    func setup(gasData: Gas) {
            gasNameLabel.text = gasData.Name
            gasValueLabel.text = String(format: "%.2f", gasData.Value)
            gasValueLabel.fadeTransition(0.4)
        }
        
//    func setup(gasData: Gas) {
//        gasNameLabel.text = gasData.Name
////        gasValueLabel.text = String(format: "%.2f", gasData.Value)
//        gasValueLabel.fadeTransition(0.4)
//        gasValueLabel.text = String(format: "%.2f", gasData.Value)
//
////        gasValueLabel.alpha = 1
//    }
}

// Animate the gas value label's alpha to 0 and change the label's text inside the animation block
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
//            self.gasValueLabel.alpha = 0
//        }) { _ in
//            self.gasValueLabel.text = String(format: "%.2f", gasData.Value)
//
//            // Animate the gas value label's alpha back to 1 after changing the text
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
//                self.gasValueLabel.alpha = 1
//            }, completion: nil)
//        }

// animate the cell if the gas value changes
//        UIView.transition(with: gasValueLabel, duration: 1, options: [.transitionCrossDissolve]) {
//            self.gasValueLabel.textColor = (gasData.Value > self.gasValueLabel.text.flatMap(Double.init) ?? 0) ? .green : .red
//        }
