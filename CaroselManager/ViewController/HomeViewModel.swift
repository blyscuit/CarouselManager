//
//  HomeViewModel.swift
//  CaroselManager
//
//  Created by Pisit W on 29/5/2563 BE.
//  Copyright © 2563 confusians. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
    var dataSource = HomeBannerDataSource()
    
    override init() {
        super.init()
        dataSource = HomeBannerDataSource()
        dataSource.data.value = ["a8e05f", "fdd74b", "fe9b57", "a97abc"]

    }
}

class HomeBannerDataSource: GenericDataSource<String>, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCell
        let model = data.value[indexPath.row % data.value.count]
        cell?.imageView.backgroundColor = UIColor(hexString: model)
        cell?.insertCorner()
        return cell ?? UICollectionViewCell()
    }
}
