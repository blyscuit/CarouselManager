//
//  ViewController.swift
//  CaroselManager
//
//  Created by Pisit W on 29/5/2563 BE.
//  Copyright © 2563 confusians. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel = HomeViewModel()
    var caroselManager: CaroselManager!

    @IBOutlet weak var caroselCollectionView: UICollectionView!
    @IBOutlet weak var snappingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        caroselCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        snappingCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        snappingCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast

        caroselCollectionView.collectionViewLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: (self.caroselCollectionView.frame.width - 80), height: (self.caroselCollectionView.frame.width - 80) * (126/318))
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 16
            layout.scrollDirection = .horizontal
            return layout
        }()
        
        snappingCollectionView.collectionViewLayout = {
            let layout = SnappingCollectionViewLayout()
            layout.xModifier = -20
            layout.itemSize = CGSize(width: (self.snappingCollectionView.frame.height - 0), height: (self.snappingCollectionView.frame.height - 0))
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 16
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            layout.scrollDirection = .horizontal
            return layout
        }()
        
        
        caroselCollectionView.dataSource = viewModel.dataSource
        
        caroselManager = CaroselManager(collectionView: caroselCollectionView)
        caroselManager.maxPage = viewModel.dataSource.data.value.count
        caroselManager.didTapCell = { (indexPath) in
            print(indexPath.row)
        }
        
        snappingCollectionView.dataSource = viewModel.dataSource
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.caroselCollectionView?.collectionViewLayout.invalidateLayout()
        self.snappingCollectionView?.collectionViewLayout.invalidateLayout()
    }

}

