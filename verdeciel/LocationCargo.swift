import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationCargo : Location
{
	var inventoryPort:SCNPort!
	var inventoryLabel:SCNLabel!
	var item:Event!
	
	init(name:String,at: CGPoint = CGPoint(), item: Event = Event(type: eventTypes.item))
	{
		super.init(name:name, at:at)
		
		self.name = name
		self.at = at
		self.size = 1
		self.note = ""
		
		self.item = item
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
	}
	
	override func _sprite() -> SCNNode
	{
		var size:Float = 0.15
		let color:UIColor = grey
		
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
			
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size/2,y:size/2,z:0),nodeB: SCNVector3(x:-size/2,y:-size/2,z:0),color: color))
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
	
	override func approach()
	{
		space.startInstance(self)
		capsule.dock(self)
	}
	
	// MARK: Panel
	
	override func panel() -> Panel
	{
		let newPanel = Panel()
		
		inventoryLabel = SCNLabel(text: (item.name!))
		inventoryLabel.position = SCNVector3(x: templates.leftMargin, y: 0, z: 0)
		newPanel.addChildNode(inventoryLabel)
		
		inventoryPort = SCNPort(host: self)
		inventoryPort.position = SCNVector3(x: templates.rightMargin, y: 0, z: 0)
		inventoryPort.enable()
		newPanel.addChildNode(inventoryPort)
		
		return newPanel
	}
	
	override func bang()
	{
		if inventoryPort.connection.host == cargo {
			if cargo.cargohold.content.count < 6 {
				cargo.uploadItem(item)
				self.item = nil
				
				inventoryPort.disable()
				inventoryLabel.updateWithColor("--", color: grey)
			}
			else{
				print("Cargo is full")
			}
		}
		else{
			print("Unsupported route")
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}