//
//  HomeListPresenter.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import UIKit
class HomeListPresenter: Presenter {
    fileprivate var interactor: AppInteractorProtocol
    fileprivate var view: HomeListView
    fileprivate var router: HomeListRouter
    init(interactor: AppInteractorProtocol, router: HomeListRouter, view: HomeListView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    func viewDidUpdate(status: ViewStatus) {
        switch status {
        case .didLoad:
            self.view.setupUI()
        case .willAppear:
            break
        case .didAppear:
            break
        case .willDisappear:
            break
        case .didDisappear:
            break
        }
    }
    func showLoadingOverlay() {
        self.router.showLoadingScene()
    }
}
