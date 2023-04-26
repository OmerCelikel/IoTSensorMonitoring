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

        viewModel.getAllGases { result in
            switch result {
            case.success(let gases):
                self.realTimeAllGases = gases
                DispatchQueue.main.async {
                    print(" -> realTimeAllGases From DispatchQueue \(self.realTimeAllGases)")
                    self.gasesTableView.reloadData()
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
        return cell
    }
    
}

