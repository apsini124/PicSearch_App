//
//  SearchViewController.swift
//  PicSearch_App
//
//  Created by Priyadarsini, Anjali (Contractor) on 08/06/23.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var SearchHistoryTable: UITableView!
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "\(name)"
        
    }
    
    @IBAction func SearchButton(_ sender: Any) {
    }
    
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
}
