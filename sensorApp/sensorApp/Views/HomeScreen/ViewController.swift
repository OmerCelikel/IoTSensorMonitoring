//
//  ViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 27.03.2023.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    let viewModel = GasViewModel()
    var realTimeAllGases = [Gas]()
    var reportGas = [Gas]()
    var gasValueListCount: Int?
    var averageTemperature: Double?
    var timer: Timer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Register collection view cell
        collectionView.register(UINib(nibName: "LineChartsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LineChartsCollectionViewCell")
        
        collectionView.register(UINib(nibName: "GaugeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GaugeCollectionViewCell")
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
        
        refreshData()
        
        //        viewModel.postGasReport(date: "-1m", field: "DHT22_Temperature") { result in
        //            switch result {
        //            case .success(let reports):
        //                self.reportGas = reports
        //                //print("REPOrts : \(reports)")
        //                self.gasValueListCount = reports.count
        //            case .failure(let error):
        //                print(error)
        //            }
        //        }
        
        
    }
    func averageTemperatureCalc(gasDataArr: [Gas]) -> Double {
        var totalTemp = 0.0
        var countGas = 0
        for gas in gasDataArr {
            if gas.Name.contains("Temperature") {
                totalTemp += gas.Value
                countGas += 1
            }
        }
        return totalTemp/Double(countGas)
    }
    
    @objc func refreshData() {
        viewModel.getAllGases { result in
            switch result {
            case.success(let gases):
                self.realTimeAllGases = gases
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.averageTemperature = self.averageTemperatureCalc(gasDataArr: self.realTimeAllGases)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realTimeAllGases.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GaugeCollectionViewCell", for: indexPath) as! GaugeCollectionViewCell
            cell.setup(with: TemperatureData.init(temperature: Float(averageTemperature ?? 0)))
            return cell
        } else {
            let newIndexPathRow = indexPath.row - 1
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LineChartsCollectionViewCell", for: indexPath) as! LineChartsCollectionViewCell
            let realTimeGasData = realTimeAllGases[newIndexPathRow]
            
            cell.setup(with: realTimeGasData)
            
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            // Set larger size for first item
            let width = collectionView.bounds.width
            let height = width
            return CGSize(width: width, height: height)
        } else {
            // Set default size for all other items
            let width = (collectionView.bounds.width - 10)
            return CGSize(width: width, height: width / 5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showReport", sender: realTimeAllGases[indexPath.row + 1])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReport" {
            if let selectedGasData = sender as? Gas,
               let reportViewController = segue.destination as? ReportViewController {
                reportViewController.selectedGasName = selectedGasData.Name
                reportViewController.selectedGasValue = selectedGasData.Value
            }
        }
    }
    
}
