//
//  ViewCountry.swift
//  RevolutApp
//
//  Created by Валентин Панин on 19.01.2021.
//

import Foundation
import UIKit

class ViewCountry: UIView {
    
    let collectionView: UICollectionView = {
        let layot = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layot)
        view.backgroundColor = UIColor.white
        view.contentInset = UIEdgeInsets(top: 12, left: 1, bottom: 10, right: 1)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
        
    }
    
    
}
