//
//  CollectionCell.swift
//  Tribal-Fit-Ortiz
//
//  Created by edgar david ortiz diaz on 26/01/21.
//

import UIKit
class PhotosCell: UICollectionViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var picturesStack: UIStackView!
    @IBOutlet weak var mainImageHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainImageButton: GalleryItemButton!
    var index = -1
    var clickCallBack: ((URL) -> Void)?
    @IBOutlet weak var tinyGelleryHeigth: NSLayoutConstraint!

    func hideMainImage() {
        self.mainImageHeight.constant = 0
    }
    func showMainImage() {
        self.mainImageHeight.constant = 300
    }
    func hideTinyGallerie() {
        self.tinyGelleryHeigth.constant = 0
    }
    func showTinyGallerie() {
        self.tinyGelleryHeigth.constant = 154
    }
    override func prepareForReuse() {
        self.scrollView.contentSize = CGSize.zero
        self.picturesStack.frame = CGRect.zero
            for view in self.picturesStack.subviews {
                self.picturesStack.removeArrangedSubview(view)
                view.removeFromSuperview()
        }
    }
}
