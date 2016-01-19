import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationHoradric : Location
{
	var inPort1:SCNPortSlot!
	var inPort2:SCNPortSlot!
	var inPort3:SCNPortSlot!
	var inPort4:SCNPortSlot!
	
	var outPort:SCNPortSlot!
	
	override init(name:String = "", system:Systems, at: CGPoint = CGPoint())
	{
		super.init(name: name,system:system, at: at)
		
		self.name = name
		self.type = .horadric
		self.system = system
		self.at = at
		self.note = ""
		self.mesh = structures.horadric()
		icon.replace(icons.unseen())
	}
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		let distance:CGFloat = 0.5
		
		inPort1 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align: .center, hasDetails: false, placeholder: "-")
		inPort2 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align: .center, hasDetails: false, placeholder: "-")
		inPort3 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align: .left, hasDetails: false, placeholder: "-")
		inPort4 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align: .right, hasDetails: false, placeholder: "-")
		
		inPort1.label.position = SCNVector3(0,0.4,0)
		inPort2.label.position = SCNVector3(0,-0.4,0)
		inPort3.label.position = SCNVector3(0.4,0,0)
		inPort4.label.position = SCNVector3(-0.4,0,0)
		
		inPort1.label.activeScale = 0.08
		inPort2.label.activeScale = 0.08
		inPort3.label.activeScale = 0.08
		inPort4.label.activeScale = 0.08
		
		inPort1.enable()
		inPort2.enable()
		inPort3.enable()
		inPort4.enable()
		
		inPort1.position = SCNVector3(0,distance,0)
		inPort2.position = SCNVector3(0,-distance,0)
		inPort3.position = SCNVector3(distance,0,0)
		inPort4.position = SCNVector3(-distance,0,0)
		
		outPort = SCNPortSlot(host: self, input: Item.self, output: Event.self, placeholder: "")
		outPort.label.position = SCNVector3(0.5,0.5,0)
		outPort.label.activeScale = 0.08
		
		newPanel.addChildNode(inPort1)
		newPanel.addChildNode(inPort2)
		newPanel.addChildNode(inPort3)
		newPanel.addChildNode(inPort4)
		newPanel.addChildNode(outPort)
		
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0,0.125,0), nodeB: SCNVector3(0,distance - 0.125,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0,-0.125,0), nodeB: SCNVector3(0,-distance + 0.125,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0.125,0,0), nodeB: SCNVector3(distance - 0.125,0,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(-0.125,0,0), nodeB: SCNVector3(-distance + 0.125,0,0), color: grey))
		
		return newPanel
	}
	
	override func listen(event: Event)
	{
		
	}
	
	override func dockedUpdate()
	{
		verifyRecipes()
	}
	
	func verifyRecipes()
	{
		var ingredients:Array<Event> = []
		
		if inPort1.event != nil { ingredients.append(inPort1.event) }
		if inPort2.event != nil { ingredients.append(inPort2.event) }
		if inPort3.event != nil { ingredients.append(inPort3.event) }
		if inPort4.event != nil { ingredients.append(inPort4.event) }
		
		// Check for recipies
		for recipe in recipes.horadric {
			if recipe.isValid(ingredients) == true { combine(recipe) ; break }
		}
		
		// Delivery mode
		if outPort.event != nil {
			inPort1.disable()
			inPort2.disable()
			inPort3.disable()
			inPort4.disable()
			outPort.enable()
		}
		// Awaiting mode
		else{
			inPort1.enable()
			inPort2.enable()
			inPort3.enable()
			inPort4.enable()
			outPort.disable()
		}
	}
	
	// MARK: Combinatrix

	
	func combine(recipe:Recipe)
	{
		inPort1.removeEvent()
		inPort2.removeEvent()
		inPort3.removeEvent()
		inPort4.removeEvent()
		
		outPort.addEvent(recipe.result)
		outPort.enable()
	}

	func iconUpdate()
	{
		if isKnown == false {
			icon.replace(icons.trade(grey))
		}
		else {
			icon.replace(icons.trade(white))
		}
	}
	
	// MARK: Mesh -
	
	override func animateMesh(mesh:SCNNode)
	{
		for node in (mesh.childNodes.first?.childNodes)! {
			node.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.1)))
		}
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}