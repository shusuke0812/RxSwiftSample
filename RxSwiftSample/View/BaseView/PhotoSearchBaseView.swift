//
//  PhotoSearchBaseView.swift
//  RxSwiftSample
//
//  Created by Shusuke Ota on 2021/1/16.
//

import UIKit

class PhotoSearchBaseView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }
}
// MARK: - Initialized Method
extension PhotoSearchBaseView {
    private func initUI() {
        
    }
}
