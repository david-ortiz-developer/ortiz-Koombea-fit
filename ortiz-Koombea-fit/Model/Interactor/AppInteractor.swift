//
//  AppInteractor.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import Foundation
import Alamofire
import CoreData
protocol AppInteractorProtocol {
    func fetchDataFromServer(output: @escaping (PhotosListModel?) -> Void)
    func retrievePicturesCache(predicate: NSPredicate?, output: @escaping (PhotosListModel) -> Void)
    func flushLocalData(entityName: String, output: @escaping (Bool) -> Void)
}
/// Class for interacting with the data
class AppInteractor: AppInteractorProtocol {

    init() {
    }
     func getDelergate() -> AppDelegate {
        if  let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate
        }
        return AppDelegate()
     }
    /// This method creates a Core Data  entity for each Datum object and then saves it on the context
    /// - Parameter data: Datum objects array decoded from de JSON
    func saveImagesData(data: [Datum]) {
        let managedContext = getDelergate().persistentContainer.viewContext
        for datum in data {
            let entity =
            NSEntityDescription.entity(forEntityName: "DatumCore",
                                       in: managedContext)!
            let pictureObject = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
            pictureObject.setValue(datum.uid, forKey: "uid")
            pictureObject.setValue(datum.name, forKey: "name")
            pictureObject.setValue(datum.email, forKey: "email")
            pictureObject.setValue(datum.profilePic, forKey: "profile_pic")
            pictureObject.setValue(datum.post?.id, forKey: "postId")
            pictureObject.setValue(datum.post?.date, forKey: "postDate")
            pictureObject.setValue(datum.post?.pics, forKey: "postPics")
            do {
                try managedContext.save()

            } catch let error as NSError {

                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    /// This method return a Datum objects array if there is one saved previously on Core Data
    /// - Parameters:
    ///   - predicate: can be nil, the predicate for querying the database
    ///   - output: escaped closure with the Async response
    func retrievePicturesCache(predicate: NSPredicate? = nil, output: @escaping (PhotosListModel) -> Void) {
        var picturesArray = [Datum]()
        let appDelegate = getDelergate()
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "DatumCore")
        if predicate != nil {
        fetchRequest.predicate = predicate
        }
        do {
            let ppoint = try managedContext.fetch(fetchRequest)
            for point in ppoint {
                print("point \(point)")
                if let mocapPoint = point as? DatumCore,
                   let pictures = mocapPoint.value(forKey: "postPics") as? [String],
                    let uid = mocapPoint.value(forKey: "uid") as? String,
                    let name = mocapPoint.value(forKey: "name")as? String,
                    let email = mocapPoint.value(forKey: "email")as? String,
                    let profilePic = mocapPoint.value(forKey: "profile_pic") as? String,
                    let postId = mocapPoint.value(forKey: "postId") as? Int,
                    let postDate = mocapPoint.value(forKey: "postDate") as? String {
                    let post = Post(id: postId, date: postDate, pics: pictures)
                    let datum = Datum(uid: uid, name: name, email: email, profilePic: profilePic, post: post)
                    picturesArray.append(datum)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        var model = PhotosListModel(data: picturesArray)
        output(model)
    }
    /// This method connects to the back end
    /// - Parameter output: escaped closure with the model object after codification
    func fetchDataFromServer(output: @escaping (PhotosListModel?) -> Void) {
        AF.request("https://mock.koombea.io/mt/api/posts").responseJSON { response
            in
            if let responseData = response.data {
            let str = String(decoding: responseData, as: UTF8.self)
                let jsonPayload = str.data(using: String.Encoding.utf8, allowLossyConversion: false)!
                let photosResultList = self.decodePhotosResult(jsonData: jsonPayload)
                if let picsData = photosResultList?.data {
                    self.saveImagesData(data: picsData)
                }
                output(photosResultList)
            }
        }
    }
    /// This method decodes the JSON to model object PhotosListModel
    /// - Parameter jsonData: the Json Data for encode
    /// - Returns: The model object
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
    func flushLocalData(entityName: String, output: @escaping (Bool) -> Void){
        let appDelegate = getDelergate()
        let container = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.execute(batchDeleteRequest)
            output(true)
        } catch {
            // Error Handling
            output(false)
        }
    }
}
