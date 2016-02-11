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
		
		port = SCNPortSlot(host: self, input:Item.self, output:Item.self, hasDetails:true, align:.center)
		port.position = SCNVector3(0,-0.5,0)
		port.enable()
		
		NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("generate"), userInfo: nil, repeats: true)
	}
	
	func generate()
	{
		if port.event == nil {
			port.addEvent(grows)
		}
	}
	
	var progress:SCNProgressBar!
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let text = SCNLabel(text: "\(self.grows.name!) production$Time Left 543", align:.left)
		text.position = SCNVector3(-1.5,1,0)
		newPanel.addChildNode(text)
		
		progress = SCNProgressBar(width: 3)
		progress.position = SCNVector3(-1.5,0,0)
		progress.update(30)
		
		newPanel.addChildNode(progress)
		newPanel.addChildNode(port)
		
		return newPanel
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}