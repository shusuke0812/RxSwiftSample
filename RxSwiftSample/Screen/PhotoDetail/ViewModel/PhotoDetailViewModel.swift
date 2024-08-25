//
//  PhotoDetailViewModel.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2024/8/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol PhotoDetailViewModelOutputs {
    var selectedPhoto: BehaviorRelay<Photo?> { get }
}

protocol PhotoDetailViewModelType {
    var outputs: PhotoDetailViewModelOutputs { get }
}

class PhotoDetailViewModel: PhotoDetailViewModelType, PhotoDetailViewModelOutputs {
    private let photoSearchRepository: PhotoSearchRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    var outputs: PhotoDetailViewModelOutputs { return self }
    
    var selectedPhoto = BehaviorRelay<Photo?>(value: nil)
    
    init(photoSearchRepository: PhotoSearchRepositoryProtocol) {
        self.photoSearchRepository = photoSearchRepository
        
        photoSearchRepository.getSelectedPhoto()
            .bind(to: selectedPhoto)
            .disposed(by: disposeBag)
    }
}
