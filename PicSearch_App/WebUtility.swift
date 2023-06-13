//
//  WebUtility.swift
//  PicSearch_App
//
//  Created by Priyadarsini, Anjali (Contractor) on 09/06/23.
//

import Foundation

struct picInfo: Codable{
    var id: String
    var server: String
    var secret: String
    var title: String
}

struct baseInfo: Codable{
    var photo: [picInfo]
}

//var searchText: String?

struct Utility{
    
    //Singleton Pttern
    
    // write a single instance
    static let shared = Utility()
    
    // write a private intializer so that no other instance is created
    private init(){
        
    }
    
    // higher order function
    func GetPic(SearchBar: String, handler: @escaping([baseInfo])-> Void ){
        
//        guard let searchText = searchText else
//        {
//            return
//        }
        
        //do http communication
        let picDataURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=67bbb377ac8922e0bc3e44f61a8a20af&text=\(SearchBar)&format=json&nojsoncallback=1"
        
        //1.get reference of URL session"
        let session = URLSession.shared
        
        //2. create request
        if let url = URL(string: picDataURL){
            
            //3. create task
            let task = session.dataTask(with: url) { picData, picResp, error in
                if error == nil{
                    print("Request suucess: \(picDataURL)")
                    
                    let status = (picResp as! HTTPURLResponse).statusCode
                    
                    switch status{
                    case 20...299:
                        print("Success")
                    case 300...399:
                        print("Redirection")
                    case 400...499:
                        print("Client error")
                    case 500...599:
                        print("Server error")
                    default:
                        print("Unknown error")
                        
                    }
                }
                else {
                    print("Request could not be completed")
                }
                
            }
            //resume tasks
            task.resume()
            
        }
        else{
            print("Invalid URL")
        }
    }
    
    func parsePicData(jsonResponse: Data?) -> [picInfo]{
        guard let jResponse = jsonResponse else
        {
            return []
        }
        do{
            let picdata = try JSONDecoder().decode(picInfo.self, from: jResponse)
            print("Decoded")
            return[picdata]
        }
        catch{
            print("Parsing of data has failed due to \(error.localizedDescription)")
        }
        return []
    }
    
    
    
    func picLoading(server: String, id: String,secret: String, callback : @escaping (URL)->Void){
        let imgURL = "https://live.staticflickr.com/\(server)/\(id)_\(secret)_{size-suffix}.jpg"
        let documntURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagePath = documntURL.appendingPathComponent(id)
        if FileManager.default.fileExists(atPath: imagePath.relativePath){
            callback(imagePath)
            return
        }
        
        let session = URLSession.shared
        
        if let imageUrl = URL(string: imgURL){
            let task = session.downloadTask(with: imageUrl) { tempURL, resp, err in
                if err == nil{
                    let statusC = (resp as! HTTPURLResponse).statusCode
                    
                    if statusC == 200{
                        try! FileManager.default.moveItem(at: tempURL!, to: imagePath)
                        callback(imagePath)
                    }
                    else{
                        print("Something went wrong: \(statusC) ")
                    }
                }
                else{
                    print("network issue")
                }
            }
            //resume tasks
            task.resume()
        }
        else{
            print("invalid url")
        }
    }
}
