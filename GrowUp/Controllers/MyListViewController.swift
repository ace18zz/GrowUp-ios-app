//
//  MyListViewController.swift
//  GrowUp
//
//  Created by Lerry on 31/08/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import SwipeCellKit



class MyListViewController: UITableViewController {
   
    var itemArray = [Item]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        

        loadMessages()
        tableView.rowHeight = 70.0
        

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
                          let point = data [FStore.dateField] as? Int, let messagebody = data[FStore.bodyField] as? String{
                           
                           let newItem = Item()
                           newItem.title = messagebody
                           newItem.point = point
                           newItem.sender = messender
                    
                           
                           if Auth.auth().currentUser?.email == messender {
                               self.itemArray.append(newItem)
                           }else{
                               print("no item")
                           }
                           
                           
                           DispatchQueue.main.async {
                               self.tableView.reloadData()
                           }
                        
                       }
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyListCell", for: indexPath) as! SwipeTableViewCell
        
        cell.textLabel?.text = item.title + "          " + String(item.point) + "  Points"
        cell.delegate = self
        // check the item is done or not
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }
    
    // TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let items = itemArray[indexPath.row]
        let listSender = Auth.auth().currentUser?.email
        
        if items.done == false {
            items.done = true
        }else {
            items.done = false
        }
        self.db.collection(FStore.collectionName2).addDocument(data: [FStore.senderField:listSender,FStore.bodyField:items.title,FStore.dateField:items.point,FStore.doneField:items.done]){(error) in
            if error != nil {
                print("saving error")

            }else{
                print("save done")
            }

        }
    
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        var pointField = UITextField()
        let listSender = Auth.auth().currentUser?.email
        
        let alert = UIAlertController(title: "Add New Thing", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Thing", style: .default) { (action) in
            // when user click add
           let newItem = Item()
            newItem.title = textField.text!
            
           let point = Int(pointField.text!)
            newItem.point = point!
            
            self.itemArray.append(newItem)

            self.db.collection(FStore.collectionName).addDocument(data: [FStore.senderField:listSender,FStore.bodyField:textField.text,FStore.dateField:point]){(error) in
                if error != nil {
                    print("saving error")

                }else{
                    print("svaed")
                }

            }
            self.tableView.reloadData()
            
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Creat new Thing"
            textField = alertTextField
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Enter the Points"
            pointField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}

// Swipe cell delegate Methods
extension MyListViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
//            let items = self.itemArray[indexPath.row]
//            self.db.collection(FStore.collectionName).document().delete() { err in
//                if let err = err {
//                    print("Error removing document: \(err)")
//                } else {
//                    print("Document successfully removed!")
//                }
            
             self.itemArray.remove(at: indexPath.row)
            
                tableView.reloadData()
            
        
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
    
}
