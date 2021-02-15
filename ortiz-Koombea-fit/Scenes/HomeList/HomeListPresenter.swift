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
            self.retrieveImages {_ in}
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
    func retrieveImages(output: @escaping(Bool) -> Void) {
        if Connectivity.isConnectedToInternet() {
            self.loadImagesFromServer()
            output(false)
        } else {
            interactor.retrievePicturesCache(predicate: nil) { photosInfo in
                self.view.photosData = photosInfo
                self.hideLoadingOverlay()
                output(true)
            }
        }
    }
    func showLoadingOverlay() {
        self.router.showLoadingScene()
    }
    func hideLoadingOverlay() {
        self.router.dismissLoadingScene()
    }
    /// This method loads the images form server,
    /// if there is a problem the method will return
    /// the data saved in the device
    func loadImagesFromServer() {
        interactor.fetchDataFromServer { photosList in
            DispatchQueue.main.async {
                self.hideLoadingOverlay()
            }
            if let photosInfo = photosList {
                self.view.photosData = photosInfo
            } else {
                DispatchQueue.main.async {
                    self.view.showErrorView()
                }
            }
        }
    }
    func reloadAfterPull(output: @escaping (Bool) -> Void) {
        interactor.flushLocalData(entityName: "DatumCore") {result in
            self.view.photosData = nil
            self.retrieveImages {result in
                output(result)
            }
        }
    }
    func showDetailView(url: URL) {
        router.showPictureDetail(url: url)
    }
}
