//
//  PhotoSearchCollectionViewCell.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import UIKit

class PhotoSearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }
}
// MARK: - Initialized Method
extension PhotoSearchCollectionViewCell {
    private func initUI() {
        self.imageView.image = UIImage(named: "loading")
    }
}
