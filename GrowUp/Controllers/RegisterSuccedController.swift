//
//  RegisterSuccedController.swift
//  GrowUp
//
//  Created by Lerry on 03/09/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterSuccedController: UIViewController {
    @IBOutlet weak var Loginbutton: UIButton!
    
    @IBOutlet weak var backToMain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        // hide back button.
        navigationItem.hidesBackButton = true
    }

}
