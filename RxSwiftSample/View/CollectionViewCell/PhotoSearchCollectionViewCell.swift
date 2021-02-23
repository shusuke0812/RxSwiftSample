//
//  PhotoSearchCollectionViewCell.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/2/3.
//

import UIKit
import SDWebImage

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
// MARK: - Setting UI Method
extension PhotoSearchCollectionViewCell {
    func setUI(photo: Photo) {
        guard let photoImageUrl = URL(string: photo.imageUrl) else { return }
        self.imageView.sd_setImage(with: photoImageUrl, placeholderImage: UIImage(named: "loading"), options: SDWebImageOptions.refreshCached)
    }
}
