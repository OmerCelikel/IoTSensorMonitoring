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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Register collection view cell
        collectionView.register(UINib(nibName: "LineChartsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LineChartsCollectionViewCell")
        
        collectionView.register(UINib(nibName: "GaugeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GaugeCollectionViewCell")
        
        
        viewModel.getAllGases { result in
            switch result {
            case.success(let gases):
                self.realTimeAllGases = gases
                DispatchQueue.main.async {
                    //print(" -> realTimeAllGases From DispatchQueue \(self.realTimeAllGases)")
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        viewModel.postGasReport(date: "-1m", field: "DHT22_Temperature") { result in
            switch result {
            case .success(let reports):
                self.reportGas = reports
                //print("REPOrts : \(reports)")
                self.gasValueListCount = reports.count
            case .failure(let error):
                print(error)
            }
        }

        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return chartData.count
        return realTimeAllGases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GaugeCollectionViewCell", for: indexPath) as! GaugeCollectionViewCell
            cell.setup(with: TemperatureData.init(temperature: 50))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LineChartsCollectionViewCell", for: indexPath) as! LineChartsCollectionViewCell
            let realTimeGasData = realTimeAllGases[indexPath.row - 1]
            
            print("Index path: \(indexPath.row)")
            print("Cell data count: \(realTimeAllGases.count)")
            if realTimeGasData.Name == reportGas[indexPath.row].Name {
                print("FOUND : \(reportGas[indexPath.row - 1].Name)")
                //cell.setupTable()
            }
            cell.setup2(with: realTimeGasData)
            
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
        let selectedGasData = chartData[indexPath.item]
        performSegue(withIdentifier: "showReport", sender: selectedGasData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReport" {
            if let selectedGasData = sender as? ChartData,
               let reportViewController = segue.destination as? ReportViewController {
                reportViewController.chartData = selectedGasData
            }
        }
    }
    
}
