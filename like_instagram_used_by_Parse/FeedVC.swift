//
//  FeedVC.swift
//  like_instagram_used_by_Parse
//
//  Created by JONGWOO JIN on 2020/04/17.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import UIKit
import Parse

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postUuidArray = [String]()
    var postImageArray = [PFFileObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postOwnerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userNameLabel.text = self.postOwnerArray[indexPath.row]
        cell.postCommentText.text  = self.postCommentArray[indexPath.row]
        cell.uuidLabel.text  = self.postUuidArray[indexPath.row]
        
        postImageArray[indexPath.row].getDataInBackground { (data, error) in
            if error != nil {
                self.alert(title: "Error", message: error?.localizedDescription ?? "unknows error")
            } else {
                cell.postImage.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
    @objc func getData() {
        let query = PFQuery(className: "Posts")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.alert(title: "Error", message: error?.localizedDescription ?? "unknowns error" )
            }else{
                self.postOwnerArray.removeAll(keepingCapacity: true)
                self.postCommentArray.removeAll(keepingCapacity: true)
                self.postUuidArray.removeAll(keepingCapacity: true)
                self.postImageArray.removeAll(keepingCapacity: true)
                
                for object in objects! {
                    
                    let d = object.object(forKey: "postedowner") as! String
                    self.postOwnerArray.append(d)

                    let c = object.object(forKey: "postcomment") as! String
                    self.postCommentArray.append(c)
                    
                    let u = object.object(forKey: "postuuid") as! String
                    self.postUuidArray.append(u)
                    
                    self.postImageArray.append(object.object(forKey: "postimage") as! PFFileObject)
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.getData), name: NSNotification.Name("newPost"), object: nil)
    }
    
}
