//
//  ViewController.swift
//  Dog Api
//
//  Created by Matthew Flood on 2/17/23.
//

import UIKit

enum KittenImageLocation: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var image: UIImageView!
    
    let breedList: [String] = ["hound", "pitt", "terrier"]
    let imageLocation = KittenImageLocation.http.rawValue
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard component == 0 else {
            return 0
        }
        return self.breedList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.breedList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(self.breedList[row])")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        
        self.picker.selectRow(0, inComponent: 0, animated: false)
        
        // Do any additional setup after loading the view.
        self.downloadKittenImage()
        self.getDogImageUrlUsingCodable()
    }
    
    
    func getDogImageUrlUsingCodable() {
        // Uses JSONSerialization....
        let randomDogUrl = DogApi.Endpoint.randomImageFromAllDogsCollection.url
        print(randomDogUrl)
        let task = URLSession.shared.dataTask(with: randomDogUrl) { data, response, error in
            
            guard let data = data else {
                print("no random dog data!")
                return
            }
            // data is json
            print(data)
            
            let decoder = JSONDecoder()
            
            do {
                let imageData = try decoder.decode(DogImage.self, from: data)
                print(imageData)
                guard let imageUrl = URL(string: imageData.message) else {
                    return
                }
                
                print(imageUrl)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func getDogImageUrlJsonSerialization() {
        // Uses JSONSerialization....
        let randomDogUrl = DogApi.Endpoint.randomImageFromAllDogsCollection.url
        print(randomDogUrl)
        let task = URLSession.shared.dataTask(with: randomDogUrl) { data, response, error in
            
            guard let data = data else {
                print("no random dog data!")
                return
            }
            // data is json
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
                
                let jsonDict = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                
                print(jsonDict)
                
                let url = jsonDict["message"] as! String
                print(url)
                
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    
    func downloadKittenImage() {
        guard let imageUrl = URL(string: self.imageLocation) else {
            print("Bad URL")
            return
        }
        
        
        let task = URLSession.shared.downloadTask(with: imageUrl) { (location, response, error) in
            guard let location = location else {
                print("location is nil")
                return
            }
            print(location)
            let imageData = try! Data(contentsOf: location)
            let downloadImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image.image = downloadImage
            }
        }
        task.resume()
    }
    
    func loadKittenImage() {
        guard let imageUrl = URL(string: self.imageLocation) else {
            print("Bad URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageUrl, completionHandler: {
            (data,response, error) in
            
            guard let data = data else {
                print("there was an error getting data")
                return
            }
            
            let downloadImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.image.image = downloadImage
            }
        })
        task.resume()
    }


}

