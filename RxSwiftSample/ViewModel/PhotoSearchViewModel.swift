//
//  PhotoSearchViewModel.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoSearchViewModel {
    /// 写真検索リポジトリ
    private let photoSearchRepository: PhotoSearchRepositoryProtocol
    /// DispoaseBag（購読廃棄）
    private let disposeBag = DisposeBag()
    /// 検索ワード
    var searchWord = BehaviorRelay<String>(value: "")
    /// 検索した写真情報
    var photos = BehaviorRelay<[Photo]>(value: [])
    /// CollectionViewのセクション数
    private let sectionNumber = 1
    
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
