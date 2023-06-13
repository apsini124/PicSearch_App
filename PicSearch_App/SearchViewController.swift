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
        SearchBar.delegate = self
        
    }
    
    
    
    let limit = 20
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "showCollectionSegue" {
//                if let destinationVC = segue.destination as? ThumbNailVC {
//                    destinationVC.searchText = SearchBar.text
//                }
//            }
//        }
    
    
    
    func searchBar(_searchBar: UISearchBar, textDidChange searchText: String){
//
//        let imageNm = SearchBar.text ?? ""
////        if let destinationVC = segue.destination as? ThumbNailVC{
////            destinationVC.searchText = SearchBar.text
//
        Utility.shared.GetPic(SearchBar: searchText) { picArray in
            print(picArray)

            DispatchQueue.main.async {let vc = self.storyboard?.instantiateViewController(withIdentifier: "thumbNail") as! ThumbNailVC
                    vc.accquiredData = picArray
                    self.present(vc, animated: true)
//
                }
//
//
            }
        }
    }
    




extension SearchViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSegue(withIdentifier: "thumbNail", sender: searchText)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "thumbNail"{
            
            if let destinationVC = segue.destination as? ThumbNailVC,
               let searchText = sender as? String{
                
                destinationVC.thumbNailText = searchText
                
            }
        }
        
    }
    
}






