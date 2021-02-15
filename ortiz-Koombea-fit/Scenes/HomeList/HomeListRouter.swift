//
//  HomeListRouter.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import Foundation
protocol HomeListRouter {
    func showLoadingScene()
    func dismissLoadingScene()
    func navigateToDetailScene(url: URL)
    func navigateToErrorScene(error: NSError)
    func showPictureDetail(url: URL)
}
extension HomeListViewController: HomeListRouter {
    func showLoadingScene() {
        AppRouter.presentLoadingScene(view: self.view)
    }
    func dismissLoadingScene() {
        AppRouter.hideLoadingScene()
    }
    func navigateToDetailScene(url: URL) {
    }
    func navigateToErrorScene(error: NSError) {
    }
    /// This method opens the detail view for the picture
    /// - Parameter url: the url of the image
    func showPictureDetail(url: URL) {
        touchedImageURL = url
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
}
