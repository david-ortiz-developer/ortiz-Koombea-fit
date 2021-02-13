//
//  HomeListViewController.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import UIKit
class HomeListViewController: UIViewController {
    var presenter: HomeListPresenter?
    let reuseIdentifierOnePicture = "photos_cell"
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var photosData: PhotosListModel? {
        didSet {
            self.reload()
        }
    }
    override func viewDidLoad() {
        self.presenter?.viewDidUpdate(status: .didLoad)
    }
}
