//
//  MovieCell.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 18/02/23.
//

import UIKit

class MovieCell: BaseCell {
    
    let imageView: CustomImageView = {
        let view = CustomImageView()
        view.image = UIImage(named: "logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 93/255.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelDate: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 93/255.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let labelRating: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor(red: 29/255.0, green: 180/255.0, blue: 93/255.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageViewRating: CustomImageView = {
        let view = CustomImageView()
        view.image = UIImage(named: "ic_star")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor(red: 29/255.0, green: 180/255.0, blue: 93/255.0, alpha: 1.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelSummary: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor(red: 219/255.0, green: 221/255.0, blue: 253/255.0, alpha: 1.0)
        view.numberOfLines = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func setupView() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(labelTitle)
        labelTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 12.0).isActive = true
        
        addSubview(labelDate)
        labelDate.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 15).isActive = true
        labelDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        labelDate.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        addSubview(labelRating)
        labelRating.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 15).isActive = true
        labelRating.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        labelRating.widthAnchor.constraint(equalToConstant: 20).isActive = true
        labelRating.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        addSubview(imageViewRating)
        imageViewRating.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 15).isActive = true
        imageViewRating.trailingAnchor.constraint(equalTo: labelRating.leadingAnchor, constant: -7).isActive = true
        imageViewRating.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageViewRating.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        addSubview(labelSummary)
        labelSummary.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 10).isActive = true
        labelSummary.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        labelSummary.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        labelSummary.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
                
    }
    
    func configureCell(result:Result)  {
        imageView.loadImageUsingUrlString(urlString: result.posterPath ?? "")
        
        labelTitle.text = result.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: result.firstAirDate ?? "")
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        labelDate.text = dateFormatter.string(from: date ?? Date())
//        labelDate.text = result.firstAirDate
        labelRating.text = "\(result.voteAverage ?? 0)"
        labelSummary.text = result.overview
    }
}
