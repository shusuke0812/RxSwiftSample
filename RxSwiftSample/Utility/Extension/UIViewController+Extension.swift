//
//  UIViewController+Extension.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/22.
//

import UIKit

extension UIViewController {
    /// キーボードを立ち上げた時にキーボード以外をタップしたらキーボードが閉じる
    func setDissmissKeyboard() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc private func dissmissKeyboard() {
        self.view.endEditing(true)
    }
}
