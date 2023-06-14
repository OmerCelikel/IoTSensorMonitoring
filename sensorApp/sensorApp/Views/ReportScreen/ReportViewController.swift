//
//  ReportViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 27.03.2023.
//

import UIKit
import Charts

class ReportViewController: UIViewController {
    
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var gasNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var chartTitleLabel: UILabel!
    
    
    let dataInterval: TimeInterval = 10.0 // Set the desired interval in seconds
    
    var times: [TimeCategory] = [
        .init(id: "-1m", name: "1 Min"),
        .init(id: "-5m", name: "5 Min"),
        .init(id: "-30m", name: "30 Min"),
        .init(id: "-1h", name: "1 Hour"),
        .init(id: "-2h", name: "2 Hour")
    ]
    
    var dataEntries = [ChartDataEntry]()
    var selectedGasName = String()
    var selectedGasValue = Double()
    var specificGasData = [Gas]()
    var selectedTimeCategory: TimeCategory?
    let reportViewModel = ReportViewModel()
    var selectedCardView: CardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        selectedTimeCategory = nil // set default time category
        updateGasReport()
        
    }
    
    func updateGasReport() {
        self.gasNameLabel.text = self.selectedGasName
        self.valueLabel.text = "Value: \(String(format: "%.2f",self.selectedGasValue))"
        if let selectedTimeCategory = selectedTimeCategory {
            let date = selectedTimeCategory.id ?? "-1m"
            reportViewModel.postGasReport(date: date, field: selectedGasName) { result in
                switch result {
                case .success(let reports):
                    self.specificGasData = reports
                    self.clearLineChart()
                    self.dataSetForLineChart(gasData: self.specificGasData)
                    self.chartTitleLabel.text = self.extractLabel(from: self.selectedGasName)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            // Display the message on the chart view
            clearLineChart()
            chartTitleLabel.text = "Please select a time period to display the values"
            chartTitleLabel.textColor = UIColor.gray
            chartTitleLabel.font = UIFont.systemFont(ofSize: 12)
            // You may also consider hiding other labels and views related to the chart data
        }
    }
    
    func clearLineChart() {
        lineChartView.clear()
        dataEntries.removeAll()
    }
    
    
    private func registerCells() {
        timeCollectionView.register(UINib(nibName: TimeCategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TimeCategoryCollectionViewCell.identifier)
    }
    
    func dataSetForLineChart(gasData: [Gas]) {
        let filteredGasData = gasData.filter { dataPoint in
            let timeInterval = dataPoint.time.timeIntervalSince1970
            return timeInterval.truncatingRemainder(dividingBy: dataInterval) == 0
        }
        
        var count = 0.0
        for dataPoint in filteredGasData {
            let newEntry = ChartDataEntry(x: count, y: dataPoint.value)
            dataEntries.append(newEntry)
            count += 1
        }
        
        setUpLineGraph(dataEntries: dataEntries)
    }
    
    
    func setUpLineGraph(dataEntries: [ChartDataEntry]) {
        // Create a LineChartDataSet from the data entries
        let dataSet = LineChartDataSet(entries: dataEntries, label: ("\(selectedGasName) values"))
        dataSet.colors = [Colors.lineGraphLineColor]
        dataSet.lineWidth = 3.0
        dataSet.drawValuesEnabled = false
        
        // Hide x axis grid lines
        lineChartView.xAxis.drawGridLinesEnabled = false
        
        // Hide y axis grid lines
        lineChartView.leftAxis.drawGridLinesEnabled = false
        
        // Configure the line chart to use cubic interpolation and add a shadow
        dataSet.mode = .cubicBezier
        
        dataSet.drawCirclesEnabled = false
        // Remove x-axis from top and show labels only on the bottom
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.labelPosition = .bottom
        
        // Remove y-axis from right and show labels only on the left
        lineChartView.rightAxis.enabled = false
        
        // Create a LineChartData object from the LineChartDataSet
        let chartData = LineChartData(dataSet: dataSet)
        
        // Set the data property of the LineChartView to the LineChartData
        lineChartView.data = chartData
        lineChartView.animate(xAxisDuration: 1.5)
        
        chartTitleLabel.textColor = UIColor.darkGray
        chartTitleLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    // Function to extract label from gas name
    func extractLabel(from gasName: String) -> String {
        let components = gasName.components(separatedBy: "_")
        if components.count > 1 {
            return components[1]
        } else {
            return gasName
        }
    }
}

extension ReportViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case timeCollectionView:
            return times.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            
        case timeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCategoryCollectionViewCell.identifier, for: indexPath) as! TimeCategoryCollectionViewCell
            cell.setup(category: times[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == timeCollectionView {
            selectedTimeCategory = times[indexPath.row]
            updateGasReport()
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? TimeCategoryCollectionViewCell else { return }
        guard let cardView = cell.contentView.subviews.first(where: { $0 is CardView }) as? CardView else { return }
        
        cardView.isSelected = true
        cardView.layer.backgroundColor = Colors.lineGraphLineColor.cgColor
        
        selectedCardView?.isSelected = false
        selectedCardView?.layer.backgroundColor = UIColor.white.cgColor
        
        selectedCardView = cardView
    }
}
