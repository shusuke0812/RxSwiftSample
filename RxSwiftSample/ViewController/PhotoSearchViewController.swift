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
        // MARK: - 初期設定
        // キーボード以外をタップしたらキーボードを閉じる
        self.setDissmissKeyboard()
        // ViewModel初期化
        self.viewModel = PhotoSearchViewModel(photoSearchRepository: PhotoSearchRepository())
        // デリゲート・データソース設定
        self.baseView.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // MARK: - ViewModelへのInput
        // キーワードを入力した時の処理
        self.baseView.searchBar.rx.text.orEmpty
            .bind(to: self.viewModel.inputs.searchWord)
            .disposed(by: disposeBag)
        
        // MARK: - ViewModelからのOutput
        // ViewModelで保持している写真情報をCollectionViewに反映する
        self.viewModel.outputs.photos.asObservable()
            .bind(to: self.baseView.collectionView.rx.items(cellIdentifier: "PhotoSearchCollectionViewCell", cellType: PhotoSearchCollectionViewCell.self)) { index, result, cell in
                cell.setUI(photo: result)
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Private Method
extension PhotoSearchViewController {
    private func setCellSize(cellWidth: CGFloat, cellHegiht: CGFloat) -> CGSize {
        return CGSize(width: cellWidth, height: cellHegiht)
    }
}
// MARK: - UICollectionView Delegate FlowLayout Method
extension PhotoSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if numberFormHelper.judgePermutation(number: indexPath.item + 1) {
            return self.setCellSize(cellWidth: self.baseView.bounds.width, cellHegiht: self.baseView.bounds.width / 2)
        } else {
            return self.setCellSize(cellWidth: self.baseView.bounds.width / 2, cellHegiht: self.baseView.bounds.width / 2)
        }
    }
}
