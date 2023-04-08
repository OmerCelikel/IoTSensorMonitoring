//
//  PieChartCollectionViewCell.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 4.04.2023.
//

import UIKit

class GaugeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gaugeView: GaugeView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setup(with dataEntries: TemperatureData) {
        gaugeView.value = CGFloat(dataEntries.temperature)
    }

    @IBAction func seeReportBtnTapped(_ sender: Any) {
        print("seeReportBtnTapped")
    }
    
}
