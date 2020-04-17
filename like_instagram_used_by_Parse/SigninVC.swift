//
//  SigninVC.swift
//  like_instagram_used_by_Parse
//
//  Created by JONGWOO JIN on 2020/04/17.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import UIKit

class SigninVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    
    @IBAction func signInClicked(_ sender: Any) {
            performSegue(withIdentifier: "toTabBar", sender: nil)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
    
    }
    
}
