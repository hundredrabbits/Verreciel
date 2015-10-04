import UIKit
import QuartzCore
import SceneKit
import Foundation

class eventBeacon : Event
{
	
	init(name:String,location: CGPoint)
	{
		super.init(newName:name, location:location, type:eventTypes.beacon)
		
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
	}
	
	override func createSprite() -> SCNNode
	{
		let size:Float = 0.1
		let color:UIColor = grey
		
		let spriteNode = SCNNode()
		
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: color))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
		
		return spriteNode
	}
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		
		return mesh
	}
	
	
	override func spriteMode(toggle:Bool)
	{
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}