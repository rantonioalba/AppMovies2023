//
//  CustomImageView.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 18/02/23.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

class CustomImageView: UIImageView {
    var urlString:String?
    var imageUrlString:String?
    
    
    func loadImageUsingUrlString(urlString:String, isAvatar:Bool = false)  {
        
        if isAvatar {
            self.urlString = "https://secure.gravatar.com/avatar/\(urlString)"
            
            imageUrlString = "https://secure.gravatar.com/avatar/\(urlString)"

        } else {
            self.urlString = "https://image.tmdb.org/t/p/w500/\(urlString)"
            
            imageUrlString = "https://image.tmdb.org/t/p/w500/\(urlString)"
        }
        
        
        image = nil
        
        guard let url = URL(string:self.urlString ?? "") else {
            return
        }
        

        if let imageFromCache = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = imageFromCache as? UIImage
            
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == self.urlString {
                    self.image = imageToCache
                }
                
                if imageToCache != nil {
                
                    imageCache.setObject(imageToCache!, forKey: NSString(string: self.urlString ?? ""))
                
                    self.image = imageToCache
                }
            }
        }.resume()
    }
}
