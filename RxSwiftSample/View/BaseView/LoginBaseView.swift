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
    
    // フォームの文字数上限
    private let maxUserNameLength = 15
    private let minPasswordLength = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }
}
// MRK: - Initialized Method
extension LoginBaseView {
    private func initUI() {
        // バリデーションラベル
        self.userNameValidLabel.text = "\(self.maxUserNameLength)文字以下"
        self.passwordValidLabel.text = "\(self.minPasswordLength)文字以上"
        // はじめるボタンの体裁
        self.startButton.layer.masksToBounds = true
        self.startButton.layer.cornerRadius = 5
    }
}
