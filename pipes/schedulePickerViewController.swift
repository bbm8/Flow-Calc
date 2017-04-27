//
//  schedulePickerViewController.swift
//  pipes
//
//  Created by Vikram Mullick on 4/22/17.
//  Copyright © 2017 Vikram Mullick. All rights reserved.
//

import UIKit

class schedulePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currentIndex = 0
    var schedules: [String] = [String]()
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
        return schedules.count
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
        
        pickerLabel?.text = schedules[row]
        
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
        mainCont.scheduleButton.setTitle(schedules[currentIndex], for: .normal)
        mainCont.scheduleIndex = currentIndex
        mainCont.scheduleView.backgroundColor = UIColor(red: 26/255.0, green: 152/255.0, blue: 252/255.0, alpha: 1.0)
        mainCont.scheduleValid = true
        
        if mainCont.sizeValid && mainCont.scheduleValid && mainCont.pipeValid
        {
            mainCont.errorImage.isHidden = true
            if mainCont.homeController.appNameLabel.text == "error"
            {
                mainCont.homeController.appNameLabel.text = "Flow Calc"
                mainCont.homeController.appNameLabel.frame = CGRect(x: mainCont.homeController.appNameLabel.frame.origin.x-16-mainCont.homeController.appNameLabel.frame.height, y: mainCont.homeController.appNameLabel.frame.origin.y, width: mainCont.homeController.appNameLabel.frame.width+16+mainCont.homeController.appNameLabel.frame.height, height:mainCont.homeController.appNameLabel.frame.height)
            }
            
        }

        self.dismiss(animated: true, completion: {});
    }
   
    
    
}
