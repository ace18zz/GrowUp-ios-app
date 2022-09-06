//
//  SigninViewController.swift
//  GrowUp
//
//  Created by Lerry on 31/08/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class SigninViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
  

    @IBOutlet weak var errorText: UITextView!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        // check wither email and password are nuil
        if let email = emailTextfield.text, let password = passwordTextfield.text{
        
            Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    self.errorText.text = e.localizedDescription
                } else {
                    //naveigate to the bund page
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
    
}
