//
//  NumberFormHelper.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import Foundation

class NumberFormHelper {
    /// シングルトン
    static let shared = NumberFormHelper()
    /// 偶数・奇数を判定する
    /// - Parameter numer: 判定する整数
    /// - Returns: 偶数（true）、奇数（false）
    internal func judgeEvenOrOdd(number: Int) -> Bool {
        if number % 2 == 0 {
            return true
        } else {
            return false
        }
    }
    /// `3n - 2`で表される順列に含まれる整数かどうかを判定する
    /// - Parameter number: 判定する整数
    internal func judgePermutation(number: Int) -> Bool {
        let judgeNumber = (number + 2) % 3
        if judgeNumber == 0 {
            return true
        } else {
            return false
        }
    }
}
