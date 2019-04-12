//
//  CommentViewController.swift
//  Instagram
//
//  Created by ouyou on 2019/04/11.
//  Copyright © 2019 ouyou. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CommentViewController: UIViewController {
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentButton: UIButton!
    var postData : PostData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func commentButton(_ sender: Any) {
        print("DEBUG_PRINT" + "コメントブタンをされました")

        //当我想往同一个db中插入数据时，像这样做
        let postRef = Database.database().reference().child(Const.PostPath).child(postData!.id!)
        
        let user = Auth.auth().currentUser
        var displayName = user!.displayName
        //var oldComments = postData!.comments
        let commentText = String(commentTextView.text!)
        let nowComment = [displayName!:commentText]
        postData!.comments.append(nowComment)
        let comments = ["comments": postData!.comments]
        postRef.updateChildValues(comments)
        
        SVProgressHUD.showSuccess(withStatus: "コメントをしました")
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
