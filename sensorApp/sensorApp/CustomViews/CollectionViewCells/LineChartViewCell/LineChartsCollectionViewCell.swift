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
        
        gasNameTextLabel.text = gasData.Name
        gasValueTextLabel.text = String(format: "%.2f",gasData.Value)
        self.gasValueTextLabel.textColor = (gasData.Value > self.gasValueTextLabel.text.flatMap(Double.init) ?? 0) ? .green : .red
    }
    
    func setupEmpty() {
        gasNameTextLabel.text = "no gas"
        gasValueTextLabel.text = "no value"
    }

}

//for point in 1...10 {
//    let entry = ChartDataEntry(x: Double(point) + 1.0, y: chart.Value)
//    dataEntries.append(entry)
//}

// Create a LineChartDataSet from the data entries
//let dataSet = LineChartDataSet(entries: dataEntries, label: "")
//dataSet.setColor(UIColor.clear)
//
//let lineColor = UIColor(red: 237/255, green: 111/255, blue: 128/255, alpha: 1)
//dataSet.colors = [lineColor]
//
//dataSet.lineWidth = 2.0
//dataSet.drawValuesEnabled = false


// Hide x axis grid lines
//lineChartView.xAxis.drawGridLinesEnabled = false

// Show y axis grid lines
//lineChartView.leftAxis.drawGridLinesEnabled = true

// Configure the line chart to use cubic interpolation and add a shadow
//dataSet.mode = .cubicBezier

//dataSet.drawCirclesEnabled = false
// Remove x-axis from top and show labels only on the bottom
//lineChartView.xAxis.drawAxisLineEnabled = false
//lineChartView.xAxis.labelPosition = .bottom

// Remove y-axis from right and show labels only on the left
// lineChartView.rightAxis.enabled = false
// lineChartView.leftAxis.enabled = false

// Create a LineChartData object from the LineChartDataSet
// let chartData = LineChartData(dataSet: dataSet)

// lineChartView.xAxis.drawLabelsEnabled = false
// lineChartView.leftAxis.drawLabelsEnabled = false

// lineChartView.leftAxis.gridColor = UIColor.white
// lineChartView.legend.enabled = false


// Set the data property of the LineChartView to the LineChartData
//lineChartView.data = chartData
//lineChartView.animate(xAxisDuration: 1.5)
