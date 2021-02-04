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
    /// 整数フォーム判定ヘルパー
    private let numberFormHelper = NumberFormHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = PhotoSearchViewModel(photoSearchRepository: PhotoSearchRepository())
        self.setDelegateDataSource()
    }
}
// MARK: - Initialized Method
extension PhotoSearchViewController {
    private func setDelegateDataSource() {
        self.baseView.collectionView.delegate = self
        self.baseView.collectionView.dataSource = self.viewModel
        self.baseView.searchBar.delegate = self
        self.viewModel.delegate = self
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
        if numberFormHelper.judgePermutation(number: indexPath.item + 1) {
            let cellWidth: CGFloat = self.baseView.bounds.width
            let cellHeight: CGFloat = cellWidth / 2
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            let cellWidth: CGFloat = self.baseView.bounds.width / 2
            let cellHeight: CGFloat = cellWidth
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
}
// MARK: - UISearchBar Delegate Method
extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText: String = searchBar.text else { return }
        let request = SearchPhotoRequest(keyword: searchText).buildURLRequest()
        self.viewModel.getPhotos(request: request)
    }
}
// MARK: - ViewModel Delegate Method
extension PhotoSearchViewController: PhotoSearchViewModelDelegate {
    func didSuccessGetPhotos() {
        self.baseView.collectionView.reloadData()
    }
    func didFailedGetPhotos(errorMessage: String) {
        print(errorMessage)
    }
}
