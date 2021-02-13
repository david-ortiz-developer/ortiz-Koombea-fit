//
//  CollectionView.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 12/02/21.
//

import UIKit
import ImageLoader
extension HomeListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosData?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? PhotosCell
        if let list = photosData?.data {
            cell?.userName.text = list[indexPath.row].name
            cell?.userName.sizeToFit()
            if  let urlString = list[indexPath.row].profilePic {
                cell?.userPicture.layer.cornerRadius = 20.0
                if let imgURL = URL(string: urlString) {
                    cell?.userPicture.load.request(with: imgURL) {_, _, _ in
                    }
                }
            }
            if  let urlString = list[indexPath.row].post?.pics?.first {
                cell?.mainImage.layer.cornerRadius = 15.0
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
        let sizes = [CGSize(width: 300, height: 200), CGSize(width: 140, height: 300), CGSize(width: 140, height: 150)]
        return sizes.randomElement() ?? CGSize.zero
    }
}
