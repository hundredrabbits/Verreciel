import UIKit
import QuartzCore
import SceneKit
import Foundation

class eventStar : Event
{
	init(name:String,location: CGPoint, color:UIColor = red)
	{
		super.init(newName:name, location:location, type:eventTypes.star)
		
		self.location = location
		self.size = 1
		self.details = ""
		self.note = ""
		self.color = color
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
		
		let label = SCNLabel(text: name, scale: 0.075, align: alignment.center)
		label.position = SCNVector3(0,-0.5,0)
		self.addChildNode(label)
	}
	
	override func createSprite() -> SCNNode
	{
		let size:Float = 0.15
		
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
			
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:size * 2,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:-size * 2,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:0,y:size * 2,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:-size,z:0),nodeB: SCNVector3(x:0,y:-size * 2,z:0),color: color))
			
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size/2,y:size/2,z:0),nodeB: SCNVector3(x:size,y:size,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size/2,y:size/2,z:0),nodeB: SCNVector3(x:-size,y:size,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size/2,y:-size/2,z:0),nodeB: SCNVector3(x:size,y:-size,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size/2,y:-size/2,z:0),nodeB: SCNVector3(x:-size,y:-size,z:0),color: color))
		}
		else{
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: grey))
		}
		
		return spriteNode
	}
	
	override func sight()
	{
		updateSprite()
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