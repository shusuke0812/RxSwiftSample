//
//  PhotoDetailViewController.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/3/8.
//

import UIKit
import RxSwift

class PhotoDetailViewController: UIViewController {
    private var baseView: PhotoDetailBaseView { view as! PhotoDetailBaseView }
    var viewModel: PhotoDetailViewModel!
    
    private let disposeBag = RxSwift.DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.selectedPhoto
            .subscribe(onNext: { [weak self] selectedPhoto in
                guard let photo = selectedPhoto else {
                    return
                }
                self?.baseView.setUI(photo: photo)
            })
            .disposed(by: disposeBag)
    }
}
