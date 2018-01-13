//
//  ViewController.swift
//  pipes
//
//  Created by Vikram Mullick on 3/20/17.
//  Copyright © 2017 Vikram Mullick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appNameLabel: UILabel!
    
    var xMin = CGFloat()
    var xMax = CGFloat()
    var yMin = CGFloat()
    var yMax = CGFloat()
    
    var equivalentLength : CGFloat = 0
    
    @IBOutlet weak var pipeView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var calcButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    var pipeID : CGFloat = 0
    var width : CGFloat = 0
    
    var pipes = [AnyObject]()
    var iconViews = [UIView]()
    var labels = [UIButton]()
    var buttons = [UIButton]()
    
    var sizeIndex : Int = 0
    var scheduleIndex : Int = 0
    var sizeText = "select size"
    var scheduleText = "select schedule"
    
    var flow = true
    var inlet = false
    var outlet = false
    var chosenGas = "select gas"
    var answerText = "Flow Rate"
    var gasIndex = 0
    var tempText = ""
    var fieldOneText = ""
    var fieldTwoText = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pipeView.layer.cornerRadius = 10
        
        appNameLabel.adjustsFontSizeToFitWidth = true
        
        self.addButton.backgroundColor = UIColor.black
        self.addButton.layer.cornerRadius = self.addButton.frame.width/2
        
        self.calcButton.layer.cornerRadius = self.calcButton.frame.width/2
        
        self.calcButton.clipsToBounds = true
       
        clearButton.layer.cornerRadius = 10
        
        clearButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        clearButton.titleLabel?.textColor = UIColor(red: (clearButton.titleLabel?.textColor.cgColor.components?[0])!, green: (clearButton.titleLabel?.textColor.cgColor.components?[1])!, blue: (clearButton.titleLabel?.textColor.cgColor.components?[2])!, alpha: 0.5)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination : addPipeViewController = segue.destination as? addPipeViewController
        {
            destination.width = self.width
            destination.pipes = self.pipes
            destination.labels = self.labels
            destination.iconViews = self.iconViews
            destination.buttons = self.buttons

            destination.homeController = self
            
            destination.scheduleText = scheduleText
            destination.sizeText = sizeText

            destination.sizeIndex = sizeIndex
            destination.scheduleIndex = scheduleIndex
        }
        if let destination : calcViewController = segue.destination as? calcViewController
        {
            destination.mainCont = self
            destination.length = equivalentLength
            destination.ID = pipeID
            destination.flow = flow
            destination.inlet = inlet
            destination.outlet = outlet
            destination.chosenGas = chosenGas
            destination.gasIndex = gasIndex
            destination.tempText = tempText
            destination.fieldOneText = fieldOneText
            destination.fieldTwoText = fieldTwoText
            destination.answerText = answerText
        }
    }
  
    func drawPipes()
    {
        pipeView.layer.sublayers = nil

        pipeID = CGFloat(data.pipeIDs[sizeIndex][scheduleIndex])
        
        equivalentLength = 0
        
        for p in pipes
        {
            var addition : CGFloat = 0
            if let pipe = p as? Straight
            {
                addition = CGFloat(pipe.length)
            }
            if let pipe = p as? Curve
            {
                if pipe.ratio == 0.5
                {
                    addition = CGFloat(data.equivLengths[sizeIndex][1])
                }
                else
                {
                    if pipe.angleChange == CGFloat(M_PI/2)
                    {
                        addition = CGFloat(data.equivLengths[sizeIndex][2])
                    }
                    else
                    {
                        addition = CGFloat(data.equivLengths[sizeIndex][0])

                    }
                }
            }
            equivalentLength = equivalentLength + addition
        }
        
        let max = data.pipeWidths[data.pipeWidths.count-1]
        let min = data.pipeWidths[0]
        let top = data.pipeWidths[sizeIndex]-min
        
        width = equivalentLength/48+equivalentLength/48*CGFloat((top)/(max-min))
        
      

        if pipes.count > 0
        {
            generatePipes()
        }
        self.pipeView.addSubview(clearButton)


    }
    func generatePipes()
    {
        xMin = pipeView.frame.width/2-width*2
        xMax = pipeView.frame.width/2+width*2
        yMin = pipeView.frame.height/2-width*2
        yMax = pipeView.frame.height/2+width*2
        
        var starting = Edge(xE: self.pipeView.frame.width/2, yE: self.pipeView.frame.height/2, wid: width, ang: CGFloat(M_PI/2))
        for p in pipes
        {
            if let pipe = p as? Straight
            {
                starting = Edge(xE: starting.xE+pipe.length*cos(starting.ang),
                                yE: starting.yE-pipe.length*sin(starting.ang),
                                wid: starting.wid,
                                ang: starting.ang)
                process(edge: starting)
                
            }
            if let pipe = p as? Curve
            {
                var angleSignChange : CGFloat = 1
                if(pipe.angleChange < 0)
                {
                    angleSignChange = -1
                }
                let radialAngle = starting.ang+angleSignChange*CGFloat(M_PI)/2
                let outAngle = starting.ang+pipe.angleChange
                let outX = starting.xE+(starting.wid/2+pipe.ratio*starting.wid)*(cos(radialAngle)-cos(radialAngle+pipe.angleChange))
                let outY = starting.yE-(starting.wid/2+pipe.ratio*starting.wid)*(sin(radialAngle)-sin(radialAngle+pipe.angleChange))
                starting = Edge(xE: outX, yE: outY, wid: starting.wid, ang: outAngle)
                process(edge: starting)
            }
        }
        var factor = self.pipeView.frame.width/(xMax-xMin)
        if (self.pipeView.frame.height/(yMax-yMin)) < factor
        {
            factor = self.pipeView.frame.height/(yMax-yMin)
        }
        starting = Edge(xE: self.pipeView.frame.width/2, yE: self.pipeView.frame.height/2, wid: starting.wid*(factor), ang: CGFloat(M_PI/2))
        for p in pipes
        {
            if let pipe = p as? Straight
            {
                starting = drawPipe(xE: starting.xE, yE: starting.yE, wid: starting.wid, len: pipe.length*factor, ang: starting.ang)
            }
            if let pipe = p as? Curve
            {
                starting = drawArc(xE: starting.xE, yE: starting.yE, wid: starting.wid, ang: starting.ang, ratio: pipe.ratio, angleChange: pipe.angleChange)
            }
        }
        
        
        let midX = (self.pipeView.frame.width/2-(xMax+xMin)/2)*factor
        let midY = (self.pipeView.frame.height/2-(yMax+yMin)/2)*factor
        
        
        for layer in (pipeView.layer.sublayers)!
        {
            layer.position = CGPoint(x: layer.position.x+midX,y: layer.position.y+midY)
        }
    }
    func drawPipe(xE: CGFloat, yE: CGFloat, wid: CGFloat, len: CGFloat, ang: CGFloat) -> (Edge)
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
                y4: y1-len*sin(ang))

        drawRec(x1: x-(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(length+width/2)*cos(ang * -1),
                y1: y-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(length+width/2)*sin(ang * -1),
                x2: x+(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(length+width/2)*cos(ang * -1),
                y2: y+(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(length+width/2)*sin(ang * -1),
                x3: x+(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(length-width/2)*cos(ang * -1),
                y3: y+(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(length-width/2)*sin(ang * -1),
                x4: x-(width*3/2)*cos(-CGFloat(M_PI/2)-ang)+(length-width/2)*cos(ang * -1),
                y4: y-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(length-width/2)*sin(ang * -1))

        drawRec(x1: x-(width*3/2)*cos(-CGFloat(M_PI/2)-ang)-(length+width/2)*cos(ang * -1),
                y1: y-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)-(length+width/2)*sin(ang * -1),
                x2: x+(width*3/2)*cos(-CGFloat(M_PI/2)-ang)-(length+width/2)*cos(ang * -1),
                y2: y+(width*3/2)*sin(-CGFloat(M_PI/2)-ang)-(length+width/2)*sin(ang * -1),
                x3: x+(width*3/2)*cos(-CGFloat(M_PI/2)-ang)-(length-width/2)*cos(ang * -1),
                y3: y+(width*3/2)*sin(-CGFloat(M_PI/2)-ang)-(length-width/2)*sin(ang * -1),
                x4: x-(width*3/2)*cos(-CGFloat(M_PI/2)-ang)-(length-width/2)*cos(ang * -1),
                y4: y-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)-(length-width/2)*sin(ang * -1))
        
        return Edge(xE: xE+len*cos(ang),
                yE: yE-len*sin(ang),
                wid: wid,
                ang: ang)
        
    }
    func drawArc(xE: CGFloat, yE: CGFloat, wid: CGFloat, ang: CGFloat, ratio: CGFloat, angleChange: CGFloat) -> (Edge)

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
        pipeView.layer.addSublayer(shapeLayer)
        
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
                y4: yE-(width*3/2)*sin(-CGFloat(M_PI/2)-ang)+(-1*width/2)*sin(ang * -1))
        
        drawRec(x1: outX-(width*3/2)*cos(-CGFloat(M_PI/2)-outAngle)+(width/2)*cos(outAngle * -1),
                y1: outY-(width*3/2)*sin(-CGFloat(M_PI/2)-outAngle)+(width/2)*sin(outAngle * -1),
                x2: outX+(width*3/2)*cos(-CGFloat(M_PI/2)-outAngle)+(width/2)*cos(outAngle * -1),
                y2: outY+(width*3/2)*sin(-CGFloat(M_PI/2)-outAngle)+(width/2)*sin(outAngle * -1),
                x3: outX+(width*3/2)*cos(-CGFloat(M_PI/2)-outAngle)+(-1*width/2)*cos(outAngle * -1),
                y3: outY+(width*3/2)*sin(-CGFloat(M_PI/2)-outAngle)+(-1*width/2)*sin(outAngle * -1),
                x4: outX-(width*3/2)*cos(-CGFloat(M_PI/2)-outAngle)+(-1*width/2)*cos(outAngle * -1),
                y4: outY-(width*3/2)*sin(-CGFloat(M_PI/2)-outAngle)+(-1*width/2)*sin(outAngle * -1))
        
        return Edge(xE: outX, yE: outY, wid: wid, ang: outAngle)
        
       
        
    }
    func process(edge : Edge)
    {
        let width = edge.wid*2
        let x = edge.xE
        let y = edge.yE
        
        if (x-width) < xMin
        {
            xMin = x-width
        }
        if (x+width) > xMax
        {
            xMax = x+width
        }
        if (y-width) < yMin
        {
            yMin = y-width
        }
        if (y+width) > yMax
        {
            yMax = y+width
        }

    }
    func drawRec(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat,x3: CGFloat, y3: CGFloat, x4: CGFloat, y4: CGFloat)
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
        pipeView.layer.addSublayer(shapeLayer)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearAll(_ sender: Any){
        pipeID = 0
        width = 0
        equivalentLength = 0
        pipes = [AnyObject]()
        iconViews = [UIView]()
        labels = [UIButton]()
        buttons = [UIButton]()
        sizeIndex = 0
        scheduleIndex = 0
        sizeText = "select size"
        scheduleText = "select schedule"
        pipeView.layer.sublayers = nil
        flow = true
        inlet = false
        outlet = false
        chosenGas = "select gas"
        answerText = "Flow Rate"
        gasIndex = 0
        tempText = ""
        fieldOneText = ""
        fieldTwoText = ""
        self.pipeView.addSubview(clearButton)
    }
    
    

}

struct Straight
{
    var length : CGFloat
}
struct Curve
{
    var ratio : CGFloat
    var angleChange : CGFloat
}
struct Edge
{
    var xE : CGFloat
    var yE : CGFloat
    var wid : CGFloat
    var ang : CGFloat
    
}
