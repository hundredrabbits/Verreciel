import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationGate : Location
{
	var wantPort:SCNPort!
	var wantLabel:SCNLabel!
	var isLocked:Bool = false
	
	init(name:String = "",at: CGPoint = CGPoint(), want:Event)
	{
		super.init(name: name, at: at)
		
		self.at = at
		self.size = size
		self.note = ""
		
		wantPort = SCNPort(host: self)
		wantPort.addRequirement(want)
		wantLabel = SCNLabel(text: want.name!, color:white)
		
		self.interaction = "trading"
		
		self.interface = panel()
	}
	
	override func _sprite() -> SCNNode
	{
		let size:Float = 0.1
		var spriteColor:UIColor = grey
		
		let spriteNode = SCNNode()
		
		if isKnown == true { spriteColor = white }
		else if isSeen == true { spriteColor = cyan }
		
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: spriteColor))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: spriteColor))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: spriteColor))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: spriteColor))
		
		return spriteNode
	}
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 4
		let color:UIColor = red
		let sides:Int = 8
		let verticalOffset:Float = 5
		
		var i = 0
		while i < sides {
			let root = SCNNode()
			
			let counter:Float = 0
			root.addChildNode(SCNLine(nodeA: SCNVector3(-radius,verticalOffset + counter,0), nodeB: SCNVector3(0,verticalOffset + counter,radius), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,verticalOffset + counter,radius), nodeB: SCNVector3(radius,verticalOffset + counter,0), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(radius,verticalOffset + counter,0), nodeB: SCNVector3(0,verticalOffset + counter,-radius), color: color))
			root.addChildNode(SCNLine(nodeA: SCNVector3(0,verticalOffset + counter,-radius), nodeB: SCNVector3(-radius,verticalOffset + counter,0), color: color))
			
			let test = CGFloat(i * (360/sides/3))
			
			mesh.addChildNode(root)
			
			root.eulerAngles.y = Float(degToRad(test))
			i += 1
		}
		
		let aim = SCNNode()
		i = 0
		while i < 3
		{
			let test = SCNLine(nodeA: SCNVector3(0,verticalOffset/3,0.75), nodeB: SCNVector3(0,verticalOffset/3,0.85), color: white)
			test.eulerAngles.y = Float(degToRad(CGFloat(120 * i)))
			aim.addChildNode(test)
			i += 1
		}
		mesh.addChildNode(aim)
		
		return mesh
	}
	
	override func animateMesh(mesh:SCNNode)
	{
		mesh.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.25)))
	}
	
	// MARK: Panels -
	
	override func update()
	{
		wantLabel.update("--", color:grey)
		wantPort.disable()
	}
	
	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()

		wantPort.position = SCNVector3(x: -1.5, y: 0.3, z: 0)
		newPanel.addChildNode(wantPort)
		
		wantLabel.position = SCNVector3(x: -1.5 + 0.3, y: 0.3, z: 0)
		newPanel.addChildNode(wantLabel)
		
		return newPanel
	}
	
	override func listen(event: Event)
	{
		if wantPort.origin == nil { return }
		update()
	}
	
	override func bang()
	{
		print("gate test")
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}