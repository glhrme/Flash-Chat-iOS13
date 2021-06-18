//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let e = error {
                self.alertPresent(title: "Error", message: e.localizedDescription) { (alert) in
                    
                }
            } else {
                self.alertPresent(title: "Sucesso", message: "Sucesso no cadastro") {
                    alert in
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }
    }
    
    func alertPresent(title: String, message: String, handle: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Continuar", style: .cancel, handler: handle)
        alert.addAction(dismiss)
        present(alert, animated: true, completion: nil)
    }
    
}
