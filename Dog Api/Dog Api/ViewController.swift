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
    let imageLocation = KittenImageLocation.https.rawValue
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
            
            
        })
        task.resume()
                                            
        
        
        
    }


}

