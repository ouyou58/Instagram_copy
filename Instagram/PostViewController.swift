//
//  PostViewController.swift
//  Instagram
//
//  Created by ouyou on 2019/04/09.
//  Copyright © 2019 ouyou. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class PostViewController: UIViewController {
    
    var image : UIImage?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        //首先获得imageData，就是jpeg格式，然后再把这个jpeg格式的照片转换成base64（一种64中英数字混合一个的数据格式）
        
        let imageData = imageView.image!.jpegData(compressionQuality: 0.5)
        let imageString = imageData!.base64EncodedString(options: .lineLength64Characters)
        let time = Date.timeIntervalSinceReferenceDate  //当前时间
        let name = Auth.auth().currentUser?.displayName
        // 辞書を作成してFirebaseに保存する
        //可以看做是用postRef建立一个本地与firebasedatabase的连接，并自动生成一个唯一的id，当用.childByAutoId的setValue时，就把值和キー封装到一个文件中发到天上，到了天上以后firebase就按照キー找到符合的位置，写入数据
        let postRef = Database.database().reference().child(Const.PostPath)
        let postDic = ["caption": textField.text!, "image": imageString, "time": String(time), "name": name!]
        postRef.childByAutoId().setValue(postDic)
        
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)

    }

    @IBAction func handleCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
