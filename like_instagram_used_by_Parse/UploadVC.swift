//
//  UploadVC.swift
//  like_instagram_used_by_Parse
//
//  Created by JONGWOO JIN on 2020/04/17.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(keyboardRecognizer)
        
        postImage.isUserInteractionEnabled = true
        let gestureRecognize = UITapGestureRecognizer(target: self, action: #selector(self.upload))
        postImage.addGestureRecognizer(gestureRecognize)
        
        self.postButton.isEnabled = false
    }
    
    @objc func hideKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func upload(_ sender: Any){
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        postImage?.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        self.postButton.isEnabled = true
    }
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCommentText: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    @IBAction func postButtonClick(_ sender: Any) {
        self.postButton.isEnabled = false
        
        let object = PFObject(className: "Posts")
        if let data = postImage.image?.jpegData(compressionQuality: 0.5) {
            if let pfImage = PFFileObject(name: "image.jpg", data: data) {
                object["postimage"] = pfImage
                object["postcomment"] = self.postCommentText.text!
                object["postedowner"] = PFUser.current()!.username!
                
                let uuid = UUID().uuidString
                object["postuuid"] = "\(uuid)_\(PFUser.current()!.username!)"
                
                object.saveInBackground { (success, error) in
                    if error != nil {
                        self.alert(title: "Error", message: error?.localizedDescription ?? "Unknows error")
                    } else {
                        self.postCommentText.text = ""
                        self.postImage.image = UIImage(named: "selec.jpg")
                        self.tabBarController?.selectedIndex = 0
                        
                        NotificationCenter.default.post(name: NSNotification.Name("newPost"), object: nil)
                    }
                }
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
