//
//  LoginViewController.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/1/18.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    // BaseView
    private var baseView: LoginBaseView { self.view as! LoginBaseView }
    // Rx DisposeBag
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.validateTextField()
    }
}
// MARK: - TextField Validation Method
extension LoginViewController {
    private func validateTextField() {
        self.baseView.userNameTextField.rx.text.subscribe(onNext: { text in
            if let text = text, text.count > self.baseView.maxUserNameLength { return }
            // 現在の入力文字数を反映する処理
            self.baseView.setCurrentUserNameLengthLabel()
        }).disposed(by: disposeBag)
    }
}
