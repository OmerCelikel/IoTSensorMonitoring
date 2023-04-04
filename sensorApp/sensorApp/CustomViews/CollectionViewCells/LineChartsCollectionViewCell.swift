//
//  LineChartsCollectionViewCell.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 29.03.2023.
//

import UIKit
import Charts

class LineChartsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var gasNameTextLabel: UILabel!
    
    var dataEntries = [ChartDataEntry]()
    func setup(with chart: ChartData) {
        
        for point in chart.dataEntries {
            let entry = ChartDataEntry(x: point.x, y: point.y)
            dataEntries.append(entry)
        }
        gasNameTextLabel.text = chart.name
        
        // Create a LineChartDataSet from the data entries
        let dataSet = LineChartDataSet(entries: dataEntries, label: "")
        dataSet.setColor(UIColor.clear)
        let lineColor = UIColor(red: 237/255, green: 111/255, blue: 128/255, alpha: 1)
        dataSet.colors = [lineColor]
//        dataSet.colors = [NSUIColor.systemBlue.withAlphaComponent(1)]
        dataSet.lineWidth = 2.0
        dataSet.drawValuesEnabled = false
        
        // Hide x axis grid lines
        lineChartView.xAxis.drawGridLinesEnabled = false
        
        // Show y axis grid lines
        lineChartView.leftAxis.drawGridLinesEnabled = true
        
        // Configure the line chart to use cubic interpolation and add a shadow
        dataSet.mode = .cubicBezier
        
        dataSet.drawCirclesEnabled = false
        // Remove x-axis from top and show labels only on the bottom
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.labelPosition = .bottom
        
        // Remove y-axis from right and show labels only on the left
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        
        // Create a LineChartData object from the LineChartDataSet
        let chartData = LineChartData(dataSet: dataSet)
        
        lineChartView.xAxis.drawLabelsEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = false

        lineChartView.leftAxis.gridColor = UIColor.white
        
        // Set the data property of the LineChartView to the LineChartData
        lineChartView.data = chartData
        lineChartView.animate(xAxisDuration: 1.5)
    }

}
