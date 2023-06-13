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
        
    func setup(with gasData: Gas) {
        
        gasNameTextLabel.text = gasData.name
        gasValueTextLabel.text = String(format: "%.2f",gasData.value)
//        self.gasValueTextLabel.textColor = (gasData.value > self.gasValueTextLabel.text.flatMap(Double.init) ?? 0) ? .green : .red
    }
    
    func setupEmpty() {
        gasNameTextLabel.text = "no gas"
        gasValueTextLabel.text = "no value"
    }

}
