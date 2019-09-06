//
//  MainTableViewController.swift
//  AppleSearch
//
//  Created by Lewis Jones on 08/11/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var itemSegmentedControl: UISegmentedControl!
    
    var appStoreItems: [AppStoreItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSearchBar.delegate = self
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = itemSearchBar.text, !searchText.isEmpty else { return }
        
        let itemType: AppStoreItem.ItemType = (itemSegmentedControl.selectedSegmentIndex == 0) ? .song : .app
        
        AppStoreItemController.getItemsOf(type: itemType, searchText: searchText) { (items) in
            
            self.appStoreItems = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.itemSearchBar.text = ""
            }
             print(items.count)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appStoreItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppStoreItemCell", for: indexPath) as! ItemTableViewCell

        let appStoreItem = appStoreItems[indexPath.row]
        cell.item = appStoreItem
        

        return cell
    }

}
