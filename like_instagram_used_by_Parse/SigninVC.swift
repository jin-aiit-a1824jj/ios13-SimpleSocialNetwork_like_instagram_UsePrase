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
        
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "apple"
        parseObject["calories"] = 100
        parseObject.saveInBackground { (success, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                print("Successful!")
            }
        }
    }
    

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    
    @IBAction func signInClicked(_ sender: Any) {
            performSegue(withIdentifier: "toTabBar", sender: nil)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
    
    }
    
}
