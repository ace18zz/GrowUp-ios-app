//
//  RewordListViewController.swift
//  GrowUp
//
//  Created by Lerry on 05/09/2022.
//
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class RewordListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var itemArray = [Item]()
    
    let db = Firestore.firestore()
   
    @IBOutlet weak var points: UITextField!
    
    @IBAction func upDatePressed(_ sender: UIButton) {
        var pointArray = [Int]()
            
            
        db.collection(FStore.collectionName2).getDocuments {(querySnapshot, error ) in
                if let e = error {
                    print ("error shows \(e)")
                }else {
                    
                    if let snapDoc = querySnapshot?.documents {
                        for doc in snapDoc {
                            let data = doc.data()
                           if let messender = data[FStore.senderField] as? String,
                              let point = data [FStore.dateField] as? Int, let donebody = data[FStore.doneField] as? Bool {
                               
                               let newItem = Item()

                               newItem.point = point
                               newItem.sender = messender
                               newItem.done = donebody
                               
                               if Auth.auth().currentUser?.email != messender, donebody == true{
                                   pointArray.append(point)
                                  let totalPoints = pointArray.reduce(0, +)
                                   self.points.text = String(totalPoints)
                                   
                                   
                               }else{
                                   print("no item reword")
                               }

                               
    //                           print(self.itemArray[0].title)
                               
                               
                            
                           }
                        }
                    }
                }
            }
        }
    
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        tableView.dataSource = self

        loadMessages()
    }
    func loadMessages(){
        itemArray = []
        
        
        db.collection("reword2").getDocuments {(querySnapshot, error ) in
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
                               print("no item reword")
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
    extension RewordListViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "rewordCell", for: indexPath)
        
        cell.textLabel?.text = item.title + "          " + String(item.point) + "  Points"
        
        // check the item is done or not
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }
    
    // TableView Delegate Methods
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let items = itemArray[indexPath.row]
        let listSender = Auth.auth().currentUser?.email
        
        if items.done == false {
            items.done = true
        }else {
            items.done = false
        }
//        self.db.collection("reword").addDocument(data: [FStore.senderField:listSender,FStore.bodyField:items.title,FStore.dateField:items.point,FStore.doneField:items.done]){(error) in
//            if error != nil {
//                print("saving error")
//
//            }else{
//                print("save done")
//            }
//
//        }
    
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        var pointField = UITextField()
        let listSender = Auth.auth().currentUser?.email
        
        let alert = UIAlertController(title: "Add New Reword", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Reword", style: .default) { (action) in
            // when user click add
           let newItem = Item()
            newItem.title = textField.text!
            
           let point = Int(pointField.text!)
            newItem.point = point!
            
            self.itemArray.append(newItem)

            self.db.collection("reword2").addDocument(data: [FStore.senderField:listSender,FStore.bodyField:textField.text,FStore.dateField:point]){(error) in
                if error != nil {
                    print("saving error")

                }else{
                    print("svaed")
                }

            }
            self.tableView.reloadData()
            
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Creat new Reword"
            textField = alertTextField
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Enter the cost of Points"
            pointField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
        
    }
   


