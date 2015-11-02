import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStar : Location
{
	init(name:String,at: CGPoint = CGPoint(), color:UIColor = red)
	{
		super.init(name:name, at:at)
		
		self.at = at
		self.size = 1
		self.note = ""
		self.color = color
		self.mesh = structures.star
		self.details = itemTypes.star
		self.mesh = structures.star
	}
	
	override func _sprite() -> SCNNode
	{
		print("Seeing:\(isSeen)")
		let size:Float = 0.15
		
		let spriteNode = SCNNode()
		
		if isSeen == true {
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
		
		print("generated \(name!)")
		
		return spriteNode
	}
	
	override func collide()
	{
		print("death")
	}

	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}