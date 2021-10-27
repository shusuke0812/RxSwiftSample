//
//  PhotoSearchBaseView.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/1/16.
//

import UIKit

class PhotoSearchBaseView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: - Lifecycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
}
// MARK: - Initialized Method
extension PhotoSearchBaseView {
    private func initUI() {
        flowLayout.estimatedItemSize = .zero
        collectionView.register(UINib(nibName: "PhotoSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoSearchCollectionViewCell")
    }
}
