//
//  HomeList.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import UIKit
class HomeListConfigurator: Configurator {
    static let shared = HomeListConfigurator()
    fileprivate struct Constants {
        static let storyboardName: String = "HomeListStoryboard"
        static let storyboardId: String = "HomeScene"
    }
    func prepareScene(viewController: UIViewController) {
        if let listViewController = viewController as? HomeListViewController,
           let listRouter = viewController as? HomeListRouter,
           let listView = viewController as? HomeListView {
            let presenter = HomeListPresenter(
                interactor: AppInteractor(repository: Repository()),
                router: listRouter,
                view: listView)
            listViewController.presenter = presenter
        }
    }
    func storyboardName() -> String {
        return Constants.storyboardName
    }
    func storyboardId() -> String {
        return Constants.storyboardId
    }    
    func isValid(viewController: UIViewController) -> Bool {
        return viewController is HomeListViewController
    }
}
