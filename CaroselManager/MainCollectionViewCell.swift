//
//  MainCollectionViewCell.swift
//  CaroselManager
//
//  Created by Pisit W on 29/5/2563 BE.
//  Copyright © 2563 confusians. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
    }
    
    func insertCorner() {
        imageView.layer.cornerRadius = 5
        self.clipsToBounds = true
        layer.cornerRadius = 5
    }
}
