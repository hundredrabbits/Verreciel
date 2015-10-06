import UIKit
import QuartzCore
import SceneKit
import Foundation

class eventStation : Event
{
	init(name:String = "",location: CGPoint = CGPoint(), size: Float = 1)
	{
		super.init(newName:name, location:location, type:eventTypes.station)
		
		self.location = location
		self.size = size
		self.details = ""
		self.note = ""
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
		self.addChildNode(trigger)
		
		self.interface = panel()
	}
	
	override func createSprite() -> SCNNode
	{
		var size:Float = 0.1
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
		}
		else{
			size = 0.05
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
		}
		
		return spriteNode
	}
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 4
		let distance:Float = 4
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius,distance,0), nodeB: SCNVector3(0,distance,radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,distance,radius), nodeB: SCNVector3(radius,distance,0), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,distance,0), nodeB: SCNVector3(0,distance,-radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,distance,-radius), nodeB: SCNVector3(-radius,distance,0), color: white))
		
		return mesh
	}
	
	override func panel() -> Panel
	{
		let newPanel = Panel()
		
		let test = SCNLabel(text: "test", scale: 0.1, align: alignment.left)
		newPanel.addChildNode(test)
		
		return newPanel
	}
	
	override func collide()
	{
		capsule.dock(self)
	}
	
	override func sight()
	{
		updateSprite()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}