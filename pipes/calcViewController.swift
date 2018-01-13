//cla
//  File.swift
//  pipes
//
//  Created by Vikram Mullick on 4/24/17.
//  Copyright © 2017 Vikram Mullick. All rights reserved.
//

import UIKit

class calcViewController: UIViewController {
    
    @IBOutlet weak var flowChoice: UIButton!
    @IBOutlet weak var inletChoice: UIButton!
    @IBOutlet weak var outletChoice: UIButton!
    
    @IBOutlet weak var flowView: UIView!
    @IBOutlet weak var inletView: UIView!
    @IBOutlet weak var outletView: UIView!
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var coverUp: UIView!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var chooserView: UIView!
    @IBOutlet weak var gasView: UIView!
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var lengthView: UIView!
    @IBOutlet weak var IDView: UIView!
    @IBOutlet weak var fieldOneView: UIView!
    @IBOutlet weak var fieldTwoView: UIView!
    @IBOutlet weak var calculateView: UIView!
    @IBOutlet weak var answerView: UIView!
    
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var IDlabel: UILabel!
    
    @IBOutlet weak var temperatureField: UITextField!
    
    @IBOutlet weak var fieldOneNameLabel: UILabel!
    @IBOutlet weak var fieldOneUnitsLabel: UILabel!
    @IBOutlet weak var fieldTwoNameLabel: UILabel!
    @IBOutlet weak var fieldTwoUnitsLabel: UILabel!
    @IBOutlet weak var fieldOne: UITextField!
    @IBOutlet weak var fieldTwo: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    
    var length : CGFloat = 0
    var ID : CGFloat = 0
    
    var gasIndex = 0
    @IBOutlet weak var gasButton: UIButton!
    
    var flow = false
    var inlet = false
    var outlet = false
    var answerText : String = String()
    var chosenGas : String = String()
    var tempText : String = String()
    var fieldOneText : String = String()
    var fieldTwoText : String = String()
    var mainCont = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        rootView.layer.cornerRadius = 10
        chooserView.layer.cornerRadius = 10
        gasView.layer.cornerRadius = 10
        temperatureView.layer.cornerRadius = 10
        flowView.layer.cornerRadius = 10
        inletView.layer.cornerRadius = 10
        outletView.layer.cornerRadius = 10
        lengthView.layer.cornerRadius = 10
        IDView.layer.cornerRadius = 10
        fieldOneView.layer.cornerRadius = 10
        fieldTwoView.layer.cornerRadius = 10
        calculateView.layer.cornerRadius = 10
        answerView.layer.cornerRadius = 10

        gasButton.titleLabel?.adjustsFontSizeToFitWidth = true
        flowChoice.titleLabel?.adjustsFontSizeToFitWidth = true
        inletChoice.titleLabel?.adjustsFontSizeToFitWidth = true
        outletChoice.titleLabel?.adjustsFontSizeToFitWidth = true
        IDlabel.adjustsFontSizeToFitWidth = true
        lengthLabel.adjustsFontSizeToFitWidth = true
        fieldOneUnitsLabel.adjustsFontSizeToFitWidth = true
        fieldTwoUnitsLabel.adjustsFontSizeToFitWidth = true
        answerLabel.adjustsFontSizeToFitWidth = true
        
        gasButton.setTitle(chosenGas, for: .normal)
        temperatureField.text = tempText
        fieldOne.text = fieldOneText
        fieldTwo.text = fieldTwoText


        if flow
        {
            flowView.backgroundColor = UIColor.green
            inletView.backgroundColor = UIColor.clear
            outletView.backgroundColor = UIColor.clear
            
            fieldOneNameLabel.text = "Pressure In:"
            fieldOneUnitsLabel.text = "psia"
            fieldTwoNameLabel.text = "Pressure Out:"
            fieldTwoUnitsLabel.text = "psia"
        }
        if inlet
        {
            flowView.backgroundColor = UIColor.clear
            inletView.backgroundColor = UIColor.green
            outletView.backgroundColor = UIColor.clear
            
            fieldOneNameLabel.text = "Pressure Out:"
            fieldOneUnitsLabel.text = "psia"
            fieldTwoNameLabel.text = "Flow Rate:"
            fieldTwoUnitsLabel.text = "MMSCFD"
        }
        if outlet
        {
            flowView.backgroundColor = UIColor.clear
            inletView.backgroundColor = UIColor.clear
            outletView.backgroundColor = UIColor.green
            
            fieldOneNameLabel.text = "Pressure In:"
            fieldOneUnitsLabel.text = "psia"
            fieldTwoNameLabel.text = "Flow Rate:"
            fieldTwoUnitsLabel.text = "MMSCFD"
            answerLabel.text = "Pressure Out"
        }
        
        answerLabel.text = answerText

        lengthLabel.text = "Length: " + String(describing: length) + " ft."
        IDlabel.text = "ID: " + String(describing: ID) + " in."

    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination : gasPickerViewController = segue.destination as? gasPickerViewController
        {
            destination.mainCont = self
            destination.currentIndex = gasIndex
        }
    }
    
    @IBAction func flowChosen(_ sender: Any) {
        flowView.backgroundColor = UIColor.green
        inletView.backgroundColor = UIColor.clear
        outletView.backgroundColor = UIColor.clear
        
        fieldOneNameLabel.text = "Pressure In:"
        fieldOneUnitsLabel.text = "psia"
        fieldTwoNameLabel.text = "Pressure Out:"
        fieldTwoUnitsLabel.text = "psia"
        answerLabel.text = "Flow Rate"
        fieldOne.text = ""
        fieldTwo.text = ""

        flow = true
        inlet = false
        outlet = false
    }
    @IBAction func inletChosen(_ sender: Any) {
        flowView.backgroundColor = UIColor.clear
        inletView.backgroundColor = UIColor.green
        outletView.backgroundColor = UIColor.clear
        
        fieldOneNameLabel.text = "Pressure Out:"
        fieldOneUnitsLabel.text = "psia"
        fieldTwoNameLabel.text = "Flow Rate:"
        fieldTwoUnitsLabel.text = "MMSCFD"
        answerLabel.text = "Pressure In"
        fieldOne.text = ""
        fieldTwo.text = ""

        flow = false
        inlet = true
        outlet = false
    }
    @IBAction func outletChosen(_ sender: Any) {
        flowView.backgroundColor = UIColor.clear
        inletView.backgroundColor = UIColor.clear
        outletView.backgroundColor = UIColor.green
        
        fieldOneNameLabel.text = "Pressure In:"
        fieldOneUnitsLabel.text = "psia"
        fieldTwoNameLabel.text = "Flow Rate:"
        fieldTwoUnitsLabel.text = "MMSCFD"
        answerLabel.text = "Pressure Out"
        fieldOne.text = ""
        fieldTwo.text = ""

        flow = false
        inlet = false
        outlet = true
    }
    func setupButton()
    {
        self.exitButton.alpha = 0.0
        self.exitButton.layer.cornerRadius = self.exitButton.frame.width/2
        
        self.coverUp.alpha = 0.0
        
        let shape1 = UIBezierPath()
        shape1.move(to: CGPoint(x: 20,y: 20))
        shape1.addLine(to: CGPoint(x: self.exitButton.frame.width-20,y: self.exitButton.frame.height-20))
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = shape1.cgPath
        shapeLayer1.strokeColor = UIColor.white.cgColor
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.lineWidth = 3
        exitButton.layer.addSublayer(shapeLayer1)
        
        let shape2 = UIBezierPath()
        shape2.move(to: CGPoint(x: 20,y: self.exitButton.frame.height-20))
        shape2.addLine(to: CGPoint(x: self.exitButton.frame.width-20,y: 20))
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = shape2.cgPath
        shapeLayer2.strokeColor = UIColor.white.cgColor
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.lineWidth = 3
        exitButton.layer.addSublayer(shapeLayer2)
        
     
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animate(withDuration: 0.2, animations: {
            self.exitButton.alpha = 1.0
            self.coverUp.alpha = 1.0
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func exit(_ sender: Any) {
        self.exitButton.alpha = 0.0
        self.coverUp.alpha = 0.0
        temperatureField.resignFirstResponder()
        fieldOne.resignFirstResponder()
        fieldTwo.resignFirstResponder()
        mainCont.flow = flow
        mainCont.inlet = inlet
        mainCont.outlet = outlet
        mainCont.chosenGas = (gasButton.titleLabel?.text)!
        mainCont.gasIndex = gasIndex
        mainCont.tempText = temperatureField.text!
        mainCont.fieldOneText = fieldOne.text!
        mainCont.fieldTwoText = fieldTwo.text!
        mainCont.answerText = answerLabel.text!
        self.dismiss(animated: true, completion: {});
    }
    
    @IBAction func tap(_ sender: Any) {
        temperatureField.resignFirstResponder()
        fieldOne.resignFirstResponder()
        fieldTwo.resignFirstResponder()
    }
    
    @IBAction func calculate(_ sender: Any) {
        var canCalculate = true

        if gasButton.titleLabel?.text == "select gas"
        {
            gasView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            canCalculate = false
        }
        else
        {
            gasView.backgroundColor = UIColor(red: 26/255.0, green: 152/255.0, blue: 252/255.0, alpha: 1)
        }

        if !numIsValid(str: temperatureField.text!)
        {
            temperatureView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            canCalculate = false
        }
        else
        {
            temperatureView.backgroundColor = UIColor(red: 26/255.0, green: 152/255.0, blue: 252/255.0, alpha: 1)
        }
        
        if length == 0
        {
            lengthView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            canCalculate = false
        }
        else
        {
            lengthView.backgroundColor = UIColor(red: 26/255.0, green: 152/255.0, blue: 252/255.0, alpha: 1)
        }
        
        if ID == 0
        {
            IDView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            canCalculate = false
        }
        else
        {
            IDView.backgroundColor = UIColor(red: 26/255.0, green: 152/255.0, blue: 252/255.0, alpha: 1)
        }
        
        if !numIsValid(str: fieldOne.text!)
        {
            fieldOneView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            canCalculate = false
        }
        else
        {
            fieldOneView.backgroundColor = UIColor(red: 26/255.0, green: 152/255.0, blue: 252/255.0, alpha: 1)
        }
        
        if !numIsValid(str: fieldTwo.text!)
        {
            fieldTwoView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            canCalculate = false
        }
        else
        {
            fieldTwoView.backgroundColor = UIColor(red: 26/255.0, green: 152/255.0, blue: 252/255.0, alpha: 1)
        }
        
        if canCalculate
        {
            let d : Double = Double(ID)
            let l : Double = Double(length)
            let t : Double = Double(temperatureField.text!)! + 459.67
            let s : Double = data.specificGravities[gasIndex]
            let z : Double = 1
            if flow
            {
                let p1 : Double = Double(fieldOne.text!)!
                let p2 : Double = Double(fieldTwo.text!)!
                let q = 1.1*pow(d,2.67)*pow((pow(p1,2)-pow(p2,2))/(l*s*z*t),0.5)
                answerLabel.text = "Flow Rate: " + String(round(1000.0*q)/1000.0) + " MMSCFD"
            }
            if inlet
            {
                let p2 : Double = Double(fieldOne.text!)!
                let q : Double = Double(fieldTwo.text!)!
                let p1 = pow(pow(q/1.1/pow(d,2.67),2)*l*t*s*z+pow(p2,2),0.5)
                answerLabel.text = "Pressure In: " + String(round(1000.0*p1)/1000.0) + " psia"
            }
            if outlet
            {
                let p1 : Double = Double(fieldOne.text!)!
                let q : Double = Double(fieldTwo.text!)!
                let p2 = pow(pow(p1,2)-pow(q/1.1/pow(d,2.67),2)*l*s*t*z,0.5)
                answerLabel.text = "Pressure Out: " + String(round(1000.0*p2)/1000.0) + " psia"
            }
        }
        
        
    }
   
    
    
    func numIsValid(str : String) -> Bool
    {
        if let _ : Double = Double(str)
        {
            return true
        }
        return false
    }
}
