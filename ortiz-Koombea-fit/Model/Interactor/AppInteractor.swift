//
//  AppInteractor.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import Foundation
import Alamofire
protocol AppInteractorProtocol {
    func fetchDataFromServer(output: @escaping (PhotosListModel?) -> Void)
}
class AppInteractor: AppInteractorProtocol {
    var repository: Repository
    init(repository: Repository) {
        self.repository = repository
    }

    func fetchDataFromServer(output: @escaping (PhotosListModel?) -> Void) {
        AF.request("https://mock.koombea.io/mt/api/posts").responseJSON{ response
            in
            if let responseData = response.data {
            let str = String(decoding: responseData, as: UTF8.self)
                let jsonPayload = str.data(using: String.Encoding.utf8, allowLossyConversion: false)!
                let photosResultList = self.decodePhotosResult(jsonData: jsonPayload)
                output(photosResultList)
            }
        }
    }
    func decodePhotosResult(jsonData: Data) -> PhotosListModel? {
        var searchResult: PhotosListModel
        do {
            searchResult = try JSONDecoder().decode(PhotosListModel.self, from: jsonData)
            return searchResult
        } catch {
            print(error)
            return nil
        }
    }
}
