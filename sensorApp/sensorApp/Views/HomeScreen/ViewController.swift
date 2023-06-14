//
//  ViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 27.03.2023.
//

import UIKit
import Charts

protocol NotificationDelegate: AnyObject {
    func didReceiveNotification(withTitle title: String)
}


class ViewController: UIViewController {
    
    let viewModel = GasViewModel()
    var realTimeAllGases = [Gas]()
    var reportGas = [Gas]()
    var gasValueListCount: Int?
    var averageTemperature: Double?
    var timer: Timer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var warningText: UILabel!
    @IBOutlet weak var closeWarningButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Register collection view cell
        collectionView.register(UINib(nibName: "LineChartsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LineChartsCollectionViewCell")
        collectionView.register(UINib(nibName: "GaugeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GaugeCollectionViewCell")
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.notificationDelegate = self

        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
        refreshData()

    }
    
    public func showWarningView(asNotification: String, isItHidden: Bool) {
        warningView.isHidden = isItHidden
        warningText.text = "Warning! \(asNotification) values is out of range."
        showAlert(sensorType: asNotification)
        
    }
    
    @IBAction func closeWarningButtonTapped(_ sender: Any) {
        warningView.isHidden = true
    }
    
    func showAlert(sensorType: String) {
        let dialogMessage = UIAlertController(title: "Alert", message: "\(sensorType) is out of range!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK button tapped")
        }
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func averageTemperatureCalc(gasDataArr: [Gas]) -> Double {
        var totalTemp = 0.0
        var countGas = 0
        for gas in gasDataArr {
            if gas.name.contains("Temperature") {
                totalTemp += gas.value
                countGas += 1
            }
        }
        return totalTemp/Double(countGas)
    }
    
    @objc func refreshData() {
        viewModel.getAllGases { [weak self] result in
            guard let self = self else { return } // Ensure self is still available
            
            switch result {
            case .success(let gases):
                // Filter out the unwanted gases
                let filteredGases = gases.filter { $0.name != "MQ6_LPG" && $0.name != "DHT11_Humidity" && $0.name != "DHT11_Temperature" }
                
                self.realTimeAllGases = filteredGases
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                self.averageTemperature = self.averageTemperatureCalc(gasDataArr: filteredGases)
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
        if indexPath.row == 0 {
            performSegue(withIdentifier: "showReport", sender: realTimeAllGases[3])
        } else {
            performSegue(withIdentifier: "showReport", sender: realTimeAllGases[indexPath.row - 1])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReport" {
            if let selectedGasData = sender as? Gas,
               let reportViewController = segue.destination as? ReportViewController {
                reportViewController.selectedGasName = selectedGasData.name
                reportViewController.selectedGasValue = selectedGasData.value
            }
        }
    }
    
}

extension ViewController: NotificationDelegate {
    func didReceiveNotification(withTitle title: String) {
        showAlert(sensorType: title)
        showWarningView(asNotification: title, isItHidden: false)
    }
}
