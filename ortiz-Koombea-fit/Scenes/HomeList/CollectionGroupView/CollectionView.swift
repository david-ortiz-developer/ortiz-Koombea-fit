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
                cellView.mainImageButton.picURL = imgURL
                cellView.mainImageButton.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
                cellView.mainImageButton.picURL = imgURL
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
                cellView.mainImage.load.request(with: imgURL)
                //cellView.clickCallBack = showDetail
                cellView.mainImageButton.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
                cellView.mainImageButton.picURL = imgURL
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
        cellView.picturesStack.translatesAutoresizingMaskIntoConstraints = false
        for indexPic in initialIndex..<picturesNumber {
            if  let urlString = list[indexPath.row].post?.pics?[indexPic] {
            if let imgURL = URL(string: urlString) {
            let galleryImage = UIImageView()
            galleryImage.contentMode = .scaleAspectFill
            galleryImage.image = UIImage(named: Constants.placeholderImageName)
                let galeryItemView = UIView()
                let itemButton = GalleryItemButton()
                galeryItemView.addSubview(galleryImage)
                galeryItemView.addSubview(itemButton)
                itemButton.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
                itemButton.picURL = imgURL
                cellView.scrollView.addSubview(galeryItemView)
                setSizeConstraintForItem(item: galleryImage)
                setSizeConstraintForItem(item: itemButton)
                setSizeConstraintForItem(item: galeryItemView)
                setleadinConstraintForItem(item: galleryImage, cellView: cellView, contentWidth: contentWidth)
                setleadinConstraintForItem(item: itemButton, cellView: cellView, contentWidth: contentWidth)
                setleadinConstraintForItem(item: galeryItemView, cellView: cellView, contentWidth: contentWidth)
                    galleryImage.load.request(with: imgURL)
                }
                contentWidth += Constants.galleryScrollContentWidth
            }
        }
        cellView.scrollView.contentSize = CGSize(width: contentWidth, height: 130)
    }
    func setleadinConstraintForItem(item: UIView, cellView: PhotosCell, contentWidth: CGFloat) {
        let margins = cellView.picturesStack.layoutMarginsGuide
        item.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: CGFloat(contentWidth)).isActive = true
        item.translatesAutoresizingMaskIntoConstraints = false
    }
    func setSizeConstraintForItem(item: UIView) {
        NSLayoutConstraint(item: item,
                           attribute: NSLayoutConstraint.Attribute.width,
                           relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: nil,
                           attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                           multiplier: 1,
                           constant: 140).isActive = true
        NSLayoutConstraint(item: item,
                           attribute: NSLayoutConstraint.Attribute.height,
                           relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: nil,
                           attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                           multiplier: 1,
                           constant: 140).isActive = true
    }
    @objc func handleTap(sender: GalleryItemButton) {
        if let url = sender.picURL {
            presenter?.showDetailView(url: url)
        }
    }
    func setAuthorData(cell: PhotosCell, list: [Datum], indexPath: IndexPath) {
        cell.userName.text = list[indexPath.row].name
        cell.userEmail.text = list[indexPath.row].email
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Constants.postFixlocale)
        dateFormatter.dateFormat = Constants.dateFormatterString
        if let dateString = list[indexPath.row].post?.date {
            if let date = dateFormatter.date(from: dateString) {
                print(date)
                print(dateString)
                let formaterOrdinal = DateFormatter()
                formaterOrdinal.locale = Locale(identifier: Constants.postFixlocale)
                formaterOrdinal.dateFormat = Constants.dateFormatterString
                let dateInScreen = formaterOrdinal.string(from: date)
                let dayordinal = daySuffix(from: date)
                cell.dateLabel.text = "\(dateInScreen)\(dayordinal)"
            }
        }
        cell.userName.sizeToFit()
        if  let urlString = list[indexPath.row].profilePic {
            cell.userPicture.layer.cornerRadius = Constants.cornerRadiusProfilePic
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
