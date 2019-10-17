//
//  Network.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation


class Network {
    static func getExternalData<T: Decodable>(fileLocation: String, completionHandler: @escaping (T?, Error?) -> Void){
        if let url = URL(string: fileLocation) {
            var request = URLRequest(url: url)
            request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue(ApiConstants.accessToken, forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
                
                if error != nil {
                    completionHandler(nil, error)
                }
                
                if statusCode != 200 {
                    completionHandler(nil, error)
                }
                
                do {
                    if let jsonData = data {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
                            let value = try decoder.singleValueContainer().decode(String.self)
                            
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            
                            if let date = formatter.date(from: value) {
                                return date
                            }
                            return Date()
                        }
                        let typedObject: T? = try decoder.decode(T.self, from: jsonData)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            completionHandler(typedObject, nil)
                        }
                    }
                } catch {
                    completionHandler(nil, error)
                }
            }
            
            task.resume()
        } else {
            completionHandler(nil, NSError(domain: "Url does not exist", code: 1001, userInfo: nil))
        }
        
    }
    
    static func getImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        var request = URLRequest(url: url)
        request.addValue(ApiConstants.accessToken, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
    
    static func postRating(rating: Int, type: String.type, completion:  @escaping (Error?) -> ()) {
        var endpoint = Endpoints.rateMovie.replacingOccurrences(of: "#Id#", with: "\(rating)")
        endpoint = endpoint.replacingOccurrences(of: "#type#", with: type.rawValue)
        if let url = URL(string: endpoint) {
            var request = URLRequest(url: url)
            let parameterDictionary = ["value" : "\(rating)"]
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let _ = response {
                    completion(nil)
                }
                if let data = data {
                    do {
                        let _ = try JSONSerialization.jsonObject(with: data, options: [])
                        completion(nil)
                    } catch {
                        completion(error)
                    }
                }
                }.resume()
        }
    }
    
}
