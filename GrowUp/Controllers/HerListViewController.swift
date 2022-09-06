//
//  HerListViewController.swift
//  GrowUp
//
//  Created by Lerry on 05/09/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class HerListViewController: UIViewController {
   
    @IBOutlet var ListTableView: UITableView!
    
    let itemArray = ["11","22","33"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListTableView.dataSource = (self)
        title = K.appName
  
    }
}

extension HerListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = "this is a cell"
        
        return cell
    }
    
    
}
