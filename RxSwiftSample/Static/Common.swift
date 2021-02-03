//
//  Common.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import Foundation

/// HTTPメソッド
enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}
/// ネットワークエラー
enum NetworkError: Error {
    case invalidUrl         // 不正なURL
    case invalidResponse    // 不正なレスポンス
    case unknown            // 想定外エラー
    func description() -> String {
        switch self {
        case .invalidUrl:       return "DEBUG： 不正なURLです"
        case .invalidResponse:  return "DEBUG： 不正なレスポンスです"
        case .unknown:          return "DEBUG： レスポンスに失敗しました"
        }
    }
}
