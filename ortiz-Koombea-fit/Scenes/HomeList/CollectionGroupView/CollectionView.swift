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
        if let list = photosData?.data,
           let cellView = cell {
            setAuthorData(cell: cellView, list: list, indexPath: indexPath)
            let picturesNumber: Int = list[indexPath.row].post?.pics?.count ?? 0           
            var initialIndex = 0
            if picturesNumber >= 2 {
                if picturesNumber > 2 {
                    cell?.showMainImage()
                    cell?.showTinyGallerie()
                    if  let urlString = list[indexPath.row].post?.pics?[0] {
                        cell?.mainImage.layer.cornerRadius = 0.0
                        if let imgURL = URL(string: urlString) {
                            initialIndex = 1
                            cell?.mainImage.load.request(with: imgURL) {_, error, _ in
                                if error != nil {
                                    print("error \(error)")
                                }
                            }
                        }
                    }
                } else {
                    cell?.hideMainImage()
                    cell?.showTinyGallerie()
                }
                var contentWidth = 0
                for indexPic in initialIndex..<picturesNumber {
                    let img1 = UIImageView()
                    if  let urlString = list[indexPath.row].post?.pics?[indexPic] {
                        img1.contentMode = .scaleAspectFit
                        img1.translatesAutoresizingMaskIntoConstraints = false
                        img1.addConstraint(NSLayoutConstraint(item: img1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 140))
                        img1.addConstraint(NSLayoutConstraint(item: img1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 140))
                        cell?.picturesStack.addArrangedSubview(img1)
                        if let imgURL = URL(string: urlString) {
                            img1.load.request(with: imgURL) {_, error, _ in
                                if error != nil {
                                    print("errorxxxxx \(error)")
                                }
                            }
                        }
                    }
                    
                }
                contentWidth = 160 * ((picturesNumber <= 3) ? 0 : (picturesNumber-1))
                cell?.picturesStack.frame = CGRect(x: 0, y: 0, width: contentWidth, height: 140)
                cell?.scrollView.contentSize = CGSize(width: contentWidth, height: 155)
            }  else {
                if  let urlString = list[indexPath.row].post?.pics?.first {
                    cell?.showMainImage()
                    cell?.hideTinyGallerie()
                    cell?.mainImage.layer.cornerRadius = 0.0
                    if let imgURL = URL(string: urlString) {
                        if let cellViewImg = cell?.mainImage {
                        cell?.mainImage.addConstraint(
                            NSLayoutConstraint(
                                item: cellViewImg,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .notAnAttribute,
                                multiplier: 1, constant: 300))
                        cell?.mainImage.addConstraint(
                            NSLayoutConstraint(
                                item: cellViewImg,
                                attribute: .width,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .notAnAttribute,
                                multiplier: 1,
                                constant: 300))
                        cell?.mainImage.load.request(with: imgURL) {_, error, _ in
                            if error != nil {
                                print("error \(error)")
                            }
                        }
                    }
                    }
                }
            }
        }
        return cell ?? UICollectionViewCell()
    }
    func setAuthorData(cell: PhotosCell, list: [Datum], indexPath: IndexPath) {
        cell.userName.text = list[indexPath.row].name
        cell.userEmail.text = list[indexPath.row].email
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
                cell.dateLabel.text = "\(dateInScreen)\(dayordinal)"
            }
        }
        cell.userName.sizeToFit()
        if  let urlString = list[indexPath.row].profilePic {
            cell.userPicture.layer.cornerRadius = 20.0
            if let imgURL = URL(string: urlString) {
                cell.userPicture.load.request(with: imgURL) {_, error, _ in
                    if error != nil {
                        print("error \(error)")
                    }
                }
            }
        }
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
