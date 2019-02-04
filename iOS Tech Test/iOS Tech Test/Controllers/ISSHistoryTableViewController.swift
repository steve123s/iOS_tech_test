//
//  ISSHistoryTableViewController.swift
//  iOS Tech Test
//
//  Created by Daniel Esteban Salinas Suárez on 2/3/19.
//  Copyright © 2019 Urbvan Trantist. All rights reserved.
//

import UIKit

class ISSHistoryTableViewController: UITableViewController {

    var ISSPositions = [PositionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ISSPositions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ISSHistoryCell", for: indexPath)
        let ISSPosition = ISSPositions[indexPath.row]
        cell.textLabel?.text = "Time: \(ISSPosition.timeObtained)"
        cell.detailTextLabel?.text = "Latitude: \(ISSPosition.position.latitude) Longitude: \(ISSPosition.position.longitude)"
        return cell
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // Dismiss NavigationController to return to mapView
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
