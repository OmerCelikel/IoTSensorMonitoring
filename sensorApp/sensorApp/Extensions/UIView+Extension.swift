//
//  UIView+Extension.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 28.03.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

