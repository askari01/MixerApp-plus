//
//  ViewController.swift
//  MixerApp Plus
//
//  Created by Syed Askari on 9/15/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var secure: UIPickerView!
    
    var pickerData = ["http://","https://"]
    var def = "http://"

    
    let pref = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        secure.dataSource = self
        secure.delegate = self
        url.layer.cornerRadius = 5
        url.layer.borderWidth = 0
//        url.backgroundColor = U
        
        self.secure.selectRow(0, inComponent: 0, animated: false)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        def = pickerData[row]
        print(pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let strTitle = pickerData[row]
        let attString = NSAttributedString(string: strTitle, attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var goAction: UIButton!
    
    @IBAction func goActionCall(_ sender: Any) {
        if url.text != "" {
            self.pref.set("\(def)\(String(describing: url.text!))", forKey: "url")
            performSegue(withIdentifier: "go", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go" {
            if let webVC = segue.destination as? WebVC {
                webVC.urlPassed = pref.value(forKey: "url") as! String
            }
        }
    }
}

