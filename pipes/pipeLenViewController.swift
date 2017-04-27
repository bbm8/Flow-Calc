//
//  pipeLenViewController.swift
//  pipes
//
//  Created by Vikram Mullick on 4/22/17.
//  Copyright © 2017 Vikram Mullick. All rights reserved.
//

import UIKit

class pipeLenViewController: UIViewController {
    
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var lengthField: UITextField!
    var mainCont: addPipeViewController = addPipeViewController()

    @IBOutlet weak var rootView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.layer.cornerRadius = 10

    
    }
    override func viewDidAppear(_ animated: Bool) {
        _ = drawPipe(xE: 10, yE: iconView.frame.height/2, wid: iconView.frame.height/4, len: iconView.frame.width-20, ang: 0, v: iconView)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exit(_ sender: Any) {
        lengthField.resignFirstResponder()
        self.dismiss(animated: true, completion: {});

    }
    @IBAction func resignKeyboard(_ sender: Any) {
        lengthField.resignFirstResponder()
    }
    func drawPipe(xE: CGFloat, yE: CGFloat, wid: CGFloat, len: CGFloat, ang: CGFloat, v: UIView) -> (Edge)
    {
        let length = len/2
        let width = wid/2
        
        let x1 = xE-cos(CGFloat(M_PI)/2-ang)*width
        let y1 = yE-sin(CGFloat(M_PI)/2-ang)*width
        
        let x2 = xE+cos(CGFloat(M_PI)/2-ang)*width
        let y2 = yE+sin(CGFloat(M_PI)/2-ang)*width
        
        let x = xE+len/2*cos(ang)
        let y = yE-len/2*sin(ang)
        
        drawRec(x1: x1,
                y1: y1,
                x2: x2,
                y2: y2,
                x3: x2+len*cos(ang),
                y3: y2-len*sin(ang),
                x4: x1+len*cos(ang),
                y4: y1-len*sin(ang),
                view: v)
        
        drawRec(x1: x-(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(length+width/2)*cos(ang * -1),
                y1: y-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(length+width/2)*sin(ang * -1),
                x2: x+(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(length+width/2)*cos(ang * -1),
                y2: y+(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(length+width/2)*sin(ang * -1),
                x3: x+(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(length-width/2)*cos(ang * -1),
                y3: y+(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(length-width/2)*sin(ang * -1),
                x4: x-(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(length-width/2)*cos(ang * -1),
                y4: y-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(length-width/2)*sin(ang * -1),
                view: v)
        
        drawRec(x1: x-(width*3/2)*cos(-CGFloat(M_PI/2)-ang)-(length+width/2)*cos(ang * -1),
                y1: y-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)-(length+width/2)*sin(ang * -1),
                x2: x+(width*3/2)*cos(-CGFloat(M_PI/2)-ang)-(length+width/2)*cos(ang * -1),
                y2: y+(width*3/2)*sin(-CGFloat(M_PI/2)-ang)-(length+width/2)*sin(ang * -1),
                x3: x+(width*3/2)*cos(-CGFloat(M_PI/2)-ang)-(length-width/2)*cos(ang * -1),
                y3: y+(width*3/2)*sin(-CGFloat(M_PI/2)-ang)-(length-width/2)*sin(ang * -1),
                x4: x-(width*3/2)*cos(-CGFloat(M_PI/2)-ang)-(length-width/2)*cos(ang * -1),
                y4: y-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)-(length-width/2)*sin(ang * -1),
                view: v)
        
        return Edge(xE: xE+len*cos(ang),
                    yE: yE-len*sin(ang),
                    wid: wid,
                    ang: ang)
        
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
    
    @IBAction func addPipe(_ sender: Any) {
        if let len : Double = Double(lengthField.text!)
        {
            if len == 0
            {
                lengthField.backgroundColor = UIColor.red
            }
            else
            {
                let w =  Int(mainCont.pipeScrollView.frame.width)/6
                let x = UIView()
                x.frame = CGRect(x: 5, y: 5+(w+5)*mainCont.pipes.count, width: w, height: w)
                x.layer.cornerRadius = 10
                x.backgroundColor = UIColor.white
                _ = drawPipe(xE: 10, yE: x.frame.height/2, wid: x.frame.height/4, len: x.frame.width-20, ang: 0, v: x)

                let y = UILabel()
                y.frame = CGRect(x: 10+w, y: 5+(w+5)*mainCont.pipes.count, width: Int(mainCont.pipeScrollView.frame.width)-2*w-20, height: w)
                y.backgroundColor = UIColor.init(red: 69/255.0, green: 174/255.0, blue: 245/255.0, alpha: 1)
                y.textColor = UIColor.white
                y.adjustsFontSizeToFitWidth = true
                y.textAlignment = .center
                y.text =  "length: " + String(len)
                
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

                mainCont.pipes.append(Straight(length: CGFloat(len)) as AnyObject)
                
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

                lengthField.resignFirstResponder()
                self.dismiss(animated: true, completion: {});
            }
        }
        else
        {
            lengthField.backgroundColor = UIColor.red
        }
    }
    
}
