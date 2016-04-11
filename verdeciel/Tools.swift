
//  Created by Devine Lu Linvega on 2016-02-12.
//  Copyright © 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit

func degToRad(degrees:CGFloat) -> CGFloat
{
	return degrees / 180 * CGFloat(M_PI)
}

func radToDeg(value:CGFloat) -> CGFloat
{
	return CGFloat(Double(value) * 180.0 / M_PI)
}

func distanceBetweenTwoPoints(point1:CGPoint,point2:CGPoint) -> CGFloat
{
	let xDist:CGFloat = (point2.x - point1.x)
	let yDist:CGFloat = (point2.y - point1.y)
	return sqrt((xDist * xDist) + (yDist * yDist))
}

func angleBetweenTwoPoints(point1:CGPoint,point2:CGPoint,center:CGPoint) -> CGFloat
{
	let v1 = CGVector(dx: point1.x - center.x, dy: point1.y - center.y)
	let v2 = CGVector(dx: point2.x - center.x, dy: point2.y - center.y)
	let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
	var deg = angle * CGFloat(180.0 / M_PI)
	if deg < 0 { deg += 360.0 }
	return deg
}

func delay(seconds: NSTimeInterval, block: dispatch_block_t)
{
	let time = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
	dispatch_after(time, dispatch_get_main_queue(), block)
}