//
//  HomeViewController.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 22.04.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var gasesTableView: UITableView!
    
    let helloWorldStrings = (1...20).map { _ in "Hello World" }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gasesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World"
        return cell
    }
    
}

