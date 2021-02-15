//
//  Connectivity.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 14/02/21.
//

import Foundation
import Alamofire
class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
