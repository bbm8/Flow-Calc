//
//  sizePickerViewController.swift
//  pipes
//
//  Created by Vikram Mullick on 4/21/17.
//  Copyright © 2017 Vikram Mullick. All rights reserved.
//

import UIKit

class sizePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
   
    var currentIndex = 0
    var mainCont: addPipeViewController = addPipeViewController()
    
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
        return data.items.count
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
            //pickerLabel?.textColor = UIColor.white
            pickerLabel?.adjustsFontSizeToFitWidth = true
        }
        
        pickerLabel?.text = data.items[row][0] + " | " + data.items[row][1] + "\" | " + data.items[row][2] + "mm"
        
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
        
        mainCont.sizeButton.setTitle(getString(index: currentIndex), for: .normal)
        mainCont.scheduleButton.isEnabled = true
        mainCont.scheduleButton.setTitle("select schedule", for: .normal)
        mainCont.currentScheduleOptions = data.schedules[currentIndex]
        mainCont.sizeIndex = currentIndex
        mainCont.scheduleIndex = 0
        mainCont.sizeView.backgroundColor = UIColor(red: 26/255.0, green: 152/255.0, blue: 252/255.0, alpha: 1.0)

        
        mainCont.sizeValid = true
        
        if mainCont.sizeValid && mainCont.scheduleValid && mainCont.pipeValid
        {
            mainCont.errorImage.isHidden = true
        }
        self.dismiss(animated: true, completion: {});
    }
    
    func getString(index: Int) -> String
    {
        return data.items[index][0] + "   " + data.items[index][1] + "\" | " + data.items[index][2] + "mm"
    }
    
    
}
