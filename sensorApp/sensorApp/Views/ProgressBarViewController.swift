//
//  ProgressBarViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 5.04.2023.
//

import UIKit

class ProgressBarViewController: UIViewController {
    
    @IBOutlet weak var gaugaView: GaugeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gaugaView.value = 0
    }


}
