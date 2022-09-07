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
   
    @IBOutlet weak var tableView: UITableView!

    
    var itemArray = [Item]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        
        tableView.dataSource = self

        loadMessages()
        

    }
    func loadMessages(){
        itemArray = []
        
        
        db.collection(FStore.collectionName).getDocuments {(querySnapshot, error ) in
            if let e = error {
                print ("error shows \(e)")
            }else {
                
                if let snapDoc = querySnapshot?.documents {
                    for doc in snapDoc {
                        let data = doc.data()
                       if let messender = data[FStore.senderField] as? String,
                          let point = data [FStore.dateField] as? Int, let messagebody = data[FStore.bodyField] as? String {
                           
                           let newItem = Item()
                           newItem.title = messagebody
                           newItem.point = point
                           newItem.sender = messender
                           if Auth.auth().currentUser?.email != messender {
                               self.itemArray.append(newItem)
                           }else{
                               print("no item")
                           }
                           
//                           print(self.itemArray[0].title)
                           
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                           }
                        
                       }
                    }
                }
            }
        }
    }

    }


extension HerListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)

        cell.textLabel?.text = item.title + "          " + String(item.point) + "  Points"

        // check the item is done or not
        //cell.accessoryType = item.done ? .checkmark : .none

        return cell


    }



}
