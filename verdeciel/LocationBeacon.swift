import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationBeacon : Location
{
	var message:String = ""
	
	init(name:String,at: CGPoint = CGPoint(), message:String)
	{
		super.init(name:name, at:at)
		
		self.at = at
		self.size = 1
		self.note = ""
		self.message = message
		self.interaction = "> message"
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
		
		self.interface = panel()
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
	
	override func sight()
	{
		isKnown = true
		sprite.empty()
		sprite.add(_sprite())
	}
	
	override func _sprite() -> SCNNode
	{
		let size:Float = 0.05
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
		}
		
		return spriteNode
	}
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		return mesh
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}