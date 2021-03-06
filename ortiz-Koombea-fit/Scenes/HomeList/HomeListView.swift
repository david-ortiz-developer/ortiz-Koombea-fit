//
//  HomeListView.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import UIKit
/// View Protocol Implementation for UI tasks
protocol HomeListView: ViewProtocol {
    func setupUI()
    func reload()
    func nextpage()
    func noResults()
    var photosData: PhotosListModel? {get set}
    func showErrorView()
    var collectionView: UICollectionView! { get }
}
extension HomeListViewController: HomeListView {
    func showErrorView() {
        self.errorView.isHidden = false
    }
    /// Reloads the UI after data fetched or changed
    func reload() {
        print("reloading")
        self.collectionView.reloadData()
    }
    /// Tjhis method is called after the scrolling reach the end of the page
    func nextpage() {
    }
    /// This is the initial window
    func noResults() {
    }
    func setupUI() {
        showLoadingScene()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Loading Data")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
        presenter?.reloadAfterPull {[self] _ in
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detail = segue.destination as? DetailView {
            detail.detailURL = touchedImageURL
        }
    }
}
