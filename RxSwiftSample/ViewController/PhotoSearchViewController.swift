//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/1/3.
//

import UIKit
import RxSwift

class PhotoSearchViewController: UIViewController {
    /// BaseView
    private var baseView: PhotoSearchBaseView { self.view as! PhotoSearchBaseView }
    /// ViewModel
    private var viewModel: PhotoSearchViewModel!
    /// 整数フォーム判定ヘルパー
    private let numberFormHelper = NumberFormHelper()
    /// DispoaseBag（購読廃棄）
    private let disposeBag = RxSwift.DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDissmissKeyboard()
        self.viewModel = PhotoSearchViewModel(photoSearchRepository: PhotoSearchRepository())
        self.setDelegateDataSource()
        self.loadPhoto()
        self.setCollectionView()
    }
}
// MARK: - Private Method
extension PhotoSearchViewController {
    private func loadPhoto() {
        self.baseView.searchBar.rx.text.orEmpty
            .bind(to: self.viewModel.inputs.searchWord)
            .disposed(by: disposeBag)
    }
    private func setCollectionView() {
        self.viewModel.outputs.photos.asObservable()
            .bind(to: self.baseView.collectionView.rx.items(cellIdentifier: "PhotoSearchCollectionViewCell", cellType: PhotoSearchCollectionViewCell.self)) { index, result, cell in
                cell.setUI(photo: result)
            }
            .disposed(by: self.disposeBag)
    }
}
// MARK: - Initialized Method
extension PhotoSearchViewController {
    private func setDelegateDataSource() {
        self.baseView.collectionView.delegate = self
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
