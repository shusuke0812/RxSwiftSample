//
//  PhotoSearchRepository.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import Foundation
import RxSwift

protocol PhotoSearchRepositoryObservable {
    /// 画像を取得する
    /// - Parameters:
    ///   - searchWord: 検索ワード
    ///   - completion: 成功、失敗ハンドル
    func getPhotos(searchWord: String) -> Observable<SearchPhoto>
}
class PhotoSearchRepository: PhotoSearchRepositoryObservable {
}
// MARK: - API Method
extension PhotoSearchRepository {
    func getPhotos(searchWord: String) -> Observable<SearchPhoto> {
        // リクエストの組み立て
        let request = SearchPhotoRequest(keyword: searchWord).buildURLRequest()
        // APIコール
        return Observable<SearchPhoto>.create { observer in
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.on(.error(APIClientError.connectionError(error)))
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    observer.on(.error(APIClientError.unknown))
                    return
                }
                let decoder = JSONDecoder()
                if (200..<300).contains(response.statusCode) {
                    do {
                        let photo = try decoder.decode(SearchPhoto.self, from: data)
                        observer.on(.next(photo))
                        observer.on(.completed) // ??
                    } catch {
                        observer.on(.error(APIClientError.resonseParseError(error)))
                    }
                } else {
                    do {
                        let apiError = try decoder.decode(PhotozouAPIError.self, from: data)
                        observer.on(.error(APIClientError.apiError(apiError)))
                    } catch {
                        observer.on(.error(APIClientError.resonseParseError(error)))
                    }
                }
            }
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
}
