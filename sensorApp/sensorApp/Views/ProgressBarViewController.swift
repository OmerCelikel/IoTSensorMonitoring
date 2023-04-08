//
//  ProgressBarViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 5.04.2023.
//

import UIKit

class ProgressBarViewController: UIViewController {
    
    @IBOutlet weak var gaugeView: GaugeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gaugeView.startAnimation()
        gaugeView.value = 55.1
        
    }


}
