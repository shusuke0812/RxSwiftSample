//
//  RepositoryAssembly.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2024/8/25.
//

import Swinject

class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PhotoSearchRepositoryProtocol.self) { _ in
            PhotoSearchRepository()
        }
        .inObjectScope(.container) // Singleton
    }
}

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PhotoSearchViewModel.self) { resolver in
            let repository = resolver.resolve(PhotoSearchRepository.self)!
            return PhotoSearchViewModel(photoSearchRepository: repository)
        }
    }
}
