//
//  PhotoSearchRepository.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import Foundation

protocol PhotoSearchRepositoryProtocol {
    /// 画像を取得する
    /// - Parameters:
    ///   - request: APIのリクエスト
    func getPhotos(request: URLRequest, completion: @escaping (Result<SearchPhoto, Error>) -> Void)
}
class PhotoSearchRepository: PhotoSearchRepositoryProtocol {
}
// MARK: - API Method
extension PhotoSearchRepository {
    // 画像を取得する
    func getPhotos(request: URLRequest, completion: @escaping (Result<SearchPhoto, Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            let decoder = JSONDecoder()
            do {
                let photo = try decoder.decode(SearchPhoto.self, from: data)
                completion(.success(photo))
            } catch {
                completion(.failure(NetworkError.invalidResponse))
            }
        }
        task.resume()
    }
}
