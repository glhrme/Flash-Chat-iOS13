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
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: Constants.Nibname, bundle: nil), forCellReuseIdentifier: Constants.cellReusable)
        title = "RaioChat"
        navigationItem.hidesBackButton = true
        loadMessages()
    }
    
    func loadMessages() {
        db.collection("messages").order(by: "date").addSnapshotListener { (querySnapshot, error) in
            if let e = error {
                print(e)
            } else if let documents = querySnapshot?.documents{
                self.messageTextfield.text = ""
                self.messages = []
                for message in documents {
                    let doc = message.data()
                    if let sender = doc["sender"] as? String, let body = doc["body"] as? String {
                        self.messages.append(Message(sender: sender, body: body))
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
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
            self.db.collection("messages").addDocument(data: ["sender": messageSender, "body": messageBody, "date": Date().timeIntervalSince1970]) { (error) in
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
