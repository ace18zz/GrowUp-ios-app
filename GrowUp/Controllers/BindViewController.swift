//
//  BindViewController.swift
//  GrowUp
//
//  Created by Lerry on 04/09/2022.
//

import UIKit

class BindViewController: UIViewController {
    
    @IBOutlet weak var errorText: UITextField!
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var relationPick: UIPickerView!
    
    @IBAction func DonePressed(_ sender: Any) {
        if (emailTextfield.text?.isEmpty) == true {
            errorText.text = "Please enter E-mail"
           
            
        }else{
            self.performSegue(withIdentifier:K.bindSegue, sender: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
               
            
            
        }
    }


