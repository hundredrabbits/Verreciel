import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationGateway : Location
{
	var KeyPort:SCNPort!
	var ThrusterPort:SCNPort!
	var PilotPort:SCNPort!
	var KeyLabel:SCNLabel!
	var ThrusterLabel:SCNLabel!
	var PilotLabel:SCNLabel!
	
	var destination:LocationGateway!
	
	var key:Event!
	
	init(name:String, system:Systems, at: CGPoint, key: Event, mapRequirement:Item! = nil)
	{
		super.init(name:name,system:system, at:at)
		
		self.note = ""
		self.color = color
		structure = StructureDefault()
		self.mapRequirement = mapRequirement
		icon.replace(icons.gateway())
		
		self.key = key
		
		KeyPort = SCNPort(host: self)
		ThrusterPort = SCNPort(host: self)
		PilotPort = SCNPort(host: self)
		KeyPort = SCNPort(host: self)
		ThrusterPort = SCNPort(host: self)
		PilotPort = SCNPort(host: self)
		
		KeyLabel = SCNLabel(text: "",color:red)
		ThrusterLabel = SCNLabel(text: "> Thruster", color:white)
		PilotLabel = SCNLabel(text: "> Pilot", color:grey)
		
		ThrusterPort.addEvent(items.warpDrive)
		
		KeyPort.enable()
		KeyPort.requirement = key
	}
	
	// MARK: Panel -
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()

		// Left
		
		KeyPort.position = SCNVector3(templates.leftMargin + 0.9,0.6,0)
		newPanel.addChildNode(KeyPort)
		
		KeyLabel.position = SCNVector3(0.4,0,0)
		KeyPort.addChildNode(KeyLabel)
		
		PilotPort.position = SCNVector3(templates.leftMargin + 0.9,0.2,0)
		newPanel.addChildNode(PilotPort)
		
		PilotLabel.position = SCNVector3(0.4,0,0)
		PilotPort.addChildNode(PilotLabel)
		
		ThrusterPort.position = SCNVector3(templates.leftMargin + 0.9,-0.2,0)
		newPanel.addChildNode(ThrusterPort)
		
		ThrusterLabel.position = SCNVector3(0.4,0,0)
		ThrusterPort.addChildNode(ThrusterLabel)
		
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0,0), nodeB: SCNVector3(templates.leftMargin,0.6,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4,0,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.2,0.2,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.2,-0.2,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4 + 0.2,-0.2,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,-0.2,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4 + 0.2,0.2,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,0.2,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0.6,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,0.6,0), color: grey))
		
		return newPanel
	}
	
	func addDestination(target:LocationGateway)
	{
		destination = target
	}
	
	// MARK: I/O
	
	override func onConnect()
	{
	}
	
	override func listen(event: Event)
	{
		if KeyPort.origin != nil && KeyPort.origin.event == KeyPort.requirement {
			structure.replace(structures.portal(color:cyan))
		}
		update()
	}
	
	override func onDock()
	{
		super.onDock()
		
		if KeyPort.isReceiving(KeyPort.requirement) == true {
			structure.replace(structures.portal(color:cyan))
		}
	}
	
	override func update()
	{
		if KeyPort.isReceiving(KeyPort.requirement) == true {
			PilotPort.enable()
			ThrusterPort.enable()
			KeyLabel.updateColor(cyan)
			PilotLabel.updateColor(white)
			ThrusterLabel.updateColor(white)
		}
		else{
			PilotPort.disable()
			ThrusterPort.disable()
			KeyLabel.updateColor(red)
			PilotLabel.updateColor(grey)
			ThrusterLabel.updateColor(grey)
		}
	}
	
	// MARK: Mesh -
	
	override func animateMesh()
	{
		super.animateMesh()
		
		if KeyPort.isReceiving(KeyPort.requirement) == true {
			structure.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.1)))
		}
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}