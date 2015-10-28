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
	
	init(name:String,at: CGPoint = CGPoint(), item:Event!)
	{
		super.init(name:name, at:at)
		
		self.name = name
		self.at = at
		self.size = 1
		self.note = ""
		
		inventoryPort = SCNPort(host: self)
		inventoryPort.event = item
	}
	
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
	
	override func panel() -> Panel
	{
		let newPanel = Panel()
		
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
		
		if inventoryPort.event != nil && inventoryPort.event.size < 1 {
			inventoryPort.event = nil
		}
		
		if inventoryPort.event == nil {
			inventoryLabel.updateWithColor("Empty", color: grey)
			inventoryNote.updateWithColor("--", color: grey)
			isComplete = true
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}