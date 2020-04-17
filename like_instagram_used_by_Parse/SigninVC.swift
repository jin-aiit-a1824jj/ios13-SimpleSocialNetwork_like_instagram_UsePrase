//
//  SigninVC.swift
//  like_instagram_used_by_Parse
//
//  Created by JONGWOO JIN on 2020/04/17.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import UIKit
import Parse


class SigninVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.alert(title: "Error", message: error?.localizedDescription ?? "Unknown error" )
                }else{
                    print("welcome: \((user!.username ?? " "))")
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        } else {
            self.alert(title: "Error", message: "Username needed!")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != "" {
            let user = PFUser()
            user.username = self.userNameText.text!
            user.password = self.passwordText.text!
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.alert(title: "Error", message: error?.localizedDescription ?? "Unknown error" )
                }else{
                    print("user create")
                }
            }
        } else {
            self.alert(title: "Error", message: "Username needed!")
        }
    }
    
    func alert(title: String, message: String) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
