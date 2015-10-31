import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationCargo : Location
{
	var inventoryPort:SCNPort!
	var inventoryLabel:SCNLabel!
	var inventoryNote:SCNLabel!
	var locationLabel:SCNLabel!
	
	init(name:String,at: CGPoint = CGPoint(), item:Event!, isRadioQuest:Bool = false)
	{
		super.init(name:name, at:at)
		
		self.name = name
		self.at = at
		self.size = 1
		self.note = ""
		self.isRadioQuest = isRadioQuest
		
		inventoryPort = SCNPort(host: self)
		inventoryPort.event = item
	}
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		let color:UIColor = cyan
		let sides:Int = 90
		let verticalOffset:Float = 4
		
		var i = 0
		while i < sides {
			let line = SCNLine(nodeA: SCNVector3(-0.75,-0.25,2.25), nodeB: SCNVector3(1,0.25,-2), color: color)
			line.position = SCNVector3(0,verticalOffset,2.25)
			let root = SCNNode()
			root.eulerAngles.y = Float(degToRad(CGFloat(i * (360/sides))))
			root.addChildNode(line)
			
			mesh.addChildNode(root)
			i += 1
		}
		
		let aim = SCNNode()
		i = 0
		while i < 3
		{
			let test = SCNLine(nodeA: SCNVector3(0,verticalOffset * 2,0.75), nodeB: SCNVector3(0,verticalOffset * 2,0.85), color: white)
			test.eulerAngles.y = Float(degToRad(CGFloat(120 * i)))
			aim.addChildNode(test)
			i += 1
		}
		mesh.addChildNode(aim)
		
		return mesh
	}
	
	override func animateMesh(mesh:SCNNode)
	{
		mesh.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.125)))
		for node in mesh.childNodes {
			for line in node.childNodes {
//				line.eulerAngles.z = Float(degToRad(CGFloat(time.elapsed * 2)))
			}
		}
	}
	
	/*
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		let color:UIColor = cyan
		let sides:Int = 45
		let verticalOffset:Float = 4
		
		var i = 0
		while i < sides {
			let line = SCNLine(nodeA: SCNVector3(-0.75,-0.25,1), nodeB: SCNVector3(0.75,0.25,-1), color: color)
			line.position = SCNVector3(0,verticalOffset,2)
			let root = SCNNode()
			root.eulerAngles.y = Float(degToRad(CGFloat(i * (360/sides))))
			root.addChildNode(line)
			
			mesh.addChildNode(root)
			i += 1
		}
		
		return mesh
	}
	
	override func animateMesh(mesh:SCNNode)
	{
		mesh.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.125)))
		for node in mesh.childNodes {
			for line in node.childNodes {
				line.eulerAngles.z = Float(degToRad(CGFloat(time.elapsed * 2)))
			}
		}
	}
	
	*/
	override func _sprite() -> SCNNode
	{
		print("* LOCATION | Updated sprite for \(name!)")
		
		let size:Float = 0.05
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
	
	// MARK: Panel
	
	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()
		
		locationLabel = SCNLabel(text: note)
		locationLabel.position = SCNVector3(templates.leftMargin,templates.topMargin - 0.25,0)
		newPanel.addChildNode(locationLabel)
		
		// Interface
		
		let nodeFrame = SCNNode()
		nodeFrame.position = SCNVector3(templates.leftMargin + 0.3,-0.4,0)
		
		inventoryPort.position = SCNVector3(x: 0, y: 0, z: 0)
		inventoryPort.enable()
		nodeFrame.addChildNode(inventoryPort)
		
		inventoryLabel = SCNLabel(text: inventoryPort.event.name!)
		inventoryLabel.position = SCNVector3(x: 0.5, y: 0, z: 0)
		nodeFrame.addChildNode(inventoryLabel)
		
		inventoryNote = SCNLabel(text: inventoryPort.event.note, scale:0.08, color:grey)
		inventoryNote.position = SCNVector3(x: 0.5, y: -0.4, z: 0)
		nodeFrame.addChildNode(inventoryNote)
		
		newPanel.addChildNode(nodeFrame)
		
		return newPanel
	}
	
	override func bang()
	{
		if inventoryPort.connection == nil { print("Missing connection") ; return }
		
		if inventoryPort.event != nil {
			inventoryPort.connection.host.listen(inventoryPort.event)
		}
		update()
	}
	
	override func update()
	{
		if inventoryPort.event != nil && inventoryPort.event.size < 1 {
			inventoryPort.event = nil
		}
		
		if inventoryPort.event == nil {
			inventoryLabel.update("Empty", color: grey)
			inventoryNote.update("--", color: grey)
			isComplete = true
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}