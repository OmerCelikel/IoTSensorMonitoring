//
//  LineChartsCollectionViewCell.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 29.03.2023.
//

import UIKit
import Charts

class LineChartsCollectionViewCell: UICollectionViewCell {

    //@IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var gasNameTextLabel: UILabel!
    @IBOutlet weak var gasValueTextLabel: UILabel!
        
    @IBOutlet weak var graphView: GraphView!
    
    private var previousGasValue: Double = 1000.0
    private let percentageIncrease: Double = 0.20  // 5% increase

    func setup(with gasData: Gas) {
        // Store the previous value before updating it
        let currentGasValue = gasData.value
        
        // Update the UI with the current gas value
        gasNameTextLabel.text = gasData.name
        gasValueTextLabel.text = String(format: "%.2f", currentGasValue)
        
        // Compare the current value with the previous value and set the text color
        let thresholdValue = previousGasValue + (previousGasValue * percentageIncrease)
        self.gasValueTextLabel.textColor = (currentGasValue > thresholdValue) ? .red : .systemGreen
        
        // Update the previousGasValue for the next setup call
        previousGasValue = currentGasValue
        
        // Rest of the setup code
    }
    
    func setupEmpty() {
        gasNameTextLabel.text = "no gas"
        gasValueTextLabel.text = "no value"
    }

}
