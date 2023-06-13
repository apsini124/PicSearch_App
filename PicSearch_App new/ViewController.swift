//
//  ViewController.swift
//  PicSearch_App
//
//  Created by Priyadarsini, Anjali (Contractor) on 08/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBgClr()
    }
    private func gradientBgClr(){
        
        //basic setup
        view.backgroundColor = .white
        
        //creating new gradient layer
        let gradientLayer = CAGradientLayer()
        
        //setting location and color for gradient layer
        gradientLayer.colors = [UIColor.systemMint.cgColor,UIColor.white.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        //setting start and end point of gradient
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        //set frame to the layer
        gradientLayer.frame = view.frame
        
        //add gradient layer as a sublayerto bg view
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    @IBAction func goButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        vc.name = nameTextField.text ?? "User"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

