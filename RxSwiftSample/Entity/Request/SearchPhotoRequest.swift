//
//  SearchPhotoRequest.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import Foundation

struct SearchPhotoRequest: PhotozouAPIRequest {
    /// 検索ワード
    let keyword: String
    
    /// PhotozouAPIRequestが要求する連想型
    typealias Response = SearchPhoto
    
    var method: HTTPMethod {
        .get
    }
    var path: String {
        "/search_public.json"
    }
    var parameters: [URLQueryItem]? {
        [ URLQueryItem(name: "keyword", value: self.keyword) ]
    }
    var header: [String: String]? {
        nil
    }
    var body: Data? {
        nil
    }
}
