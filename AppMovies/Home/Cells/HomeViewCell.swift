//
//  HomeViewCell.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 18/02/23.
//

import UIKit

protocol ShowTVProtocol {
    func showSelected(_ showTV: Result)
}

class HomeViewCell: BaseCell {
    
    var collectionView : UICollectionView!
    var popularShows : ShowsTV?
    var showsTV : ShowsTV?
    var delegate : ShowTVProtocol?
    
    override func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 9/255.0, green: 22/255.0, blue: 26/255.0, alpha: 1.0)
        collectionView.contentInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "\(MovieCell.self)")

        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
    }
    
    func configureCell(showsTV :  ShowsTV?)  {
        self.showsTV = showsTV
        self.collectionView.reloadData()
    }
}

extension HomeViewCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.showsTV?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCell.self)", for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        
        if let result = self.showsTV?.results?[indexPath.row] {
            cell.configureCell(result: result)
        }
        
                
        cell.backgroundColor = UIColor(red: 21/255.0, green: 39/255.0, blue: 46/255.0, alpha: 1.0)
        
        cell.layer.cornerRadius = 15.0
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let result = self.showsTV?.results?[indexPath.row] {
            self.delegate?.showSelected(result)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 15) / 2, height: 350)
    }
}
