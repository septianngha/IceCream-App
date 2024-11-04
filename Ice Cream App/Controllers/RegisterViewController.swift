//
//  RegisterViewController.swift
//  Ice Cream App
//
//  Created by Muhamad Septian Nugraha on 03/11/24.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    // MARK: - Register Button Tapped
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    
                    print("Error creating user: \(e.localizedDescription)")
                } else {
                    
                    // Simpan nama pengguna ke Firestore setelah registrasi berhasil
                    if let user = authResult?.user {
                        let db = Firestore.firestore()
                        db.collection("users").document(user.uid).setData([
                            "name": name,
                            "email": email
                        ]) { error in
                            
                            if let e = error {
                                
                                print("Error saving user data: \(e.localizedDescription)")
                            } else {
                                
                                // Pindah ke HomeViewController setelah berhasil registrasi dan simpan data
                                self.performSegue(withIdentifier: Constans.registerSegue, sender: self)
                            }
                        }
                    }
                }
            }
        }

    }
}
