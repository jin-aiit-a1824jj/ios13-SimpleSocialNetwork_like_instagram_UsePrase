//
//  FeedCell.swift
//  like_instagram_used_by_Parse
//
//  Created by JONGWOO JIN on 2020/04/17.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import UIKit
import Parse

class FeedCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCommentText: UITextView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uuidLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeClicked(_ sender: Any) {
    
        let likeObject = PFObject(className: "Likes")
        likeObject["from"] = PFUser.current()!.username!
        likeObject["to"] = uuidLabel.text!
        likeObject.saveInBackground { (success, error) in
            if error != nil {
                self.alert(title: "Error", message: error?.localizedDescription ?? "unknown error")
            }else{
                print("like has been saved")
            }
        }
    
    }
    
    @IBAction func commentClicked(_ sender: Any) {
        
        let commentObject = PFObject(className: "Comments")
        commentObject["from"] = PFUser.current()!.username!
        commentObject["to"] = uuidLabel.text!
        commentObject.saveInBackground { (success, error) in
            if error != nil {
                self.alert(title: "Error", message: error?.localizedDescription ?? "unknown error")
            }else{
                print("like has been saved")
            }
        }
        
    }
    
    func alert(title: String, message: String) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window!.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
