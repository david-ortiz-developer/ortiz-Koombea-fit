//
//  CollectionView.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 12/02/21.
//

import UIKit
import ImageLoader
extension HomeListViewController: UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosData?.data?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifierOnePicture,
            for: indexPath) as? PhotosCell
        if let list = photosData?.data {
            cell?.userName.text = list[indexPath.row].name
            cell?.userEmail.text = list[indexPath.row].email
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier:"en_US_POSIX")
            dateFormatter.dateFormat = "E MMM d yyyy hh:mm:ss 'GMT'ZZZZ (zzzz)"
            if let dateString = list[indexPath.row].post?.date {
                if let date = dateFormatter.date(from: dateString) {
                print(date)
                print(dateString)
                let formaterOrdinal = DateFormatter()
                formaterOrdinal.locale = Locale(identifier:"en_US_POSIX")
                formaterOrdinal.dateFormat = "MMM d"
                let dateInScreen = formaterOrdinal.string(from: date)
                let dayordinal = daySuffix(from: date)
                cell?.dateLabel.text = "\(dateInScreen)\(dayordinal)"
                }
            }
            cell?.userName.sizeToFit()
            if  let urlString = list[indexPath.row].profilePic {
                cell?.userPicture.layer.cornerRadius = 20.0
                if let imgURL = URL(string: urlString) {
                    cell?.userPicture.load.request(with: imgURL) {_, _, _ in
                    }
                }
            }
            let picturesNumber: Int = list[indexPath.row].post?.pics?.count ?? 0
            if let viewsInSubView = cell?.picturesStack.subviews {
            for view in viewsInSubView {
                cell?.picturesStack.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            }
            var initialIndex = 0
            if picturesNumber >= 2 {
                if picturesNumber > 2 {
                    cell?.showTinyGallerie()
                    cell?.showMainImage()
                    if  let urlString = list[indexPath.row].post?.pics?.first {
                        cell?.mainImage.layer.cornerRadius = 0.0
                        if let imgURL = URL(string: urlString) {
                            initialIndex = 1
                            cell?.mainImage.load.request(with: imgURL) {_, _, _ in
                                //cell?.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
                            }
                        }
                    }
                } else {
                    cell?.hideMainImage()
                    cell?.showTinyGallerie()
                }
                for indexPic in initialIndex..<picturesNumber {
                    let img1 = UIImageView()
                    if  let urlString = list[indexPath.row].post?.pics?[indexPic] {
                        img1.contentMode = .scaleAspectFit
                        img1.translatesAutoresizingMaskIntoConstraints = false
                        img1.addConstraint(NSLayoutConstraint(item: img1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 140))
                        img1.addConstraint(NSLayoutConstraint(item: img1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 140))
                        cell?.picturesStack.addArrangedSubview(img1)
                            if let imgURL = URL(string: urlString) {
                                img1.load.request(with: imgURL) {_, _, _ in
                                }
                            }
                    }
                    
                }
                
            }  else {
            if  let urlString = list[indexPath.row].post?.pics?.first {
                cell?.showMainImage()
                cell?.hideTinyGallerie()
                cell?.mainImage.layer.cornerRadius = 0.0
                if let imgURL = URL(string: urlString) {
                    cell?.mainImage.addConstraint(
                        NSLayoutConstraint(
                            item: cell?.mainImage,
                            attribute: .height,
                            relatedBy: .equal,
                            toItem: nil,
                            attribute: .notAnAttribute,
                            multiplier: 1, constant: 300))
                    cell?.mainImage.addConstraint(
                        NSLayoutConstraint(
                            item: cell?.mainImage,
                            attribute: .width,
                            relatedBy: .equal,
                            toItem: nil,
                            attribute: .notAnAttribute,
                            multiplier: 1,
                            constant: 300))
                    cell?.mainImage.load.request(with: imgURL) {_, _, _ in
                        //cell?.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
                    }
                }
            }
                 
        }
            
        }
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var picturesNumber = 0
        if let list = photosData?.data {
            picturesNumber = list[indexPath.row].post?.pics?.count ?? 0
        }
            
        var returnnedSize = CGSize(width: 300, height: 340)
        if picturesNumber == 2 {
            returnnedSize = CGSize(width: 300, height: 190)
        } else  if picturesNumber >= 3 {
            returnnedSize = CGSize(width: 300, height: 490)
        }
        return returnnedSize
    }
    func daySuffix(from date: Date) -> String {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: date)
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
}
