//
//  FeedVC.swift
//  like_instagram_used_by_Parse
//
//  Created by JONGWOO JIN on 2020/04/17.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import UIKit
import Parse

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutClicked(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                self.alert(title: "Error", message: error?.localizedDescription ?? "Unknow error")
            } else {
                print("logout")
                
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
                
                let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signUp") as! SigninVC
                
                let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
                sceneDelegate.window!.rootViewController = signIn
                
            }
        }
    }
    
    func alert(title: String, message: String) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
