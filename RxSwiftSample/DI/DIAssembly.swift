//
//  RepositoryAssembly.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2024/8/25.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
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
                let repository = resolver.resolve(PhotoSearchRepositoryProtocol.self)!
                return PhotoSearchViewModel(photoSearchRepository: repository)
            }
            container.register(PhotoDetailViewModel.self) { resolver in
                let repository = resolver.resolve(PhotoSearchRepositoryProtocol.self)!
                return PhotoDetailViewModel(photoSearchRepository: repository)
            }
        }
    }
    
    class ViewControllerAssembly: Assembly {
        func assemble(container: Container) {
            container.storyboardInitCompleted(PhotoSearchViewController.self) { resolver, vc in
                vc.viewModel = resolver.resolve(PhotoSearchViewModel.self)!
            }
            container.storyboardInitCompleted(PhotoDetailViewController.self) { resolver, vc in
                vc.viewModel = resolver.resolve(PhotoDetailViewModel.self)!
            }
        }
    }
    
    class func setup() {
        let assembler = Assembler(container: SwinjectStoryboard.defaultContainer)
        assembler.apply(assemblies: [
            RepositoryAssembly(),
            ViewModelAssembly(),
            ViewControllerAssembly()
        ])
    }
}
