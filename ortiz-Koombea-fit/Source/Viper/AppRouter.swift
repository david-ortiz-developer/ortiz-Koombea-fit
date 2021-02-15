//
//  AppRouter.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import UIKit
class AppRouter {
    class func presentLoadingScene(view: UIView) {
           LoadingOverlay.shared.showOverlay(view: view)
       }
    class func hideLoadingScene() {
        LoadingOverlay.shared.hideOverlayView()
    }
}
