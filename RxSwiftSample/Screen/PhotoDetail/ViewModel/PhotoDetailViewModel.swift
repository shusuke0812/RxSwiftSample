//
//  PhotoDetailViewModel.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2024/8/25.
//

import Foundation

class PhotoDetailViewModel {
    private let photoSearchRepository: PhotoSearchRepositoryProtocol
    
    init(photoSearchRepository: PhotoSearchRepositoryProtocol) {
        self.photoSearchRepository = photoSearchRepository
        
        let photo = photoSearchRepository.getSelectedPhoto()
        print("DEBUG: selected photo=\(photo)")
    }
}
