//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/1/3.
//

/**
 * ViewControllerの役割
 * - ViewModelから受け取った通知をBaseViewに反映
 * - ユーザーインタラクションをViewModelへ通知する
 */

import UIKit
import RxSwift

class PhotoSearchViewController: UIViewController {
    private var baseView: PhotoSearchBaseView { view as! PhotoSearchBaseView }
    private var viewModel: PhotoSearchViewModel!

    private let disposeBag = RxSwift.DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - 初期設定
        // ViewModel初期化
        viewModel = PhotoSearchViewModel(photoSearchRepository: PhotoSearchRepository())
        // Delegate・DataSource設定
        baseView.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        baseView.searchBar.rx.setDelegate(self).disposed(by: disposeBag)
        // キーボード以外をタップしたらキーボードを閉じる
        setDissmissKeyboard()
        
        // MARK: - ViewModelへのInput
        // キーワードを入力した時の処理
        baseView.searchBar.rx.text.orEmpty
            .bind(to: viewModel.inputs.searchWord)
            .disposed(by: disposeBag)
        
        // MARK: - ViewModelからのOutput
        // ViewModelで保持している写真情報をCollectionViewに反映する
        viewModel.outputs.photos.asObservable()
            .bind(to: baseView.collectionView.rx.items(cellIdentifier: "PhotoSearchCollectionViewCell", cellType: PhotoSearchCollectionViewCell.self)) { index, result, cell in
                cell.setUI(photo: result)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Private Method
extension PhotoSearchViewController {
    private func setCellSize(cellWidth: CGFloat, cellHegiht: CGFloat) -> CGSize {
        return CGSize(width: cellWidth, height: cellHegiht)
    }
}
// MARK: - UISearch Delegate Method
extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        baseView.searchBar.endEditing(true)
    }
}
// MARK: - UICollectionView Delegate FlowLayout Method
extension PhotoSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if NumberFormHelper.judgePermutation(number: indexPath.item + 1) {
            return setCellSize(cellWidth: baseView.bounds.width, cellHegiht: baseView.bounds.width / 2)
        } else {
            return setCellSize(cellWidth: baseView.bounds.width / 2, cellHegiht: baseView.bounds.width / 2)
        }
    }
}
