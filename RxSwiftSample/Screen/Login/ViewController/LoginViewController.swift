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
    private var baseView: LoginBaseView { view as! LoginBaseView }

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
        }).disposed(by: disposeBag)
    }
    private func transitionPhotoSearcPage() {
        let s = UIStoryboard(name: "PhotoSearchViewController", bundle: nil)
        let vc = s.instantiateViewController(identifier: "PhotoSearchViewController") as! UINavigationController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
// MARK: - TextField Validation Method
extension LoginViewController {
    private func validateTextField() {
        baseView.userNameTextField.rx.text.subscribe(onNext: { text in
            if let text = text, text.count > self.baseView.maxUserNameLength { return }
            // 現在の入力文字数を反映する処理
            self.baseView.setCurrentUserNameLengthLabel()
        }).disposed(by: disposeBag)
    }
}
