//
//  Photo.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import UIKit

struct SearchPhoto: Codable {
    let status: String
    let info: Info
    
    enum CodingKeys: String, CodingKey {
        case status = "stat"
        case info
    }
}

struct Info: Codable {
    let photo: [Photo]
}

struct Photo: Codable {
    /// 画像タイトル
    let photoTitle: String
    /// 日付
    let date: String
    /// 画像URL
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case photoTitle = "photo_title"
        case date
        case imageUrl   = "image_url"
    }
}
