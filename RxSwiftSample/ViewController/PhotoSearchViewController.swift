//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/1/3.
//

import UIKit

class PhotoSearchViewController: UIViewController {
    /// BaseView
    private var baseView: PhotoSearchBaseView { self.view as! PhotoSearchBaseView }
    /// ViewModel
    private var viewModel: PhotoSearchViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = PhotoSearchViewModel()
        self.setDelegateDataSource()
    }
}
// MARK: - Initialized Method
extension PhotoSearchViewController {
    private func setDelegateDataSource() {
        self.baseView.collectionView.delegate = self
        self.baseView.collectionView.dataSource = self.viewModel
    }
}
// MARK: - UICollectionView Delegate Method
extension PhotoSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
// MARK: - UICollectionView Delegate FlowLayout Method
extension PhotoSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // CollectionViewのindexによってサイズを設定する
        return CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
    }
}
