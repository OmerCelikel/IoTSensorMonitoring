//
//  ValuesViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 26.04.2023.
//

import UIKit

class ValuesViewController: UIViewController {

    @IBOutlet weak var gas1NameLabel: UILabel!
    @IBOutlet weak var gas1ValueLabel: UILabel!
    
    @IBOutlet weak var gas2NameLabel: UILabel!
    @IBOutlet weak var gas2ValueLabel: UILabel!
    
    @IBOutlet weak var gas3NameLabel: UILabel!
    @IBOutlet weak var gas3ValueLabel: UILabel!
    
    let viewModel = GasViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewModel.getAllGases { result in
            switch result {
            case.success(let gases):
                
                DispatchQueue.main.async {
                    gas1NameLabel.text = gases[
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    

}
