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
		self.details = eventDetails.star
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
		
		let label = SCNLabel(text: name, scale: 0.075, align: alignment.center)
		label.position = SCNVector3(0,-0.5,0)
		self.addChildNode(label)
	}
	
	override func sight()
	{
		isSeen = true
		sprite.empty()
		sprite.add(_sprite())
	}
	
	override func _sprite() -> SCNNode
	{
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
		
		return spriteNode
	}
	
	override func collide()
	{
		print("death")
	}
	
	override func approachUpdate()
	{
		if distance/0.75 < 1 {
			let radiationPercent = 100 - ((distance/0.75) * 100)
			radiation.update((radiationPercent * radiationPercent)/100)
		}
		else{
			radiation.update(0)
		}
	}
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		var radius:Float = 2.75
		let distance:Float = 0
		
		var i = 0
		while i < 20 {
			radius -= 0.125
			
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius * 1.5,distance,0), nodeB: SCNVector3(radius,distance,-radius * 1.5), color: red))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius * 1.5,distance,0), nodeB: SCNVector3(radius,distance,radius * 1.5), color: red))
			
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius * 1.5,distance,0), nodeB: SCNVector3(-radius,distance,-radius * 1.5), color: red))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius * 1.5,distance,0), nodeB: SCNVector3(-radius,distance,radius * 1.5), color: red))
			
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,distance,-radius * 1.5), nodeB: SCNVector3(-radius,distance,-radius * 1.5), color: red))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,distance,radius * 1.5), nodeB: SCNVector3(-radius,distance,radius * 1.5), color: red))
			
			i++
		}
		
		return mesh
	}

	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}