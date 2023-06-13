//
//  ThumbNailVC.swift
//  PicSearch_App
//
//  Created by Tripathy, Samiksha (Contractor) on 09/06/23.
//

import UIKit

class ThumbNailVC: UIViewController {
    
    var accquiredData : [baseInfo]? = nil
    var thumbNailText : String?
//    var imgs : [picInfo] = []
    
  
    var photos:[UIImage] = []
    var currentPage : Int = 0
    

    
    @IBOutlet weak var thumbNailTbl: UICollectionView!
    var searcText : String?
    
//    class myCell : UICollectionViewCell{
//        @IBOutlet weak var imageUI: UIImageView!
//
//    }
    
    let limit = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thumbNailTbl.dataSource = self
        thumbNailTbl.delegate = self
        poppulateData()
        
    }
    
    func insertPhotos(){

        var indexPaths = [IndexPath]()
        for i in limit * currentPage..<photos.count {
            let indexPath = IndexPath(item: i, section: 0)
            indexPaths.append(indexPath)
        }

//        ThumbNailVC?.inserrrr (at: indexPaths)

    }

    func poppulateData(){
        if let imageLoad = accquiredData?[0].photo[0].server{
            let imgId = accquiredData?[0].photo[0].id ?? ""
            let imgSec = accquiredData?[0].photo[0].secret ?? ""
            
            
            Utility.shared.picLoading(server: imageLoad, id: imgId, secret: imgSec) { url in
                let imgData = try! Data(contentsOf: url)
                print("\(url)")
                
                
                DispatchQueue.main.async {
                    let image = UIImage(data: imgData)
//                    self.accquiredData!.append(image)
                    self.thumbNailTbl.reloadData()
                }
                
            }
            
    }
        
        
            
            
        }
   
    

    

}

extension ThumbNailVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accquiredData!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.get cell reference
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCellCollectionVC
        
        let pic = photos[indexPath.row]
        
        //2. binding data
//        cell.imageView.image = UIImage(named: photos)
        //cell.image?.image = photos[indexPath.item]
        
        return cell
    }
    
    
}

extension ThumbNailVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPic = photos[indexPath.row]
        print("selected pic \(selectedPic)")
    }
}
