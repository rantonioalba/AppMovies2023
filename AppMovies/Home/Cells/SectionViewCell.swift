//
//  SectionViewCellCollectionViewCell.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 18/02/23.
//

import UIKit

class SectionViewCell: BaseCell {
    
    let labelSection:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func setupView() {
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        addSubview(labelSection)
        
        labelSection.translatesAutoresizingMaskIntoConstraints = false
        labelSection.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0).isActive = true
        labelSection.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0.0).isActive = true
        labelSection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 1.0).isActive = true
        labelSection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1.0).isActive = true
    }
    
    func configureCell(description:String)  {
        let attributedString = NSMutableAttributedString(string: description, attributes: [
            .font: UIFont.systemFont(ofSize: 15),
                   .foregroundColor: UIColor.lightGray,
                 .kern:-0.3
               ])
               
        labelSection.attributedText = attributedString
        labelSection.textAlignment = .center
        labelSection.adjustsFontSizeToFitWidth = true
        
    }
    
    override var isSelected: Bool {
        didSet{
            self.backgroundColor = isSelected ? UIColor(red: 99/255.0, green: 99/255.0, blue: 102/255.0, alpha: 1.0) : UIColor(red: 23/255.0, green: 32/255.0, blue: 38/255.0, alpha: 1.0)
                        
            self.layer.cornerRadius = 5.0
            self.layer.masksToBounds = true
        }
    }
    
}
