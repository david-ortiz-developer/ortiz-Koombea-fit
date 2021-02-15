//
//  LoadingOverlay.swift
//  iwant
//
//  Created by edgar david ortiz diaz on 20/06/20.
//  Copyright © 2020 edgar david ortiz diaz. All rights reserved.
//

import UIKit
public class LoadingOverlay {

var overlayView = UIView()
var activityIndicator = UIActivityIndicatorView()

class var shared: LoadingOverlay {
    struct Static {
        static let instance: LoadingOverlay = LoadingOverlay()
    }
    return Static.instance
}

    public func showOverlay(view: UIView) {
        overlayView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor.yellow.withAlphaComponent(0.7)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .large
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)

        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)

        activityIndicator.startAnimating()
    }

    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
