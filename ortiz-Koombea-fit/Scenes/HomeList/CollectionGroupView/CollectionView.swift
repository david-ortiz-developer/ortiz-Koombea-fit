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
            withReuseIdentifier: reuseIdentifier,
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
            if  let urlString = list[indexPath.row].post?.pics?.first {
                cell?.mainImage.layer.cornerRadius = 0.0
                if let imgURL = URL(string: urlString) {
                    cell?.mainImage.load.request(with: imgURL) {_, _, _ in
                        //cell?.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
                    }
                }
            }
        }
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 320)
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
