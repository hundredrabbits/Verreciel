import UIKit
import QuartzCore
import SceneKit
import Foundation

class eventStation : Event
{
	init(name:String,location: CGPoint, size: Float)
	{
		super.init(newName:name, location:location, type:eventTypes.station)
		
		self.location = location
		self.size = size
		self.details = ""
		self.note = ""
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
	}
	
	override func createSprite() -> SCNNode
	{
		let size:Float = 0.15
		let color:UIColor = white
		
		let spriteNode = SCNNode()
		
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
		
//		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: color))
		
		return spriteNode
	}
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-3,0,0), nodeB: SCNVector3(0,0,3), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,0,3), nodeB: SCNVector3(3,0,0), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(3,0,0), nodeB: SCNVector3(0,0,-3), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,0,-3), nodeB: SCNVector3(-3,0,0), color: white))
		
		return mesh
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}