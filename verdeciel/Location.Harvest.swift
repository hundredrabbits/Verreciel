import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationHarvest : Location
{
	var grows:Item!
	var port:SCNPortSlot!
	
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
		
		self.grows = grows
		
		port = SCNPortSlot(host: self, input:Item.self, output:Item.self, hasDetails:true)
		port.enable()
		
		NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("generate"), userInfo: nil, repeats: true)
	}
	
	func generate()
	{
		if port.event == nil {
			port.addEvent(grows)
		}
	}
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let line4 = SCNLabel(text: "Harvesting \(self.grows.name!)", align:.center)
		line4.position = SCNVector3(x: 0, y: 0.5, z: 0)
		newPanel.addChildNode(line4)
		
		newPanel.addChildNode(port)
		
		return newPanel
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}