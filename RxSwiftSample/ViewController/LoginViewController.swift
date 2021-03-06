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
        self.didTapStartButton()
    }
}
// MARK: - Privagte Method
extension LoginViewController {
    private func didTapStartButton() {
        self.baseView.startButton.rx.tap.subscribe({ [weak self] _ in
            self?.transitionPhotoSearcPage()
        }).disposed(by: self.disposeBag)
    }
    private func transitionPhotoSearcPage() {
        let s = UIStoryboard(name: "PhotoSearchViewController", bundle: nil)
        let vc = s.instantiateViewController(identifier: "PhotoSearchViewController") as! UINavigationController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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
