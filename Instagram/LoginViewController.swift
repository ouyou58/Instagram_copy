//
//  LoginViewController.swift
//  Instagram
//
//  Created by ouyou on 2019/04/09.
//  Copyright © 2019 ouyou. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var mailAddressTestField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func handleLoginButton(_ sender: Any) {
        if let address = mailAddressTestField.text,let password = passwordTextField.text {
            if address.isEmpty || password.isEmpty {
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                return
            }
            SVProgressHUD.show()
            
            Auth.auth().signIn(withEmail: address, password: password) {user,error in
                if let error = error {
                        print("DEBUG_PRINT: " + error.localizedDescription)
                        SVProgressHUD.showError(withStatus: "サインインに失敗しました。")
                        return
                }
                print("DEBUG_PRINT: ログインに成功しました。")
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        
        if let address = mailAddressTestField.text,let password = passwordTextField.text,let displayName = displayNameTextField.text {
            
            if address.isEmpty || password.isEmpty || displayName.isEmpty {
                print("DEBUG_PRINT: 何かが空文字です。")
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                return
            }
             SVProgressHUD.show()
            //Auth的auth的createUser方法中，线程会自动进行，通过后面的闭包，会自动捕获到两个值（一个是授权，一个是错误）这两个值会传递给user和error
            Auth.auth().createUser(withEmail:address,password: password) { user,error in
                //如果错误出现了，即error=error：第一个error是系统的error，第二个error是闭包中自己设置的error
                if let error = error {
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "ユーザー作成に失敗しました。")
                    return
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges {error in
                        if let error = error {
                            // プロフィールの更新でエラーが発生
                            print("DEBUG_PRINT: " + error.localizedDescription)
                            SVProgressHUD.showError(withStatus: "表示名の設定に失敗しました。")
                            return
                        }
                        print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                    }
                    SVProgressHUD.dismiss()
                    // 画面を閉じてViewControllerに戻る
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
