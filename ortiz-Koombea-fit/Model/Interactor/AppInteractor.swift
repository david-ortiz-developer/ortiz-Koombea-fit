//
//  AppInteractor.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import Foundation
protocol AppInteractorProtocol {
    func retrieveList(output: @escaping (Bool, [[String: Any?]]?) -> Void)
}
class AppInteractor: AppInteractorProtocol {
    var repository: Repository
    init(repository: Repository) {
        self.repository = repository
    }
    func retrieveList(output: @escaping (Bool, [[String: Any?]]?) -> Void) {
        output(false, nil)
    }
}
