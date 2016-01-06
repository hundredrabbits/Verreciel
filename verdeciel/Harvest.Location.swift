import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationHarvest : Location
{
	override init(name:String = "",system:Systems,at:CGPoint = CGPoint(x: 0,y: 0))
	{
		super.init(name:name, system:system, at:at)
		
		self.name = name
		self.type = .waypoint
		self.system = system
		self.at = at
		self.note = ""
		self.mesh = structures.placeholder()
		icon.replace(icons.placeholder())
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}