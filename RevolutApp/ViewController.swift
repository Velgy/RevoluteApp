//
//  ViewController.swift
//  RevolutApp
//
//  Created by Валентин Панин on 19.01.2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var twoCountyCurrency: [Model] = []
   
    private var mainView: ViewVal {
        return view as! ViewVal
    }
    
    override func loadView() {
        view = ViewVal()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Rites § converter"
        
        mainView.buttonPlus.addTarget(self, action: #selector(self.pressButtonPlus), for: .touchUpInside)
        mainView.buttonCur.addTarget(self, action: #selector(self.pressedButton), for: .touchUpInside)
        mainView.collectionView.register(CollectionViewCellCountry.self, forCellWithReuseIdentifier: "cell")
        mainView.collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
    }
    
    
    
    
    @objc
    func pressButtonPlus() {
        let vc = CountryViewController()
        vc.delegate = self
        let navigationVc = UINavigationController(rootViewController: vc)
        navigationVc.modalPresentationStyle = .fullScreen
        self.present(navigationVc, animated: true, completion: nil)
    }
    
    @objc
    func pressedButton() {
        let viewController = CountryViewController()
        viewController.delegate = self
        let navigationVc = UINavigationController(rootViewController: viewController)
        navigationVc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navigationVc, animated: true)
    }

}

extension ViewController: CountryViewControllerDelegate {
    
    func countryViewController(_ viewController: CountryViewController, firstSelectedCountry name: String, secondSeltctedCountry name1: String) {
        
        mainView.collectionView.reloadData()
        
        let url = URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios?pairs=\(name + name1)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dictionary: [String: Double] = try decoder.decode([String: Double].self, from: data)
                    print(dictionary)
                    DispatchQueue.main.async {
                        let model = Model(firstCountry: name, secondCountry: name1, course: dictionary[name + name1] ?? 0.0)
                        self.twoCountyCurrency.insert(model, at: 0)
                        self.mainView.collectionView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}



extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = collectionView.frame.width
        return CGSize(width: widht, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if twoCountyCurrency.count != 0 {
            return CGSize(width: collectionView.frame.width, height: 72)
        }
        return .zero
    }
}



extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            mainView.buttonCur.isHidden = twoCountyCurrency.count != 0
            mainView.buttonPlus.isHidden = twoCountyCurrency.count != 0
            mainView.label.isHidden = twoCountyCurrency.count != 0
        
        
        return twoCountyCurrency.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCellCountry
        cell.firstName.text = "1 " + twoCountyCurrency[indexPath.item].firstCountry
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                            NSAttributedString.Key.foregroundColor: UIColor.black]
        let myAttrString = NSAttributedString(string: cell.firstName.text!, attributes: myAttribute)
        cell.firstName.attributedText = myAttrString
        
        let currency = twoCountyCurrency[indexPath.item].course
        cell.secondName.text = ("\(currency)")
        
        let amountText = NSMutableAttributedString.init(string: cell.secondName.text!)
        amountText.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                                      NSAttributedString.Key.foregroundColor: UIColor.black],
                                 range: NSMakeRange(0, amountText.length > 3 ? 4 : 3))
        
        cell.secondName.attributedText = amountText
        
        cell.firstFullName.text = twoCountyCurrency[indexPath.item].firstFullName
        cell.secondFullName.text = twoCountyCurrency[indexPath.item].secondFullName! + "  " + twoCountyCurrency[indexPath.item].secondCountry
        
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HeaderCell
        
        reusableview.buttonPlus.addTarget(self, action: #selector(self.pressButtonPlus), for: .touchUpInside)
        reusableview.buttonCur.addTarget(self, action: #selector(self.pressedButton), for: .touchUpInside)
        
            return reusableview
    }
}

class CollectionViewCellCountry: UICollectionViewCell {
    
    
    var secondName: UILabel = {
        let secondName = UILabel()
        secondName.textColor = .black
       
        return secondName
    }()
    
    var firstName: UILabel = {
        let firstName = UILabel()
        firstName.textColor = .black
        return firstName
    }()
    
    var firstFullName: UILabel = {
        let fullName = UILabel()
        fullName.textColor = .lightGray
        return fullName
    }()
    
    var secondFullName: UILabel = {
        let fullName = UILabel()
        fullName.textColor = .lightGray
        return fullName
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(secondName)
        contentView.addSubview(firstName)
        contentView.addSubview(firstFullName)
        contentView.addSubview(secondFullName)
        
        firstName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        secondName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        firstFullName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        secondFullName.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
}

class HeaderCell: UICollectionReusableView {
    
    let buttonPlus: UIButton = {
        let buttonPlus = UIButton(type: .custom)
        let image = #imageLiteral(resourceName: "button_Plus1")
        buttonPlus.setImage(image, for: .normal)
        return buttonPlus
    }()
    
    let buttonCur: UIButton = {
        let buttonCur = UIButton(type: .system)
        buttonCur.backgroundColor = .white
        buttonCur.setTitle("Add currency pair", for: .normal)
        return buttonCur
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonPlus)
        addSubview(buttonCur)
        
        buttonPlus.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        
        buttonCur.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(buttonPlus.snp.right).offset(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
