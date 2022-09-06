//
//  EnterPageViewController.swift
//  GrowUp
//
//  Created by Lerry on 05/09/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class EnterPageViewController: UIViewController {

        override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        // hide back button.
        navigationItem.hidesBackButton = true
    }

}
