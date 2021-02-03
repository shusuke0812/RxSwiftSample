//
//  PhotoSearchViewModel.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import UIKit

class PhotoSearchViewModel: NSObject {
    /// 画像データ
    var photos: [Photo] = []
    /// CollectionViewのセクション数
    private let sectionNumber = 1
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
        return cell
    }
}
