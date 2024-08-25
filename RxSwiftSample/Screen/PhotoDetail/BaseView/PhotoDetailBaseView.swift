//
//  PhotoDetailBaseView.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/3/8.
//

import UIKit
import SDWebImage

class PhotoDetailBaseView: UIView {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUI(photo: Photo) {
        guard let photoImageUrl = URL(string: photo.imageUrl) else { return }
        photoImageView.sd_setImage(with: photoImageUrl, placeholderImage: UIImage(named: "loading"), options: SDWebImageOptions.refreshCached)
        
        photoTitleLabel.text = photo.photoTitle
        photoDateLabel.text = photo.date
    }
}
