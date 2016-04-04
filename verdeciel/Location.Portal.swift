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
		destinationLabel = SCNLabel(text: "destination", scale: 0.05, align: .center, color: grey)
		pilotPort = SCNPort(host: self, input: nil, output: nil)
		pilotLabel = SCNLabel(text: "pilot", scale: 0.1, align: .center, color: grey)
		thrusterPort = SCNPort(host: self, input: nil, output: nil)
		thrusterLabel = SCNLabel(text: "thruster", scale: 0.08, align: .center, color: grey)
		
		self.note = ""
		self.color = color
		self.structure = structures.portal()
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
		if mission.port.isReceivingItemOfType(.key) == false { lock() ; return }
		if (mission.port.origin.event is Item) != true { lock() ; return }
		unlock()
	}
	
	func lock()
	{
		pilotPort.removeEvent()
		pilotPort.disable()
		thrusterPort.disable()
		keyLabel.update("no key", color:red)
	}
	
	func unlock()
	{
		let key = mission.port.origin.event as! Item
		let destination = universe.locationLike(key.location)
		
		print("! KEY      | Reading: \(key.name!) -> \(destination.name!)")
		
		keyLabel.update(key.name!, color:cyan)
		
		pilotPort.addEvent(destination)
		pilotPort.enable()
		thrusterPort.enable()
	}
	
	override func animateMesh()
	{
		super.animateMesh()
		
		structure.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.1)))
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}