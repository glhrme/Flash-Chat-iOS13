//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
        Message(sender: "guilherme@guisantos.com.br", body: "Oi", destination: "guilherme1@guisantos.com.br"),
        Message(sender: "guilherme1@guisantos.com.br", body: "Oi", destination: "guilherme@guisantos.com.br"),
        Message(sender: "guilherme@guisantos.com.br", body: "Oi2", destination: "guilherme1@guisantos.com.br")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: Constants.Nibname, bundle: nil), forCellReuseIdentifier: Constants.cellReusable)
        title = "RaioChat"
        navigationItem.hidesBackButton = true
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            self.db.collection("messages").addDocument(data: ["sender": messageSender, "message": messageBody]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    print("saved")
                }
            }
        }
        
    }
    

}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReusable, for: indexPath) as! MessageCell
        cell.label.text = self.messages[indexPath.row].body
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
