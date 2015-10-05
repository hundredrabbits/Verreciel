import UIKit
import QuartzCore
import SceneKit
import Foundation

class eventStar : Event
{
	init(name:String,location: CGPoint, color:UIColor = red)
	{
		print(color)
		super.init(newName:name, location:location, type:eventTypes.star)
		
		print(color)
		self.location = location
		self.size = 1
		self.details = ""
		self.note = ""
		self.color = color
		print(color)
		print(self.color)
		
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
		print(self.color)
		let size:Float = 0.15
		let color = red
		print(color)
		
		let spriteNode = SCNNode()
		
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