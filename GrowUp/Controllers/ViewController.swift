//
//  ViewController.swift
//  GrowUp
//
//  Created by Lerry on 31/08/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLable: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        titleLable.text = ""
        var charIndex = 0.0
        let titleText = K.appName
        for letter in titleText {
            
            Timer.scheduledTimer(withTimeInterval: 0.15 * charIndex, repeats: false){(timer) in
                
                self.titleLable.text?.append(letter)
            }
            charIndex += 1
               
            
            
            
        }
    }



}

