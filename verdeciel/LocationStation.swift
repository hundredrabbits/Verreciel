import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStation : Location
{
	init(name:String = "",at: CGPoint = CGPoint(), size: Float = 1)
	{
		super.init(name:name, at:at)
		
		self.at = at
		self.size = size
		self.note = ""
		
		self.interface = panel()
	}
	
	override func _sprite() -> SCNNode
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
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}