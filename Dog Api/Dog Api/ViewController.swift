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
        self.loadKittenImage()
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

