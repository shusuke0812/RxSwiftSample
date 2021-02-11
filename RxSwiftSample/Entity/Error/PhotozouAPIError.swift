//
//  GitHubAPIError.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/11.
//

// フォト蔵API エラーレスポンス ドキュメント：http://photozou.jp/basic/api

import Foundation

struct PhotozouAPIError: Codable, Error {
    let status: String
    let errors: [Error]
    
    enum CodingKeys: String, CodingKey {
        case status = "stat"
        case errors = "err"
    }
    
    struct Error: Codable {
        let code: String
        let message: String
        
        enum CodingKeys: String, CodingKey {
            case code
            case message = "msg"
        }
    }
}
