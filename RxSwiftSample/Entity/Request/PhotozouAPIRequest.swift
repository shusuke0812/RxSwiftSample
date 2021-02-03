//
//  PhotozouAPIRequest.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

// フォト蔵API ドキュメント（search_public） : http://photozou.jp/basic/api_method_search_public

import Foundation

protocol PhotozouAPIRequest {
    associatedtype Response: Decodable
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [URLQueryItem]? { get }
    var body: Encodable? { get }
}
// MARK: - Custom Setting
extension PhotozouAPIRequest {
    /// APIプレフィックス
    var baseURL: String {
        "https://api.photozou.jp/rest"
    }
    /// APIコール用のリクエスト生成
    func buildURLRequest() -> URLRequest {
        // baseURL, pathは格api型で正しく定義されているという前提で強制アンラップ
        let url = URL(string: self.baseURL.appending(self.path))!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        switch self.method {
        case .get:
            components?.queryItems = self.parameters
        default:
            fatalError("Unsupported method \(self.method)")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = self.method.rawValue
        
        return urlRequest
    }
}
