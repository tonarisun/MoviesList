//
//  UIImage Extension.swift
//  MoviesList
//
//  Created by Olga Lidman on 10/09/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func downloaded(from url: URL, mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, mode: mode)
    }
    
    func cacheImage(urlString: String){
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if data != nil {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
            }.resume()
    }
}

extension UIViewController {
    
//    Выбор цвета текста в зависимости от значения рейтинга
    func setRatingColor(rating: Double, label: UILabel) {
        switch rating {
        case 0.001...4.9999:
            label.textColor = #colorLiteral(red: 1, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
        case 5.000...6.999:
            label.textColor = #colorLiteral(red: 0.3725490196, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
        case 7.000...10.000:
            label.textColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 0, alpha: 1)
        default:
            label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
//    Алерт
    func sendAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
