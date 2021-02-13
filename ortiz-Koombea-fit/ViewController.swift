//
//  ViewController.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loadingSpinnerView: UIView?
    var thinking: Bool = false {
        didSet {
            showHideLoadingView(showing: thinking)
        }
    }
    func showHideLoadingView(showing: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
