//
//  ellOrientationViewController.swift
//  pipes
//
//  Created by Vikram Mullick on 4/22/17.
//  Copyright © 2017 Vikram Mullick. All rights reserved.
//

import UIKit

class ellOrientationViewController: UIViewController {
    
    var clockwise = true
    var mainCont: addPipeViewController = addPipeViewController()

    @IBOutlet weak var cView: UIView!
    @IBOutlet weak var ccView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var ccButton: UIButton!
    
    @IBOutlet weak var rootView: UIView!
    
    @IBOutlet weak var tLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    var tText : String = "label"
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.layer.cornerRadius = 10
        cView.layer.cornerRadius = 10
        ccView.layer.cornerRadius = 10
        tLabel.text = tText
        tLabel.adjustsFontSizeToFitWidth = true
        cButton.titleLabel?.adjustsFontSizeToFitWidth = true
        ccButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    override func viewDidAppear(_ animated: Bool) {
        if tText == "45° ell"
        {
            _ = drawArc(xE: iconView.frame.height/3, yE: iconView.frame.height/6*5, wid: iconView.frame.height/3, ang: CGFloat(M_PI/2), ratio: 1, angleChange: -1*CGFloat(M_PI/4), view: iconView)
        }
        if tText == "Short rad. ell"
        {
            _ = drawArc(xE: iconView.frame.height/2-iconView.frame.height/12, yE: iconView.frame.height/2+iconView.frame.height/4, wid: iconView.frame.height/3, ang: CGFloat(M_PI/2), ratio: 0.5, angleChange: -1*CGFloat(M_PI/2), view: iconView)
        }
        if tText == "Long rad. ell"
        {
            _ = drawArc(xE: iconView.frame.height/3, yE: iconView.frame.height/6*5, wid: iconView.frame.height/3, ang: CGFloat(M_PI/2), ratio: 1, angleChange: -1*CGFloat(M_PI/2), view: iconView)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clockwiseTap(_ sender: Any){
        clockwise = true
        addButton.isEnabled = true
        cView.backgroundColor = UIColor.green
        ccView.backgroundColor = UIColor.clear

        
    }
    @IBAction func counterclockwiseTap(_ sender: Any){
        clockwise = false
        addButton.isEnabled = true
        cView.backgroundColor = UIColor.clear
        ccView.backgroundColor = UIColor.green

    }
    
    @IBAction func add(_ sender: Any) {
        
        let w =  Int(mainCont.pipeScrollView.frame.width)/6
        
        let x = UIView()
        x.frame = CGRect(x: 5, y: 5+(w+5)*mainCont.pipes.count, width: w, height: w)
        x.backgroundColor = UIColor.white
        x.layer.cornerRadius = 10

        let y = UILabel()
        y.frame = CGRect(x: 10+w, y: 5+(w+5)*mainCont.pipes.count, width: Int(mainCont.pipeScrollView.frame.width)-2*w-20, height: w)
        y.backgroundColor = UIColor.init(red: 69/255.0, green: 174/255.0, blue: 245/255.0, alpha: 1)
        y.textColor = UIColor.white
        y.textAlignment = .center
        y.text =  "orientation: "
        if clockwise
        {
            y.text = y.text! + "clockwise"
        }
        else
        {
            y.text = y.text! + "counterclockwise"
        }
        y.adjustsFontSizeToFitWidth = true
        
        if tText == "45° ell"
        {
            _ = drawArc(xE: x.frame.height/3, yE: x.frame.height/6*5, wid: x.frame.height/3, ang: CGFloat(M_PI/2), ratio: 1, angleChange: -1*CGFloat(M_PI/4), view: x)
        }
        if tText == "Short rad. ell"
        {
            _ = drawArc(xE: x.frame.height/2-x.frame.height/12, yE: x.frame.height/2+x.frame.height/4, wid: x.frame.height/3, ang: CGFloat(M_PI/2), ratio: 0.5, angleChange: -1*CGFloat(M_PI/2), view: x)
        }
        if tText == "Long rad. ell"
        {
            _ = drawArc(xE: x.frame.height/3, yE: x.frame.height/6*5, wid: x.frame.height/3, ang: CGFloat(M_PI/2), ratio: 1, angleChange: -1*CGFloat(M_PI/2), view: x)
        }
        
        let z = UIButton()
        z.backgroundColor = UIColor.white
        z.frame = CGRect(x: Int(mainCont.pipeScrollView.frame.width)-w, y: 10+(w+5)*mainCont.pipes.count, width: w-10, height: w-10)
        z.layer.cornerRadius = z.frame.width/2
        
        let shape1 = UIBezierPath()
        shape1.move(to: CGPoint(x: z.frame.width/4,y: z.frame.width/4))
        shape1.addLine(to: CGPoint(x: z.frame.width*3/4,y: z.frame.height*3/4))
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = shape1.cgPath
        shapeLayer1.strokeColor = UIColor.red.cgColor
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.lineWidth = 3
        z.layer.addSublayer(shapeLayer1)
        
        let shape2 = UIBezierPath()
        shape2.move(to: CGPoint(x: z.frame.width/4,y: z.frame.height*3/4))
        shape2.addLine(to: CGPoint(x: z.frame.width*3/4,y: z.frame.width/4))
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = shape2.cgPath
        shapeLayer2.strokeColor = UIColor.red.cgColor
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.lineWidth = 3
        z.layer.addSublayer(shapeLayer2)
        
        
        mainCont.pipeScrollView.addSubview(x)
        mainCont.pipeScrollView.addSubview(y)
        mainCont.pipeScrollView.addSubview(z)
        
        z.tag = mainCont.pipes.count

        mainCont.pipeScrollView.contentSize = CGSize(width: mainCont.pipeScrollView.frame.width, height: CGFloat(5+(w+5)*(mainCont.pipes.count+1)))
        if mainCont.pipeScrollView.contentSize.height - mainCont.pipeScrollView.bounds.size.height > 0
        {
            let bottomOffset = CGPoint(x: 0, y: mainCont.pipeScrollView.contentSize.height - mainCont.pipeScrollView.bounds.size.height)
            mainCont.pipeScrollView.setContentOffset(bottomOffset, animated: true)
        }
        
        var scalar : CGFloat = 1
        if clockwise
        {
            scalar = -1
        }
        if tText == "45° ell"
        {
            mainCont.pipes.append(Curve(ratio: 1, angleChange: scalar*CGFloat(M_PI/4)) as AnyObject)
        }
        if tText == "Short rad. ell"
        {
            mainCont.pipes.append(Curve(ratio: 0.5, angleChange: scalar*CGFloat(M_PI/2)) as AnyObject)
        }
        if tText == "Long rad. ell"
        {
            mainCont.pipes.append(Curve(ratio: 1, angleChange: scalar*CGFloat(M_PI/2)) as AnyObject)
        }
        
        mainCont.addButtonFunctionality(button: z)
        
        mainCont.buttons.append(z)
        mainCont.labels.append(y)
        mainCont.iconViews.append(x)

        mainCont.pipeScrollView.backgroundColor = UIColor(red: 26/255.0, green: 152/255.0, blue: 252/255.0, alpha: 1.0)
        
        mainCont.pipeValid = true
        
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
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: {});
    }
    
    func drawRec(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat,x3: CGFloat, y3: CGFloat, x4: CGFloat, y4: CGFloat, view: UIView)
    {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: x1,y: y1))
        shape.addLine(to: CGPoint(x: x2,y: y2))
        shape.addLine(to: CGPoint(x: x3,y: y3))
        shape.addLine(to: CGPoint(x: x4,y: y4))
        shape.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shape.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 1
        view.layer.addSublayer(shapeLayer)
        
    }
    
    func drawArc(xE: CGFloat, yE: CGFloat, wid: CGFloat, ang: CGFloat, ratio: CGFloat, angleChange: CGFloat, view: UIView) -> (Edge)
        
    {
        let shape = UIBezierPath()
        var angleSignChange : CGFloat = 1
        if(angleChange < 0)
        {
            angleSignChange = -1
        }
        let radialAngle = ang+angleSignChange*CGFloat(M_PI)/2
        let start : CGFloat = CGFloat(M_PI)*2-(CGFloat(M_PI)+radialAngle)
        let end : CGFloat = CGFloat(M_PI)*2-(CGFloat(M_PI)+radialAngle+angleChange)
        
        shape.addArc(withCenter: CGPoint(x: xE+(wid/2+ratio*wid)*cos(radialAngle), y: yE-(wid/2+ratio*wid)*sin(radialAngle)), radius: wid+ratio*wid, startAngle: start, endAngle: end, clockwise: angleChange<0)
        shape.addArc(withCenter: CGPoint(x: xE+(wid/2+ratio*wid)*cos(radialAngle), y: yE-(wid/2+ratio*wid)*sin(radialAngle)), radius: ratio*wid, startAngle: end, endAngle: start, clockwise: angleChange>0)
        shape.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shape.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 1
        view.layer.addSublayer(shapeLayer)
        
        let outAngle = ang+angleChange
        
        let outX = xE+(wid/2+ratio*wid)*(cos(radialAngle)-cos(radialAngle+angleChange))
        
        let outY = yE-(wid/2+ratio*wid)*(sin(radialAngle)-sin(radialAngle+angleChange))
        
        let width = wid/2
        
        drawRec(x1: xE-(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(width/2)*cos(ang * -1),
                y1: yE-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(width/2)*sin(ang * -1),
                x2: xE+(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(width/2)*cos(ang * -1),
                y2: yE+(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(width/2)*sin(ang * -1),
                x3: xE+(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(-1*width/2)*cos(ang * -1),
                y3: yE+(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(-1*width/2)*sin(ang * -1),
                x4: xE-(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(-1*width/2)*cos(ang * -1),
                y4: yE-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(-1*width/2)*sin(ang * -1),
                view: view)
        
        drawRec(x1: outX-(width*3/2)*cos(-CGFloat(M_PI/2)-outAngle)+(width/2)*cos(outAngle * -1),
                y1: outY-(width*3/2)*sin(-CGFloat(M_PI/2)-outAngle)+(width/2)*sin(outAngle * -1),
                x2: outX+(width*3/2)*cos(-CGFloat(M_PI/2)-outAngle)+(width/2)*cos(outAngle * -1),
                y2: outY+(width*3/2)*sin(-CGFloat(M_PI/2)-outAngle)+(width/2)*sin(outAngle * -1),
                x3: outX+(width*3/2)*cos(-CGFloat(M_PI/2)-outAngle)+(-1*width/2)*cos(outAngle * -1),
                y3: outY+(width*3/2)*sin(-CGFloat(M_PI/2)-outAngle)+(-1*width/2)*sin(outAngle * -1),
                x4: outX-(width*3/2)*cos(-CGFloat(M_PI/2)-outAngle)+(-1*width/2)*cos(outAngle * -1),
                y4: outY-(width*3/2)*sin(-CGFloat(M_PI/2)-outAngle)+(-1*width/2)*sin(outAngle * -1),
                view: view)
        
        return Edge(xE: outX, yE: outY, wid: wid, ang: outAngle)
        
        
        
    }
}
