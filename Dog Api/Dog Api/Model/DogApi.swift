//
//  DogApi.swift
//  Dog Api
//
//  Created by Matthew Flood on 2/18/23.
//

import Foundation
import UIKit

class DogApi {
    
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }

    class func requestRandomImageUrl(completionHandler: @escaping (DogImage?, Error?) -> Void ) {
       
        let randomDogUrl = DogApi.Endpoint.randomImageFromAllDogsCollection.url
        print(randomDogUrl)
        
        let task = URLSession.shared.dataTask(with: randomDogUrl) { data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let imageData = try decoder.decode(DogImage.self, from: data)
                print(imageData)
                completionHandler(imageData, nil)
            } catch {
                print(error)
            }
            return
        }
        task.resume()
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let image = UIImage(data: data)
            completionHandler(image, nil)
            return
        }
        task.resume()
    }
}
