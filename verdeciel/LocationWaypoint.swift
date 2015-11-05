import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationWaypoint : Location
{
	init(name:String = "",at:CGPoint = CGPoint(x: 0,y: 0))
	{
		super.init(name:name, at:at)
		
		self.at = at
		self.size = size
		self.note = ""
		self.mesh = structures.placeholder()
		icon.replace(icons.placeholder())
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}