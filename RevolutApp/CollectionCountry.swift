//
//  CollectionCountry.swift
//  RevolutApp
//
//  Created by Валентин Панин on 19.01.2021.
//

import Foundation
import UIKit

protocol CountryViewControllerDelegate: class {
    
    func countryViewController (_ viewController: CountryViewController, firstSelectedCountry name: String, secondSeltctedCountry name1: String)
    
}


class CountryViewController: UIViewController, UINavigationControllerDelegate {
    
    let service = Service()
    var countries: [String]? = []
    
    var selectedCurrency: String?
    
    weak var delegate: CountryViewControllerDelegate?
    
    var mainView: ViewCountry {
        
        return view as! ViewCountry
    }
    
    override func loadView() {
        view = ViewCountry()
    }
    
    
    let countryFile = "currencies"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        doSome()
    }
    
    func doSome() {
        
        countries = service.loadJson(fileName: countryFile)
        mainView.collectionView.reloadData()
        if let selectedCurrency = selectedCurrency, let indexArray = countries?.firstIndex(where: { $0 == selectedCurrency }) {
            mainView.collectionView.selectItem(at: IndexPath(item: indexArray, section: 0), animated: false, scrollPosition: [])
            print(indexArray)
        }
      
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    func getCurrencyFullName(code: String) -> String? {
           let locale1 = Locale(identifier: code)
           return locale1.localizedString(forCurrencyCode: code)
       }
    
}

extension CountryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        return CGSize(width: widht, height: 56.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


extension CountryViewController: UICollectionViewDelegate {
    
    func  collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let selectedCurrency = selectedCurrency {
           
            
            delegate?.countryViewController(self, firstSelectedCountry: selectedCurrency, secondSeltctedCountry: (countries?[indexPath.item])!)
            
            dismiss(animated: true)
            
            
        } else {
            
            let viewController = CountryViewController()
            viewController.delegate = delegate
            viewController.selectedCurrency = countries?[indexPath.item]
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
    
}

extension CountryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries?.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let name = countries?[indexPath.item]
        let flagLabelEmoji = flag(country: name ?? "error")
        let emoji = flagLabelEmoji.dropLast()
        let fullName = getCurrencyFullName(code: name ?? "error")
        cell.fullName.text = fullName
        cell.labelCountry.text = name
        cell.countryEmoji.text = String(emoji)
        cell.backgroundColor = .white

        return cell
    }
    
}

class CollectionViewCell: UICollectionViewCell {
    
    
    var labelCountry: UILabel = {
        let labelCountry = UILabel()
        labelCountry.textColor = .lightGray
        return labelCountry
    }()
    
    var countryEmoji: UILabel = {
        let countryEmoji = UILabel()
        return countryEmoji
    }()
    
    var fullName: UILabel = {
        let fullName = UILabel()
        fullName.textColor = .black
        return fullName
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                fullName.textColor = .systemBlue
                labelCountry.textColor = .systemBlue
                countryEmoji.textColor = .systemBlue
            } else {
                labelCountry.textColor = .lightGray
                fullName.textColor = .black
            }


        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(labelCountry)
        addSubview(countryEmoji)
        addSubview(fullName)
        
        
        labelCountry.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(56)
        }
        
        countryEmoji.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelCountry)
            make.left.equalTo(16)
            make.width.height.equalTo(24)
        }
        
        fullName.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(133)
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
   
    
    
}


