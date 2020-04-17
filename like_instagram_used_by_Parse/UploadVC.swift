//
//  UploadVC.swift
//  like_instagram_used_by_Parse
//
//  Created by JONGWOO JIN on 2020/04/17.
//  Copyright © 2020 JONGWOO JIN. All rights reserved.
//

import UIKit

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(keyboardRecognizer)
        
        postImage.isUserInteractionEnabled = true
        let gestureRecognize = UITapGestureRecognizer(target: self, action: #selector(self.upload))
        postImage.addGestureRecognizer(gestureRecognize)
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
        
    }
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCommentText: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    @IBAction func postButtonClick(_ sender: Any) {
        
    }
    
}
