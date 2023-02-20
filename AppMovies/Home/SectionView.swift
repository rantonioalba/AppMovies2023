//
//  SectionView.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 18/02/23.
//

import UIKit

class SectionView: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let cellId = "cellId"
    
    var sections : [String] = ["Popular","Top Rated","On TV","Airing Today"]
    
    var viewController:HomeViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        setupView()
        setSections()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let collectionView:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = .clear
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    func setupView()  {
        collectionView.register(SectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
    }
    
    func setSections() {
        self.collectionView.reloadData()
                
        let indexPath = IndexPath(item: 0, section: 0)

        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.top)
    }
    
    //MARK:UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SectionViewCell
        
        
        cell.configureCell(description: sections[indexPath.item])
        cell.backgroundColor = UIColor(red: 23/255.0, green: 32/255.0, blue: 38/255.0, alpha: 1.0)
        
        if indexPath.row == 0 && indexPath.section == 0 {
            cell.isSelected = true
        }
        
        cell.layer.cornerRadius = 5.0
         
        
        return cell
    }
    
    //MARK:UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController.scrollTo(indexPath: indexPath)
    }
    
    //MARK:UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.height)
    }
}
