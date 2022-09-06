//
//  SettingViewController.swift
//  GrowUp
//
//  Created by Lerry on 05/09/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class SettingViewController: UIViewController {
    
    @IBAction func logOut(_ sender: Any) {
            do {
                try Auth.auth().signOut()
                // go back to the welcome page
                navigationController?.popToRootViewController(animated: true)
                

            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
          
        }
        
        
    
    @IBAction func changeEmail(_ sender: UIButton) {
        
    }
    @IBAction func clearPoints(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        }
    
    
    
    }



