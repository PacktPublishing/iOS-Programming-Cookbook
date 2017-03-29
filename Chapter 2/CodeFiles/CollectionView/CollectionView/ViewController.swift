//
//  ViewController.swift
//  CollectionView
//
//  Created by Hossam Ghareeb on 6/27/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    // MARK: - UICollectionViewDelegateFlowLayout -
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let cellWidth = width / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    
    
    // MARK: - UICollectionViewDatasource -
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.previewImageView.image = UIImage(named: "Dubai.png")
        return cell
    }

}

