import UIKit
import QuartzCore
import SceneKit
import Foundation

class eventPortal : Event
{
	let destination:CGPoint!
	let sector:sectors!
	let color:UIColor!
	
	init(location: CGPoint,destination: CGPoint,sector:sectors = sectors.normal,color:UIColor = white)
	{
		self.destination = destination
		self.sector = sector
		self.color = color
		
		super.init(newName:"portal", location:location, type:eventTypes.location)

		self.location = location
		self.size = 1
		self.details = ""
		self.note = ""
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
	}
	
	override func collide()
	{
		thruster.warp(self.destination, sector:self.sector)
	}
	
	override func createSprite() -> SCNNode
	{
		var size:Float = 0.15
		let color:UIColor = self.color
		
		let spriteNode = SCNNode()
		
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
		
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0.075,y:0,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:-0.075,y:0,z:0),color: color))
		
		size = 0.075
		
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
		
		return spriteNode
	}
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		let color:UIColor = self.color
		
		var i = 0
		while i < 4 {
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(-3,i,0), nodeB: SCNVector3(0,i,3), color: color))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,i,3), nodeB: SCNVector3(3,i,0), color: color))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(3,i,0), nodeB: SCNVector3(0,i,-3), color: color))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,i,-3), nodeB: SCNVector3(-3,i,0), color: color))
			i += 1
		}
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,0,-3), nodeB: SCNVector3(0,1,-3), color: color))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,0,3), nodeB: SCNVector3(0,1,3), color: color))
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(3,1,0), nodeB: SCNVector3(3,2,0), color: color))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-3,1,0), nodeB: SCNVector3(-3,2,0), color: color))
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,2,-3), nodeB: SCNVector3(0,3,-3), color: color))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,2,3), nodeB: SCNVector3(0,3,3), color: color))
		
		return mesh
	}
	
	
	override func spriteMode(toggle:Bool)
	{
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}