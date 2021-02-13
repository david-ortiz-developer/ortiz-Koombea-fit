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
    func navigateToDetailScene(id productId: String)
    func navigateToErrorScene(error: NSError)
}
extension HomeListViewController: HomeListRouter {
    func showLoadingScene() {
        AppRouter.presentLoadingScene(view: self.view)
    }
    func dismissLoadingScene() {
    }
    func navigateToDetailScene(id productId: String) {
    }
    func navigateToErrorScene(error: NSError) {
    }
}
