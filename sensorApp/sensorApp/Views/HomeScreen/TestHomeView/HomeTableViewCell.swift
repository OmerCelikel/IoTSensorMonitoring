//
//  HomeTableViewCell.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 26.04.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gasNameLabel: UILabel!
    @IBOutlet weak var gasValueLabel: UILabel!
    
    func setup(gasData: Gas) {
        gasNameLabel.text = gasData.Name
        gasValueLabel.text = String(format: "%.2f",gasData.Value)
        
    }
}
