//
//  ProgressBarViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 5.04.2023.
//

import UIKit

class ProgressBarViewController: UIViewController {

    @IBOutlet weak var progressBarView: ProgressBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let progressBarView = progressBarView {
            progressBarView.progress = 1
        }

    }


}
