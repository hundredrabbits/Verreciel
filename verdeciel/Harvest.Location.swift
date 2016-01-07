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
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let line4 = SCNLabel(text: "hello")
		line4.position = SCNVector3(x: 0, y: 0, z: 0)
		newPanel.addChildNode(line4)
		
		return newPanel
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}