//
//  Extensions.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit
import Foundation
import Network

extension String {
    enum type : String {
        case movie,tv
    }
    enum filmCategory : String {
        case popular,top_rated, upcoming
        case on_the_air
        case searched
    }
    
    enum seriesCategory: String {
        case airing_today
        case popular
        case top_rated
    }
    func getMovieUrl(type: type, event: filmCategory) -> String {
        var urlString = self.replacingOccurrences(of: "%type%", with: type.rawValue)
        urlString = urlString.replacingOccurrences(of: "%event%", with: event.rawValue)
        print(urlString)
        return urlString
    }
    
    func getTVUrl(type: type, event: seriesCategory) -> String {
        var urlString = self.replacingOccurrences(of: "%type%", with: type.rawValue)
        urlString = urlString.replacingOccurrences(of: "%event%", with: event.rawValue)
        print(urlString)
        return urlString
    }
    
}

extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

extension UIImage {
    static let imageCache = NSCache<AnyObject, AnyObject>()
    static func cacheImage(from endPoint: String, id: Int, completion: @escaping (UIImage?) -> ()) {
        if let url = URL.init(string: endPoint) {
            Network.getImage(from: url) { data, response, error in
                
                guard error == nil else {
                    print(error!.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let currData = data else {
                    completion(nil)
                    return
                }
                
                guard let image = UIImage(data: currData) else {
                    completion(nil)
                    return
                }
                
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: id as AnyObject)
                }
                
                completion(image)
            }
        }
        
    }
}

extension UIImageView {
    func downloadFrom(path: String, id: Int){
        UIImage.cacheImage(from: "\(Endpoints.imageURL)\(path)?api_key=\(ApiConstants.api_key)", id: id) { (image) in
            guard let imageFromCache = image else {
                return
            }
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
        }
    }
}

extension UIView{
    
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}


