//
//  ImageProviderCell.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 20/02/23.
//

import UIKit

class ImageProviderCell: BaseCell {
    let imageView: CustomImageView = {
        let view = CustomImageView()
        view.image = UIImage(named: "logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupView() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func configureCell (pathImage: String)  {
        imageView.loadImageUsingUrlString(urlString: pathImage)
    }
}
