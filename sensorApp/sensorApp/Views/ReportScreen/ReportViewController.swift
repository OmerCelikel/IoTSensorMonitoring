//
//  ReportViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 27.03.2023.
//

import UIKit

class ReportViewController: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "Temperature", image: "https://picsum.photos/100/200"),
        .init(id: "id2", name: "CO2", image: "https://picsum.photos/100/200"),
        .init(id: "id3", name: "CO", image: "https://picsum.photos/100/200"),
        .init(id: "id4", name: "Humidity", image: "https://picsum.photos/100/200")
        
    ]
    
    var times: [TimeCategory] = [
        .init(id: "id11", name: "1 Day"),
        .init(id: "id12", name: "1 Week"),
        .init(id: "id13", name: "1 Month")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        timeCollectionView.register(UINib(nibName: TimeCategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TimeCategoryCollectionViewCell.identifier)
    }

}

extension ReportViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case timeCollectionView:
            return times.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        case timeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCategoryCollectionViewCell.identifier, for: indexPath) as! TimeCategoryCollectionViewCell
            cell.setup(category: times[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: - When select items change color of view to purple.
        print("didSelectItemAt")
        
        if let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.backgroundColor = .purple
            }
    }
}
