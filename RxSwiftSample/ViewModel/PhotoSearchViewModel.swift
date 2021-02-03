//
//  PhotoSearchViewModel.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import UIKit

protocol PhotoSearchViewModelDelegate: AnyObject {
    /// 画像の取得に成功した
    func didSuccessGetPhotos()
    /// 画像の取得に失敗した
    /// - Parameter errorMessage: エラーメッセージ
    func didFailedGetPhotos(errorMessage: String)
}

class PhotoSearchViewModel: NSObject {
    /// SearchPhotoのリポジトリクラス
    private let photoSearchRepository: PhotoSearchRepositoryProtocol
    /// 画像データ
    var photos: [Photo] = []
    /// デリゲート
    weak var delegate: PhotoSearchViewModelDelegate?
    /// CollectionViewのセクション数
    private let sectionNumber = 1
    
    init(photoSearchRepository: PhotoSearchRepositoryProtocol) {
        self.photoSearchRepository = photoSearchRepository
    }
}
// MARK: - API Method
extension PhotoSearchViewModel {
    func getPhotos(request: URLRequest) {
        self.photoSearchRepository.getPhotos(request: request) { response in
            switch response {
            case .success(let photos):
                self.photos = photos.info.photo
                self.delegate?.didSuccessGetPhotos()
            case .failure(let error):
                self.delegate?.didFailedGetPhotos(errorMessage: "画像の取得に失敗しました" + "error=\(error.localizedDescription)")
            }
        }
    }
}
// MARK: - UICollectionView DataSource Method
extension PhotoSearchViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.sectionNumber
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoSearchCollectionViewCell", for: indexPath) as! PhotoSearchCollectionViewCell
        cell.setUI(photo: self.photos[indexPath.row])
        return cell
    }
}
