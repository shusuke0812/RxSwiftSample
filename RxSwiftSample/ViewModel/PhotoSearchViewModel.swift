//
//  PhotoSearchViewModel.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import UIKit
import RxSwift
import RxCocoa

/// 入力を管理するプロトコル
protocol PhotoSearchViewModelInputs {
    /// 検索ワード
    var searchWord: BehaviorRelay<String> { get }
}
/// 出力を管理するプロトコル
protocol PhotoSearchViewModelOutputs {
    /// 検索した写真情報
    var photos: BehaviorRelay<[Photo]> { get }
}
/// 入出力を管理するプロトコル
protocol PhotoSearchViewModelType {
    var inputs: PhotoSearchViewModelInputs { get }
    var outputs: PhotoSearchViewModelOutputs { get }
}
class PhotoSearchViewModel: PhotoSearchViewModelType, PhotoSearchViewModelInputs, PhotoSearchViewModelOutputs {
    /// 写真検索リポジトリ
    private let photoSearchRepository: PhotoSearchRepositoryProtocol
    /// DispoaseBag（購読廃棄）
    private let disposeBag = DisposeBag()
    /// CollectionViewのセクション数
    private let sectionNumber = 1
   
    // 入出力プロパティ
    var inputs: PhotoSearchViewModelInputs { return self }
    var outputs: PhotoSearchViewModelOutputs { return self }
    // 入力
    let searchWord = BehaviorRelay<String>(value: "")
    // 出力
    var photos = BehaviorRelay<[Photo]>(value: [])
    
    init(photoSearchRepository: PhotoSearchRepositoryProtocol) {
        self.photoSearchRepository = photoSearchRepository
        
        self.searchWord.asObservable()
            .filter { $0.count > 0 }
            .debounce(RxTimeInterval.milliseconds(1), scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] searchWord in
                return self.photoSearchRepository.getPhotos(searchWord: searchWord)
            }
            .bind(to: self.photos)
            .disposed(by: self.disposeBag)
    }
}
