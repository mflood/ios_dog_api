//
//  DogApi.swift
//  Dog Api
//
//  Created by Matthew Flood on 2/18/23.
//

import Foundation

class DogApi {
    
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }

}
