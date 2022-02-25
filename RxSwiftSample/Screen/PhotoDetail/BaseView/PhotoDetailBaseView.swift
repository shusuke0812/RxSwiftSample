//
//  PhotoDetailBaseView.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/3/8.
//

import UIKit

class PhotoDetailBaseView: UIView {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
