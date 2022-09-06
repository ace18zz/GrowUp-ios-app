//
//  LoginViewController.swift
//  GrowUp
//
//  Created by Lerry on 31/08/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBOutlet weak var errorText: UITextView!
    
    
    @IBAction func LoginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
                self.errorText.text = e.localizedDescription
            } else {
                //naveigate to the bund page
                self.performSegue(withIdentifier: K.logInSegue, sender: self)
          // ...
        }
            
        }
            
    }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        // hide back button.
        navigationItem.hidesBackButton = true
    }
    

}

