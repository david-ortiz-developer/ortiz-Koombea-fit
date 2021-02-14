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
                    cellView.showMainImage()
                    cellView.showTinyGallerie()
                    initialIndex = showAuthorInfo(list: list, cellView: cellView, indexPath: indexPath)
                } else {
                    cellView.hideMainImage()
                    cellView.showTinyGallerie()
                }
                tinyPicsGallery(initialIndex: initialIndex,
                                picturesNumber: picturesNumber,
                                list: list,
                                indexPath: indexPath,
                                cellView: cellView) } else {
                    showOnlyOnePic(indexPath: indexPath,
                                   cellView: cellView,
                                   list: list)
                }
        }
        return cell ?? UICollectionViewCell()
    }
    func showOnlyOnePic(indexPath: IndexPath, cellView: PhotosCell, list: [Datum]) {
        if  let urlString = list[indexPath.row].post?.pics?.first {
            cellView.showMainImage()
            cellView.hideTinyGallerie()
            cellView.mainImage.layer.cornerRadius = 0.0
            if let imgURL = URL(string: urlString) {
                if let cellViewImg = cellView.mainImage {
                    cellViewImg.addConstraint(
                        NSLayoutConstraint(
                            item: cellViewImg,
                            attribute: .height,
                            relatedBy: .equal,
                            toItem: nil,
                            attribute: .notAnAttribute,
                            multiplier: 1, constant: 300))
                    cellViewImg.addConstraint(
                        NSLayoutConstraint(
                            item: cellViewImg,
                            attribute: .width,
                            relatedBy: .equal,
                            toItem: nil,
                            attribute: .notAnAttribute,
                            multiplier: 1,
                            constant: 300))
                    cellViewImg.load.request(with: imgURL)
                }
            }
        }
    }
    func showAuthorInfo(list: [Datum], cellView: PhotosCell, indexPath: IndexPath) -> Int {
        var initialIndex = 0
        if  let urlString = list[indexPath.row].post?.pics?[0] {
            cellView.mainImage.layer.cornerRadius = 0.0
            if let imgURL = URL(string: urlString) {
                initialIndex = 1
                cellView.mainImage.load.request(with: imgURL) {_, error, _ in
                    if error != nil {
                        print("error \(error.debugDescription)")
                    }
                }
            }
        }
        return initialIndex
    }
    func tinyPicsGallery(initialIndex: Int,
                         picturesNumber: Int,
                         list: [Datum],
                         indexPath: IndexPath,
                         cellView: PhotosCell) {
        var contentWidth: CGFloat = 0
        for indexPic in initialIndex..<picturesNumber {
            let img1 = UIImageView()
            if  let urlString = list[indexPath.row].post?.pics?[indexPic] {
                img1.contentMode = .scaleAspectFit
                img1.translatesAutoresizingMaskIntoConstraints = false
                img1.image = UIImage(named: "placeholderImge")
                img1.addConstraint(NSLayoutConstraint(
                                    item: img1,
                                    attribute: .height,
                                    relatedBy: .equal,
                                    toItem: nil,
                                    attribute: .notAnAttribute,
                                    multiplier: 1,
                                    constant: 140))
                img1.addConstraint(NSLayoutConstraint(
                                    item: img1,
                                    attribute: .width,
                                    relatedBy: .equal,
                                    toItem: nil,
                                    attribute: .notAnAttribute,
                                    multiplier: 1,
                                    constant: 140))
                cellView.picturesStack.addArrangedSubview(img1)
                contentWidth += 150
                if let imgURL = URL(string: urlString) {
                    img1.load.request(with: imgURL)
                }
            }
        }
        cellView.picturesStack.frame = CGRect(x: 0, y: 0, width: contentWidth, height: 155)
        cellView.scrollView.contentSize = CGSize(width: contentWidth, height: 155)
    }
    func setAuthorData(cell: PhotosCell, list: [Datum], indexPath: IndexPath) {
        cell.userName.text = list[indexPath.row].name
        cell.userEmail.text = list[indexPath.row].email
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E MMM d yyyy hh:mm:ss 'GMT'ZZZZ (zzzz)"
        if let dateString = list[indexPath.row].post?.date {
            if let date = dateFormatter.date(from: dateString) {
                print(date)
                print(dateString)
                let formaterOrdinal = DateFormatter()
                formaterOrdinal.locale = Locale(identifier: "en_US_POSIX")
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
                cell.userPicture.load.request(with: imgURL)
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
