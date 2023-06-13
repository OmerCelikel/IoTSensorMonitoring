//
//  CardView.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 28.03.2023.
//

import UIKit

class CardView: UIView {
    var isSelected = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        //layer.backgroundColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0).cgColor
        //layer.backgroundColor = UIColor.white.cgColor
        layer.backgroundColor = isSelected ? Colors.lineGraphLineColor.cgColor : UIColor.white.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3) // Adjust the vertical offset to control the distance of the shadow from the view
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.25 // Adjust the opacity of the shadow
        layer.shadowRadius = 5 // Adjust the blur radius of the shadow
        clipsToBounds = false // Allows the shadow to extend beyond the bounds of the view
    }
}
