import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationHoradric : Location
{
	var inPort1:SCNPort!
	var inPort2:SCNPort!
	var inPort3:SCNPort!
	var inPort4:SCNPort!
	
	var outPort:SCNPort!
	var outLabel:SCNLabel!
	
	init(name:String = "",at: CGPoint = CGPoint())
	{
		super.init(name: name, at: at)
		
		self.at = at
		self.size = size
		self.note = ""
		
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
	
	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()
		let distance:CGFloat = 0.65
		
		inPort1 = SCNPort(host: self, input: eventTypes.item, output: eventTypes.none)
		inPort2 = SCNPort(host: self, input: eventTypes.item, output: eventTypes.none)
		inPort3 = SCNPort(host: self, input: eventTypes.item, output: eventTypes.none)
		inPort4 = SCNPort(host: self, input: eventTypes.item, output: eventTypes.none)
		
		inPort1.enable()
		inPort2.enable()
		inPort3.enable()
		inPort4.enable()
		
		inPort1.position = SCNVector3(0,distance,0)
		inPort2.position = SCNVector3(0,-distance,0)
		inPort3.position = SCNVector3(distance,0,0)
		inPort4.position = SCNVector3(-distance,0,0)
		
		outPort = SCNPort(host: self, input: eventTypes.item, output: eventTypes.generic)
		
		newPanel.addChildNode(inPort1)
		newPanel.addChildNode(inPort2)
		newPanel.addChildNode(inPort3)
		newPanel.addChildNode(inPort4)
		newPanel.addChildNode(outPort)
		
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0,0.125,0), nodeB: SCNVector3(0,distance - 0.125,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0,-0.125,0), nodeB: SCNVector3(0,-distance + 0.125,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0.125,0,0), nodeB: SCNVector3(distance - 0.125,0,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(-0.125,0,0), nodeB: SCNVector3(-distance + 0.125,0,0), color: grey))
		
		label = SCNLabel(text: "--", scale: 0.1, align: alignment.center, color: grey)
		label.position = SCNVector3(0,1.2,0)
		newPanel.addChildNode(label)
		
		return newPanel
	}
	
	override func listen(event: Event)
	{
		var ingredients:Array<Event> = []
		
		if inPort1.origin != nil && inPort1.origin.event != nil { ingredients.append(inPort1.origin.event) }
		if inPort2.origin != nil && inPort2.origin.event != nil { ingredients.append(inPort2.origin.event) }
		if inPort3.origin != nil && inPort3.origin.event != nil { ingredients.append(inPort3.origin.event) }
		if inPort4.origin != nil && inPort4.origin.event != nil { ingredients.append(inPort4.origin.event) }
		
		if ingredients.count < 2 { label.update("incompatible", color: grey) ; return }
		
		// Check for recipies
		
		for recipe in recipes.horadric {
			if recipe.isValid(ingredients) == true {
				label.update(recipe.name, color: white)
				outPort.event = recipe.result
				outPort.enable()
			}
		}
	}
	
	override func bang()
	{
		if outPort.connection == nil { print("No connection") ; return }
		if outPort.event == nil { return }
		
		outPort.connection.host.listen(outPort.event)
		completeTrade()
	}
	
	func completeTrade()
	{
		if inPort1.origin != nil { inPort1.syphon() }
		if inPort2.origin != nil { inPort2.syphon() }
		if inPort3.origin != nil { inPort3.syphon() }
		if inPort4.origin != nil { inPort4.syphon() }
		
		cargo.bang()
		outPort.event = nil
		label.update("--", color: grey)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}