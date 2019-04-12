//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by ouyou on 2019/04/09.
//  Copyright © 2019 ouyou. All rights reserved.
//

import UIKit
import CLImageEditor

class ImageSelectViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLImageEditorDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //UIImagePickerController中封装的一个方法，当在选择照片的界面，选择一张照片后，或者是相机照完相之后，自动执行这个方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] != nil {
            let image = info[.originalImage] as! UIImage
            print("DEBUG_PRINT: image = \(image)")
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            //pushViewController方法是在界面推出来一个新controller名字是  editor
            picker.pushViewController(editor, animated: true)

        }
    }
    
    //IImagePickerController中封装的一个方法，当选择照片的界面点取消按钮时，执行这个方法
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //CLImageEditor中封装的一个方法，当画像加工完成时，也就是点击Done时，执行这个方法
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        let postViewController = self.storyboard? .instantiateViewController(withIdentifier: "Post") as! PostViewController
        postViewController.image = image!
        editor.present(postViewController, animated: true, completion: nil)
    }
    
    @IBAction func handleLibraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
