import UIKit

protocol TRGraphViewDelegate: class {
    var graphPoints: [Int] { get }
}

@IBDesignable class TRGraphView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.redColor()
    @IBInspectable var endColor: UIColor = UIColor.greenColor()
    weak var delegate: TRGraphViewDelegate!
    
    override func drawRect(rect: CGRect) {
        let graphPoints = delegate.graphPoints
        let recWidth = rect.width
        let recHeight = rect.height
        let cgContext = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor, endColor.CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let cgGradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0, y: CGRectGetHeight(bounds))

        CGContextDrawLinearGradient(cgContext, cgGradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsBeforeStartLocation)
        
        let margin:CGFloat = 20.0
        let columnXPoint = { (column:Int) -> CGFloat in
            //Calculate gap between points
            let spacer = (recWidth - margin*2 - 4) /
                CGFloat((graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = recHeight - topBorder - bottomBorder
        let maxValue = graphPoints.maxElement()!
        let columnYPoint = { (graphPoint:Int) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) /
                CGFloat(maxValue) * graphHeight
            y = graphHeight + topBorder - y // Flip the graph
            return y
        }
        
        UIColor.whiteColor().setFill()
        UIColor.whiteColor().setStroke()
        
        //set up the points line
        let graphPath = UIBezierPath()
        //go to start of line
        graphPath.moveToPoint(CGPoint(x:columnXPoint(0),
            y:columnYPoint(graphPoints[0])))
        
        //add points for each item in the graphPoints array
        //at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x:columnXPoint(i),
                y:columnYPoint(graphPoints[i]))
            graphPath.addLineToPoint(nextPoint)
        }
        
        //Create the clipping path for the graph gradient
        
        //1 - save the state of the context
        CGContextSaveGState(cgContext)
        
        //2 - make a copy of the path
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        //3 - add lines to the copied path to complete the clip area
        clippingPath.addLineToPoint(CGPoint(
            x: columnXPoint(graphPoints.count - 1),
            y:recHeight))
        clippingPath.addLineToPoint(CGPoint(
            x:columnXPoint(0),
            y:recHeight))
        clippingPath.closePath()
        
        //4 - add the clipping path to the context
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        startPoint = CGPoint(x:margin, y: highestYPoint)
        endPoint = CGPoint(x:margin, y:bounds.height)
        
        CGContextDrawLinearGradient(cgContext, cgGradient, startPoint, endPoint, CGGradientDrawingOptions.DrawsBeforeStartLocation)
        
        //draw the line on top of the clipped gradient
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        CGContextRestoreGState(cgContext)
        
        //draw circles
        for i in 0..<graphPoints.count {
            let point = CGPoint(x: columnXPoint(i) - 2.5, y: columnYPoint(graphPoints[i]) - 2.5)
            let circle = UIBezierPath(ovalInRect: CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        //Draw horizontal graph lines on the top of everything
        let linePath = UIBezierPath()
        
        //top line
        linePath.moveToPoint(CGPoint(x:margin, y: topBorder))
        linePath.addLineToPoint(CGPoint(x: recWidth - margin,
            y:topBorder))
        
        //center line
        linePath.moveToPoint(CGPoint(x:margin,
            y: graphHeight/2 + topBorder))
        linePath.addLineToPoint(CGPoint(x:recWidth - margin,
            y:graphHeight/2 + topBorder))
        
        //bottom line
        linePath.moveToPoint(CGPoint(x:margin,
            y:recHeight - bottomBorder))
        linePath.addLineToPoint(CGPoint(x:recWidth - margin,
            y:recHeight - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
    }
}