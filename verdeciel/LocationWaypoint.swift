import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationWaypoint : Location
{
	init(name:String = "",at:CGPoint = CGPoint(x: 0,y: 0))
	{
		super.init(name:name, at:at)
		
		self.at = at
		self.size = size
		self.note = ""
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
	}
	
	override func createSprite() -> SCNNode
	{
		var size:Float = 0.05
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
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-3,0,0), nodeB: SCNVector3(0,0,3), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,0,3), nodeB: SCNVector3(3,0,0), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(3,0,0), nodeB: SCNVector3(0,0,-3), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,0,-3), nodeB: SCNVector3(-3,0,0), color: white))
		
		return mesh
	}
	
	override func sight()
	{
		updateSprite()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}