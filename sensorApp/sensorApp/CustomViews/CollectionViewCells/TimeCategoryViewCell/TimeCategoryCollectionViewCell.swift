//
//  TimCategoryCollectionViewCell.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 28.03.2023.
//

import UIKit

class TimeCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: TimeCategoryCollectionViewCell.self)
    
    @IBOutlet weak var timeCategoryTitleLbl: UILabel!
    
    func setup(category: TimeCategory) {
        timeCategoryTitleLbl.text = category.name
    }

}
