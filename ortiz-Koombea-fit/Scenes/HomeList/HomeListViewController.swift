//
//  HomeListViewController.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import UIKit
import Alamofire
class HomeListViewController: UIViewController {
    var presenter: HomeListPresenter?
    override func viewDidLoad() {
        self.presenter?.viewDidUpdate(status: .didLoad)
        self.fetchDataFromServer()
    }
    func fetchDataFromServer() {
        AF.request("https://mock.koombea.io/mt/api/posts").responseJSON{ response
            in
            //print(response.request)
            //print(response.result)
            if let responseData = response.data {
            let str = String(decoding: responseData, as: UTF8.self)
                let jsonPayload = str.data(using: String.Encoding.utf8, allowLossyConversion: false)!
                //print("result: \(str)")
                let photosResultList = self.decodePhotosResult(jsonData: jsonPayload)
                DispatchQueue.main.async {
                    print(photosResultList)
                   // output(.success, searchResultList)
                }
            }
            //print(response.response)
            
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
