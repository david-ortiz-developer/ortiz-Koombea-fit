//
//  CollectionCell.swift
//  Tribal-Fit-Ortiz
//
//  Created by edgar david ortiz diaz on 26/01/21.
//

import UIKit
class PhotosCell: UICollectionViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var removeFavoriteButton: UIButton!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var picturesStack: UIStackView!
    @IBOutlet weak var mainImageHeight: NSLayoutConstraint!
    var index = -1
    var clickCallBack: ((Int) -> Void)?
    @IBOutlet weak var tinyGelleryHeigth: NSLayoutConstraint!
    @IBAction func buttonAction(_ sender: Any) {
        if let touchAction = clickCallBack {
            touchAction(index)
        }
    }
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
}
