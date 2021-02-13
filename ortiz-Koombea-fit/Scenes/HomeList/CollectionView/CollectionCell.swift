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
    var index = -1
    var clickCallBack: ((Int) -> Void)?
    @IBAction func buttonAction(_ sender: Any) {
        if let touchAction = clickCallBack {
            touchAction(index)
        }
    }
}
