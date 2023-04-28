//
//  ReportViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 27.03.2023.
//

import UIKit
import Charts

class ReportViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var lineChartView: LineChartView!

    var categories: [GasCategory] = [
        .init(id: "id1", name: "Temperature", image: "https://picsum.photos/100/200"),
        .init(id: "id2", name: "CO2", image: "https://picsum.photos/100/200"),
        .init(id: "id3", name: "CO", image: "https://picsum.photos/100/200"),
        .init(id: "id4", name: "Humidity", image: "https://picsum.photos/100/200")
    ]
    
    var times: [TimeCategory] = [
        .init(id: "id11", name: "1 Day"),
        .init(id: "id12", name: "1 Week"),
        .init(id: "id13", name: "1 Month")
    ]

    var dataEntries = [ChartDataEntry]()
    var selectedGasName = String()
    var selectedGasValue = Double()
    
    let chartData: [ChartData] = [
        ChartData(name: "Gas 1", dataEntries: [
                    ChartDataEntry(x: 1, y: 5.0),
                    ChartDataEntry(x: 2, y: 4.9),
                    ChartDataEntry(x: 3, y: 4.9),
                    ChartDataEntry(x: 4, y: 5.0),
                    ChartDataEntry(x: 5, y: 5.0),
                    ChartDataEntry(x: 6, y: 4.95),
                    ChartDataEntry(x: 7, y: 5.0),
                    ChartDataEntry(x: 8, y: 5.0),
                    ChartDataEntry(x: 9, y: 4.9),
                    ChartDataEntry(x: 10, y: 4.8)
                ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        setupChart(with: chartData[0])
        
        print("selectedGasName \(selectedGasName) \n selectedGasValue \(selectedGasValue)")
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        timeCollectionView.register(UINib(nibName: TimeCategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TimeCategoryCollectionViewCell.identifier)
    }
    
    func setupChart(with chart: ChartData) {
        
        // Create data entries
        for point in chart.dataEntries {
            let entry = ChartDataEntry(x: point.x, y: point.y)
            dataEntries.append(entry)
        }
        
        // Create a LineChartDataSet from the data entries
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Random Data")
        dataSet.colors = [NSUIColor.systemBlue.withAlphaComponent(1)]
        dataSet.lineWidth = 4.0
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
    }

}

extension ReportViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case timeCollectionView:
            return times.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        case timeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCategoryCollectionViewCell.identifier, for: indexPath) as! TimeCategoryCollectionViewCell
            cell.setup(category: times[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: - When select items change color of view to purple.
        print("didSelectItemAt")
        
        if let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.backgroundColor = .purple
            }
    }
}
