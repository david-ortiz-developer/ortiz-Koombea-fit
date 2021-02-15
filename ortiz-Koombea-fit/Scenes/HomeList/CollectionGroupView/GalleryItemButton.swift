//
//  GalleryItemButton.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 15/02/21.
//

import UIKit
class GalleryItemButton: UIButton {
    var picURL: URL?
    var customObject2: Any?
    convenience init(name: String, object: URL) {
        self.init()
        self.picURL = object
    }
}
