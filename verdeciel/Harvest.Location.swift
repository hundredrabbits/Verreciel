import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationHarvest : Location
{
	var currency:Item!
	
	init(name:String = "",system:Systems,at:CGPoint = CGPoint(x: 0,y: 0), grows:Item)
	{
		super.init(name:name, system:system, at:at)
		
		self.name = name
		self.type = .waypoint
		self.system = system
		self.at = at
		self.note = ""
		self.mesh = structures.placeholder()
		icon.replace(icons.placeholder())
		
		currency = grows
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}