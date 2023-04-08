//
//  ViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 27.03.2023.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let temperatureDataEntries = [
        PieChartDataEntry(value: 10, label: "Slice 1"),
        PieChartDataEntry(value: 20, label: "Slice 2"),
        PieChartDataEntry(value: 30, label: "Slice 3"),
        PieChartDataEntry(value: 40, label: "Slice 4")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Register collection view cell
        collectionView.register(UINib(nibName: "LineChartsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LineChartsCollectionViewCell")
        
        collectionView.register(UINib(nibName: "GaugeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GaugeCollectionViewCell")
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chartData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LineChartsCollectionViewCell", for: indexPath) as! LineChartsCollectionViewCell
//        print("-> \(chartData[indexPath.row])")
//        cell.setup(with: chartData[indexPath.row])
//        return cell
        
        if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GaugeCollectionViewCell", for: indexPath) as! GaugeCollectionViewCell
            
            cell.setup(with: TemperatureData.init(temperature: 20))
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LineChartsCollectionViewCell", for: indexPath) as! LineChartsCollectionViewCell
                let chartData = chartData[indexPath.row]
                cell.setup(with: chartData)
                return cell
            }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
                    // Set larger size for first item
                    let width = collectionView.bounds.width
                    let height = collectionView.bounds.height * 0.5
                    return CGSize(width: width, height: height)
                } else {
                    // Set default size for all other items
                    let width = (collectionView.bounds.width - 10) / 2
                    return CGSize(width: width, height: 250)
                }
        

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-> \(chartData[indexPath.row].name)")
    }
}
