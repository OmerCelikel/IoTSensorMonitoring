//
//  PieChartCollectionViewCell.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 4.04.2023.
//

import UIKit
import Charts

class PieChartCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pieChartView: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setup(with dataEntries: [PieChartDataEntry]) {
        
        // Create a PieChartDataSet from the data entries
        let dataSet = PieChartDataSet(entries: dataEntries, label: "")
        dataSet.setColor(UIColor.clear)
        let lineColor = UIColor(red: 237/255, green: 111/255, blue: 128/255, alpha: 1)
        dataSet.colors = [lineColor]
        dataSet.drawValuesEnabled = false
        
        // Create a PieChartData object from the PieChartDataSet
        let chartData = PieChartData(dataSet: dataSet)
        
        // Set the data property of the PieChartView to the PieChartData
        pieChartView.data = chartData
        pieChartView.animate(xAxisDuration: 1.5)
    }

    @IBAction func seeReportBtnTapped(_ sender: Any) {
        print("seeReportBtnTapped")
    }
    
}
