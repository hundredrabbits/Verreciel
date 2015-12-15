import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationBeacon : Location
{
	var message:String = ""
	
	init(name:String, system:Systems, at: CGPoint = CGPoint(), message:String)
	{
		super.init(name:name, at:at)
		
		self.name = name
		self.system = system
		self.at = at
		self.note = ""
		self.message = message
		self.mesh = structures.beacon()
		icon.replace(icons.placeholder())
	}
	
	override func panel() -> Panel
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