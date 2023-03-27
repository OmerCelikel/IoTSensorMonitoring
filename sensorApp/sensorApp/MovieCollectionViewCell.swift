//
//  MovieCollectionViewCell.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 27.03.2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    func setup(with movie: Movie) {
        movieImageView.image = movie.image
        titleLbl.text = movie.title
    }
}
