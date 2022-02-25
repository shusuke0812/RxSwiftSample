//
//  LoginBaaseView.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/1/18.
//

import UIKit

class LoginBaseView: UIView {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameValidLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var maxUserNameLengthLabel: UILabel!
    @IBOutlet weak var currentUserNameLengthLabel: UILabel!
    
    // フォームの文字数上限下限
    let maxUserNameLength = 15
    let minPasswordLength = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
}
// MRK: - Initialized Method
extension LoginBaseView {
    private func initUI() {
        // フォーム
        userNameTextField.placeholder = "名前"
        passwordTextField.placeholder = "パスワード"
        // バリデーションラベル
        userNameValidLabel.text = "必須入力項目です"
        passwordValidLabel.text = "必須入力項目です"
        maxUserNameLengthLabel.text = "\(self.maxUserNameLength)"
        currentUserNameLengthLabel.text = "0"
        // はじめるボタンの体裁
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 5
    }
}
// MARK: - Setting UI Method
extension LoginBaseView {
    func setCurrentUserNameLengthLabel() {
        if let textLength = userNameTextField.text?.count {
            currentUserNameLengthLabel.text = "\(textLength)"
        }
    }
}
