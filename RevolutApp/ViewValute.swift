//
//  ViewValute.swift
//  RevolutApp
//
//  Created by Валентин Панин on 19.01.2021.
//

import Foundation
import UIKit
import SnapKit

class ViewVal: UIView {
    
    let collectionView: UICollectionView = {
        let layot = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layot)
        view.backgroundColor = UIColor.white
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return view
    }()
    
    let buttonPlus: UIButton = {
        let buttonPlus = UIButton(type: .custom)
        let image = UIImage(named: "button_Plus1")
        buttonPlus.setImage(image, for: .normal)
        return buttonPlus
    }()
    
    let buttonCur: UIButton = {
        let buttonCur = UIButton(type: .system)
        buttonCur.backgroundColor = .white
        buttonCur.setTitle("Add currency pair", for: .normal)
        return buttonCur
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Choose a currency pair to compare their live rates"
        label.textColor = .lightGray
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(collectionView)
        addSubview(buttonPlus)
        addSubview(buttonCur)
        addSubview(label)
        
        
        buttonPlus.snp.makeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
        }
        
        buttonCur.snp.makeConstraints { (make) in
            make.centerX.equalTo(buttonPlus)
            make.top.equalTo(buttonPlus.snp.bottom).offset(10)
        }
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(buttonPlus)
            make.top.equalTo(buttonCur.snp.bottom).offset(10)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
