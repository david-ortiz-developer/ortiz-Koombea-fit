//
//  DetailView.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 14/02/21.
//

import UIKit
import ImageLoader
class DetailView: UIViewController {
    @IBOutlet var detailImageView: UIImageView?
    var detailURL: URL?
    override func viewDidLoad() {
        if let url = detailURL {
            detailImageView?.load.request(with: url)
        }
    }
}
