//
//  addPipeViewController.swift
//  pipes
//
//  Created by Vikram Mullick on 3/21/17.
//  Copyright © 2017 Vikram Mullick. All rights reserved.
//

import UIKit

class addPipeViewController: UIViewController {
    
    @IBOutlet weak var errorImage: UIImageView!
    
    var errorX : CGFloat = 0
    var xWidth : CGFloat = 0
    var width : CGFloat = 0
    var pipes = [AnyObject]()
    
    var iconViews = [UIView]()
    var labels = [UILabel]()
    var buttons = [UIButton]()
    
    var iconViewsToFix = [UIView]()
    var labelsToFix = [UILabel]()
    var buttonsToFix = [UIButton]()
    
    var sizeText = "select size"
    var scheduleText = "select schedule"
    
    var sizeValid = true
    var scheduleValid = true
    var pipeValid = true


    @IBOutlet weak var pipeScrollView: UIScrollView!
    
    
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var sizeButton: UIButton!
    @IBOutlet weak var scheduleButton: UIButton!
    
    @IBOutlet weak var pipeButton: UIButton!
    @IBOutlet weak var longPipeButton: UIButton!
    @IBOutlet weak var halfPipeButton: UIButton!
    @IBOutlet weak var shortPipeButton: UIButton!
    
    @IBOutlet weak var sizeView: UIView!
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    var homeController = ViewController()
    
    var sizeIndex : Int = 0
    var scheduleIndex : Int = 0
    var w : Int = Int()
    var currentScheduleOptions: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        
        w = Int(pipeScrollView.frame.width)/6

        sizeView.layer.cornerRadius = 10
        rootView.layer.cornerRadius = 10
        scheduleView.layer.cornerRadius = 10
        buttonsView.layer.cornerRadius = 10
        pipeScrollView.layer.cornerRadius = 10

        errorImage.isHidden = true
        errorImage.layer.cornerRadius = errorImage.frame.height/2
        
        sizeButton.setTitle(sizeText, for: .normal)
        scheduleButton.setTitle(scheduleText, for: .normal)
        
        if sizeText != "select size"
        {
            scheduleButton.isEnabled = true
            currentScheduleOptions = data.schedules[sizeIndex]
        }
        

        pipeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        longPipeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        shortPipeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        halfPipeButton.titleLabel?.adjustsFontSizeToFitWidth = true

        for i in 0..<iconViews.count
        {
            pipeScrollView.addSubview(iconViews[i])
            pipeScrollView.addSubview(buttons[i])
            pipeScrollView.addSubview(labels[i])
        
        }
        
        pipeScrollView.contentSize = CGSize(width: pipeScrollView.frame.width, height: CGFloat(5+(w+5)*(pipes.count)))
        
        
        errorX = homeController.appNameLabel.frame.origin.x+16+homeController.appNameLabel.frame.height
        xWidth = homeController.appNameLabel.frame.width-16-homeController.appNameLabel.frame.height
        
        
      
     
    }
    
    func setupButton()
    {
        self.exitButton.alpha = 0.0
        self.exitButton.layer.cornerRadius = self.exitButton.frame.width/2
        
        self.approveButton.alpha = 0.0
        self.approveButton.layer.cornerRadius = self.approveButton.frame.width/2
        
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
        
        let shape3 = UIBezierPath()
        shape3.move(to: CGPoint(x: 20,y: self.exitButton.frame.height/2))
        shape3.addLine(to: CGPoint(x: self.exitButton.frame.width/2,y: self.exitButton.frame.height-20))
        shape3.addLine(to: CGPoint(x: self.exitButton.frame.width-20,y: 20))
        let shapeLayer3 = CAShapeLayer()
        shapeLayer3.path = shape3.cgPath
        shapeLayer3.strokeColor = UIColor.white.cgColor
        shapeLayer3.fillColor = UIColor.clear.cgColor
        shapeLayer3.lineWidth = 3
        approveButton.layer.addSublayer(shapeLayer3)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animate(withDuration: 0.2, animations: {
            self.exitButton.alpha = 1.0
            self.approveButton.alpha = 1.0
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination : sizePickerViewController = segue.destination as? sizePickerViewController
        {
            destination.mainCont = self
            destination.currentIndex = sizeIndex
        }
        if let destination : schedulePickerViewController = segue.destination as? schedulePickerViewController
        {
            if let button : UIButton = sender as? UIButton
            {
                print(button.titleLabel?.text as Any)
            }
            destination.mainCont = self
            destination.schedules = currentScheduleOptions
            destination.currentIndex = scheduleIndex
        }
        if let destination : ellOrientationViewController = segue.destination as? ellOrientationViewController
        {
            if let button : UIButton = sender as? UIButton
            {
                destination.tText = (button.titleLabel?.text)!
            }
            destination.mainCont = self
        }
        if let destination : pipeLenViewController = segue.destination as? pipeLenViewController
        {
            destination.mainCont = self
        }
    }
    
    @IBAction func exit(_ sender: Any) {
        
        self.exitButton.alpha = 0.0
        self.approveButton.alpha = 0.0
        
        homeController.appNameLabel.frame = CGRect(x: errorX-16-homeController.appNameLabel.frame.height, y:  homeController.appNameLabel.frame.origin.y, width: xWidth+16+homeController.appNameLabel.frame.height, height:homeController.appNameLabel.frame.height)
        
        for i in 0..<iconViewsToFix.count
        {
            self.buttonsToFix[i].frame = CGRect(x: self.buttonsToFix[i].frame.origin.x, y: self.buttonsToFix[i].frame.origin.y+15+self.buttonsToFix[i].frame.height, width: self.buttonsToFix[i].frame.width, height: self.buttonsToFix[i].frame.height)
            self.labelsToFix[i].frame = CGRect(x: self.labelsToFix[i].frame.origin.x, y: self.labelsToFix[i].frame.origin.y+5+self.labelsToFix[i].frame.height, width: self.labelsToFix[i].frame.width, height: self.labelsToFix[i].frame.height)
            self.iconViewsToFix[i].frame = CGRect(x: self.iconViewsToFix[i].frame.origin.x, y: self.iconViewsToFix[i].frame.origin.y+5+self.iconViewsToFix[i].frame.height, width: self.iconViewsToFix[i].frame.width, height: self.iconViewsToFix[i].frame.height)
            self.buttonsToFix[i].tag = self.buttonsToFix[i].tag+1
            
        }
        
        self.dismiss(animated: true, completion: {self.homeController.appNameLabel.text = "Flow Calc"});

    }
    
    @IBAction func approve(_ sender: Any) {
        
        if sizeButton.titleLabel?.text != "select size" && scheduleButton.titleLabel?.text != "select schedule" && pipes.count > 0
        {
            homeController.pipes = pipes
            
            homeController.labels = labels
            homeController.iconViews = iconViews
            homeController.buttons = buttons
            
            homeController.sizeText = (sizeButton.titleLabel?.text)!
            homeController.scheduleText = (scheduleButton.titleLabel?.text)!
            homeController.sizeIndex = sizeIndex
            homeController.scheduleIndex = scheduleIndex
            
            errorImage.isHidden = true

            self.dismiss(animated: true, completion: {self.homeController.drawPipes()})
            
        }
        else
        {
            errorImage.isHidden = false
            homeController.appNameLabel.text = "error"
            homeController.appNameLabel.frame = CGRect(x: errorX, y: homeController.appNameLabel.frame.origin.y, width: xWidth, height:homeController.appNameLabel.frame.height)
            if sizeButton.titleLabel?.text == "select size"
            {
                sizeView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
                sizeValid = false
            }
          
            if scheduleButton.titleLabel?.text == "select schedule"
            {
                scheduleView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
                scheduleValid = false
            }
        
            if pipes.count < 1
            {
                pipeScrollView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
                pipeValid = false
            }
           
           
        }

    }
    func addButtonFunctionality(button: UIButton)
    {
        button.addTarget(self, action: #selector(deleteElement), for: .touchUpInside)
    }
    func deleteElement(sender: UIButton!) {
        
        pipes.remove(at: sender.tag)
        iconViews.remove(at: sender.tag).removeFromSuperview()
        buttons.remove(at: sender.tag).removeFromSuperview()
        labels.remove(at: sender.tag).removeFromSuperview()
        if iconViews.count != sender.tag
        {
            for i in sender.tag...iconViews.count-1
            {
                buttons[i].tag = buttons[i].tag-1
                UIView.animate(withDuration: 0.05, delay: 0.15, options: .curveEaseOut, animations:
                {
                    
                    self.buttons[i].frame = CGRect(x: self.buttons[i].frame.origin.x, y: self.buttons[i].frame.origin.y-15-self.buttons[i].frame.height, width: self.buttons[i].frame.width, height: self.buttons[i].frame.height)
                    self.labels[i].frame = CGRect(x: self.labels[i].frame.origin.x, y: self.labels[i].frame.origin.y-5-self.labels[i].frame.height, width: self.labels[i].frame.width, height: self.labels[i].frame.height)
                    self.iconViews[i].frame = CGRect(x: self.iconViews[i].frame.origin.x, y: self.iconViews[i].frame.origin.y-5-self.iconViews[i].frame.height, width: self.iconViews[i].frame.width, height: self.iconViews[i].frame.height)
                    
                    self.buttonsToFix.append(self.buttons[i])
                    self.labelsToFix.append(self.labels[i])
                    self.iconViewsToFix.append(self.iconViews[i])

                }, completion: nil)
                
            }
            
                
            
        }
        
        pipeScrollView.contentSize = CGSize(width:pipeScrollView.frame.width, height: CGFloat(5+(w+5)*(pipes.count)))

     
    }
}
