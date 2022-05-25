//
//  ChartView.swift
//  Internship Dmytro Volokhovskyi
//
//  Created by Дмитро Волоховський on 08/04/2022.
//

import UIKit

class ChartView: UIView {

    var parameter : BodyParameterModel?
    var dataEntries : [ChartSegmentViewModel] = []
      
    let scrollView = UIScrollView()
    var changedValue : [Int] = [0]
    let mainLayer = CALayer()
    var maxValue : Int32 = 0
    var initialPosition : CGFloat = 35
    var height = 0
    var width :Int?
    let textHeight = 25
    var lineDrawn = false

    
    override init(frame : CGRect) {
          super.init(frame: frame)
      }

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
      
    func addScrollView(_ parameter : BodyParameterModel, _ height : Int) {
        addSubview(scrollView)
        self.height = height - 50
        formDataEntries(parameter)
        maxValue = parameter.values.max() ?? 0
        scrollView.layer.addSublayer(mainLayer)
        width = (dataEntries.count * 70 + Int(initialPosition))
        mainLayer.frame.size = CGSize(width: width ?? 200, height: height)
        mainLayer.backgroundColor = UIColor.clear.cgColor

        scrollView.contentSize = mainLayer.frame.size
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bounces = false
        scrollView.backgroundColor = .clear
        addSublayers()
    }
    
    func addSublayers() {
        for entry in dataEntries {
            mainLayer.addSublayer(createSegmentLayer(entry, initialPosition))
            initialPosition = initialPosition+70
        }
    }
    
    func formDataEntries(_ bodyParameterModel : BodyParameterModel) {
        let valuesArray = bodyParameterModel.values
        let datesArray = bodyParameterModel.dates
        maxValue = bodyParameterModel.values.max() ?? 1
        getChangedValueArray(valuesArray)
        var firstValue : Int32
        var secondValue : Int32
        var date : Date
        for entry in 0 ..< valuesArray.count {
            firstValue = valuesArray[entry]

            if valuesArray.indices.contains(entry) {
                secondValue = valuesArray[entry]
            }else {
                secondValue = firstValue
            }
            date = datesArray[entry]
                        let  newSegment = ChartSegmentViewModel(secondValue, firstValue, date, changedValue[entry])
                        dataEntries.append(newSegment)
        }
    }
    
    func createSegmentLayer(_ Segment : ChartSegmentViewModel, _ position : CGFloat)-> CALayer {
        
        let segmentLayer = CALayer ()
        let differenceLAyer = CATextLayer ()
        let segmentBarLayer = CALayer ()
        let valueLayer = CATextLayer ()
        let dateLayer = CATextLayer ()
        segmentLayer.frame = CGRect(x: Int(position), y: 0, width: 58, height: height)
        
        segmentLayer.addSublayer(differenceLAyer)
        //Date
        dateLayer.string = Segment.date
        dateLayer.fontSize = 16
        dateLayer.alignmentMode = .center
        segmentLayer.addSublayer(dateLayer)
        dateLayer.frame = CGRect(x: 0, y: height - 25, width: Int(segmentLayer.frame.width), height: textHeight)
        
        //bar
        let segmentYPosition = (height - calculateSizes(with: Segment.value) - 25 )
        segmentBarLayer.frame = CGRect(x: 0, y: segmentYPosition, width: Int(segmentLayer.frame.width), height: calculateSizes(with: Segment.value))
        segmentBarLayer.cornerRadius = 13
        segmentBarLayer.backgroundColor = UIColor.getCustomOrangeColor().cgColor
        if !lineDrawn {
            drawDottedLine(start: CGPoint(x: 0, y: segmentYPosition), end: CGPoint(x:width ?? 200 , y: segmentYPosition), true)
            drawDottedLine(start: CGPoint(x: 0, y: height - 25), end: CGPoint(x: width ?? 200, y: height - 25), false)
            lineDrawn = true
        }
        addAnimation(segmentBarLayer, CGRect(x: 0, y: segmentYPosition, width: Int(segmentLayer.frame.width), height: 0), CGRect(x: 0, y: segmentYPosition, width: Int(segmentLayer.frame.width), height: calculateSizes(with: Segment.value)))
        segmentLayer.addSublayer(segmentBarLayer)
        
        //DIf
        let differenceYposition = (height - calculateSizes(with: Segment.value) - 75)
        differenceLAyer.frame = CGRect(x: 0, y: differenceYposition, width: Int(segmentLayer.frame.width), height: textHeight)
        differenceLAyer.string = Segment.difference
        differenceLAyer.font = UIFont.getCustomFont(.SairaRomanMedium, 15)
        differenceLAyer.alignmentMode = .center
        differenceLAyer.fontSize = 14
        differenceLAyer.backgroundColor = Segment.backgroundColor.cgColor
        differenceLAyer.cornerRadius = 13
        differenceLAyer.preferredFrameSize()
        // ~val
        let valueYposition = (height - calculateSizes(with: Segment.value))
        valueLayer.frame = CGRect(x: 0, y: valueYposition - 50, width: Int(segmentLayer.frame.width), height: textHeight)
        valueLayer.string = "\(Segment.value)"
        valueLayer.font = UIFont.getCustomFont(.SairaRomanMedium, 15)
        valueLayer.alignmentMode = .center
        valueLayer.fontSize = 16
        valueLayer.backgroundColor = UIColor.clear.cgColor
        valueLayer.cornerRadius = 13
        valueLayer.preferredFrameSize()
        segmentLayer.addSublayer(valueLayer)
 
        return segmentLayer
    }
    func calculateSizes (with value: Int32 ) -> Int {
        var percent : Float?
        percent = (Float(maxValue) / 100)
        let percentsForBar = Float(value)/percent!
        let barHeight = Float(height/100) * percentsForBar
        return Int(barHeight - 25)
    }
    
    private  func drawDottedLine(start p0: CGPoint, end p1: CGPoint, _ isDotted : Bool) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        if isDotted{
            shapeLayer.lineDashPattern = [5, 3]
        } else {
        shapeLayer.lineDashPattern = [20, 0]
        }
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        mainLayer.addSublayer(shapeLayer)
    }
    private func addAnimation (_ layer : CALayer, _ from : CGRect, _ to : CGRect) {
        let boundsAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.bounds))
        boundsAnimation.fromValue = from
        boundsAnimation.toValue = to
        boundsAnimation.duration = 1
        
        layer.add(boundsAnimation, forKey: #keyPath(CALayer.bounds))
    }
    private func getChangedValueArray(_ valueArray : [Int32]) {
        var i = 0
        while i < valueArray.count - 1  {
            let first = valueArray[i+1]
            let second = valueArray[i]
            changedValue.append(Int((first - second)))
            i+=1
        }
    }
}
