import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationBeacon : Location
{
	var message:String = ""
	
	init(name:String, system:Systems, at: CGPoint = CGPoint(), message:String, mapRequirement:Item! = nil)
	{
		super.init(name:name,system:system, at:at)
		
		self.mapRequirement = mapRequirement
		self.note = ""
		self.message = message
		structure = Structure(host:self)
		icon = IconBeacon()
	}
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let text1 = message.subString(0, length: 19)
		let text2 = message.subString(19, length: 19)
		let text3 = message.subString(38, length: 19)
		let text4 = message.subString(57, length: 19)
		
		let line1 = SCNLabel(text: text1)
		line1.position = SCNVector3(x: -1.5 + 0.3, y: 0.6, z: 0)
		newPanel.addChildNode(line1)
		
		let line2 = SCNLabel(text: text2)
		line2.position = SCNVector3(x: -1.5 + 0.3, y: 0.2, z: 0)
		newPanel.addChildNode(line2)
		
		let line3 = SCNLabel(text: text3)
		line3.position = SCNVector3(x: -1.5 + 0.3, y: -0.2, z: 0)
		newPanel.addChildNode(line3)
		
		let line4 = SCNLabel(text: text4)
		line4.position = SCNVector3(x: -1.5 + 0.3, y: -0.6, z: 0)
		newPanel.addChildNode(line4)
		
		return newPanel
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconBeacon : Icon
{
	override init()
	{
		super.init()
		
		addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: color))
		addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:-size,z:0),nodeB: SCNVector3(x:0,y:size,z:0),color: color))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}