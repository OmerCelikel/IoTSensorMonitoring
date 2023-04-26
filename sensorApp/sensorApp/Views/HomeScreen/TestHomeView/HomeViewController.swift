//
//  HomeViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 22.04.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var gasesTableView: UITableView!
    
    let viewModel = GasViewModel()
    var realTimeAllGases = [Gas]()
   
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Schedule timer to refresh data every 2 seconds
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
        
        // Fetch initial data
        refreshData()
    }
    
    @objc func refreshData() {
        viewModel.getAllGases { result in
            switch result {
            case.success(let gases):
                
                DispatchQueue.main.async {
                    self.realTimeAllGases = gases
                    self.gasesTableView.reloadData()
//                    print("realTimeAllGases \(self.realTimeAllGases)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realTimeAllGases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let realTimeAllGasDataForCell = realTimeAllGases[indexPath.row]
        cell.setup(gasData: realTimeAllGasDataForCell)
        if indexPath.row == 0 {
            print("cell: \(cell.gasNameLabel) \n")
            print("cell: \(cell.gasValueLabel) \n")
            print(": ------- \n")
        }
        
        return cell
    }
    
}

