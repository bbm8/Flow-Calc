//
//  gasPickerViewController.swift
//  pipes
//
//  Created by Vikram Mullick on 4/25/17.
//  Copyright © 2017 Vikram Mullick. All rights reserved.
//

import UIKit

class gasPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var currentIndex = 0
    var mainCont: calcViewController = calcViewController()
    
    @IBOutlet weak var rootView: UIView!
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.layer.cornerRadius = 10
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        self.picker.selectRow(currentIndex, inComponent: 0, animated: false)
        
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           numberOfRowsInComponent component: Int) -> Int
    {
        return data.gases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        self.currentIndex = row
        
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "", size: 30)
            pickerLabel?.textAlignment = NSTextAlignment.center
            pickerLabel?.adjustsFontSizeToFitWidth = true
        }
        
        pickerLabel?.text = data.gases[row]
        
        return pickerLabel!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: {});
    }
   
    @IBAction func sel(_ sender: Any) {
        print(currentIndex)
    
        mainCont.gasButton.setTitle(data.gases[currentIndex], for: .normal)
        mainCont.gasIndex = currentIndex
        print(data.gases[currentIndex])
        print(data.specificGravities[currentIndex])
        self.dismiss(animated: true, completion: {});

    }
 
    
}
