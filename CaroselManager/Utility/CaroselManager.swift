//
//  CaroselManager.swift
//  CaroselManager
//
//  Created by Pisit W on 29/5/2563 BE.
//  Copyright © 2563 confusians. All rights reserved.
//

import UIKit

class CaroselManager: NSObject {
    var didTapCell: ((IndexPath) -> ())?
    var collectionView: UICollectionView
    var parent: UIView
    init(collectionView: UICollectionView, parent: UIView? = nil) {
        self.collectionView = collectionView
        self.parent = parent ?? (collectionView.superview ?? UIView())
        super.init()
        collectionView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panPiece(_:))))
        collectionView.delegate = self
        
    }
    var start: CGFloat = 0
    var pageScrolled = false
    var nowPage = 0
    var currentPage = 0
    var startP: CGFloat = 0
    var maxPage = 0 { didSet {
        self.currentPage = maxPage
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.collectionView.scrollToItem(at: IndexPath(item: self.maxPage, section: 0), at: .centeredHorizontally, animated: false)
        }
        }}
    @IBAction func panPiece(_ gestureRecognizer : UIPanGestureRecognizer) {
            let pageDistance = ((self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize.width ?? 0) + ((self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0)
           let position = gestureRecognizer.location(in: parent)
           switch gestureRecognizer.state {
           case .began:
                nowPage = currentPage
               start = position.x + collectionView.contentOffset.x
            startP = position.x
           case .changed:
               let diff = position.x - start
               let offetDiff = collectionView.contentOffset.x - (CGFloat(nowPage) * pageDistance)
               
               if abs(startP - position.x) >= (pageDistance) {
                var newPage = nowPage
                if !self.pageScrolled {
                    self.currentPage += (offetDiff > 0 ? 1 : -1)
                }
                newPage += (offetDiff > 0 ? 1 : -1)
                self.pageScrolled = true
               } else {
                self.pageScrolled = false
                self.currentPage = nowPage
                collectionView.contentOffset = CGPoint(x: -diff, y: 0)
               }
           case .ended:
            let velocity = gestureRecognizer.velocity(in: collectionView)
            if !pageScrolled {
                if abs(velocity.x) > 600 {
                    self.currentPage += velocity.x > 0 ? -1 : 1
                } else {
                }
            } else {
            }
            self.collectionView.scrollToItem(at: IndexPath(item: self.currentPage, section: 0), at: .centeredHorizontally, animated: true)
            if self.currentPage == 1 {
                self.currentPage = self.maxPage + 1
            } else if self.currentPage == (self.maxPage * 2) - 2 {
                self.currentPage = (self.maxPage) - 2
            }
                self.pageScrolled = false
           default:
            break
            }
        }
}

extension CaroselManager: UICollectionViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.collectionView.scrollToItem(at: IndexPath(item: self.currentPage, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        didTapCell?(indexPath)
    }
}
