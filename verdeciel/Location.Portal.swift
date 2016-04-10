import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationPortal : Location
{
	var keyLabel:SCNLabel!
	var destinationLabel:SCNLabel!
	var pilotPort:SCNPort!
	var pilotLabel:SCNLabel!
	var thrusterPort:SCNPort!
	var thrusterLabel:SCNLabel!

	override init(name:String, system:Systems, at: CGPoint)
	{
		super.init(name:name,system:system, at:at)
		
		keyLabel = SCNLabel(text: "input key", scale: 0.1, align: .center, color: white)
		destinationLabel = SCNLabel(text: "--", scale: 0.08, align: .center, color: grey)
		pilotPort = SCNPort(host: self)
		pilotLabel = SCNLabel(text: "pilot", scale: 0.1, align: .center, color: grey)
		thrusterPort = SCNPort(host: self)
		thrusterLabel = SCNLabel(text: "thruster", scale: 0.08, align: .center, color: grey)
		
		self.note = ""
		self.color = color
		structure = StructureDefault()
		icon.replace(icons.portal())
	}
	
	// MARK: Panel - 
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		pilotPort.addChildNode(pilotLabel)
		thrusterPort.addChildNode(thrusterLabel)
		
		newPanel.addChildNode(keyLabel)
		newPanel.addChildNode(pilotPort)
		newPanel.addChildNode(thrusterPort)
		
		keyLabel.position = SCNVector3(0,0.75,0)
		keyLabel.addChildNode(destinationLabel)
		destinationLabel.position = SCNVector3(0,-0.4,0)
		
		pilotPort.position = SCNVector3(0.8,-0.4,0)
		pilotLabel.position = SCNVector3(0,-0.4,0)
		
		thrusterPort.position = SCNVector3(-0.8,-0.4,0)
		thrusterLabel.position = SCNVector3(0,-0.4,0)
		
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0.8,-0.275,0), nodeB: SCNVector3(0.8,-0.1,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(-0.8,-0.275,0), nodeB: SCNVector3(-0.8,-0.1,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0.8,-0.1,0), nodeB: SCNVector3(-0.8,-0.1,0), color: grey))
		
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0,0.1,0), nodeB: SCNVector3(0,-0.1,0), color: grey))
		
		thrusterPort.addEvent(items.warpDrive)
		
		return newPanel
	}
	
	override func onConnect()
	{
		validate()
	}
	
	override func onDisconnect()
	{
		validate()
	}
	
	override func onDock()
	{
		validate()
	}
	
	func validate()
	{
		if intercom.port.isReceivingItemOfType(.key) == true { unlock() }
		else{ lock() }
	}
	
	func lock()
	{
		pilotPort.removeEvent()
		pilotPort.disable()
		thrusterPort.disable()
		keyLabel.update("no key", color:red)
		
		structure.updateChildrenColors(red)
	}
	
	func unlock()
	{
		let key = intercom.port.origin.event as! Item
		let destination = universe.locationLike(key.location)
		
		print("! KEY      | Reading: \(key.name!) -> \(destination.name!)")
		
		keyLabel.update(key.name!, color:cyan)
		destinationLabel.update("to \(destination.system) \(destination.name!)")
		
		pilotPort.addEvent(destination)
		pilotPort.enable()
		thrusterPort.enable()
		
		structure.updateChildrenColors(cyan)
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}