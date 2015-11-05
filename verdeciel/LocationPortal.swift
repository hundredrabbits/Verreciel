import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationPortal : Location
{
	let destination:CGPoint!
	let sector:sectors!
	
	var leftKeyPort:SCNPort!
	var leftThrusterPort:SCNPort!
	var leftPilotPort:SCNPort!
	
	var rightKeyPort:SCNPort!
	var rightThrusterPort:SCNPort!
	var rightPilotPort:SCNPort!
	
	init(name:String,at: CGPoint,destination:CGPoint,sector:sectors = sectors.normal,color:UIColor = white)
	{
		self.destination = destination
		self.sector = sector
		
		super.init(name:name, at:at)
		
		self.at = at
		self.size = 1
		self.note = ""
		self.color = color
		self.mesh = structures.portal()
		icon.replace(icons.placeholder())
	}
	
	// MARK: Panel - 
	
	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()
		
		// Right
		
		let right = SCNNode()
		
		rightKeyPort = SCNPort(host: self, input: eventTypes.item, output: eventTypes.none)
		rightKeyPort.position = SCNVector3(templates.leftMargin + 0.9,0.6,0)
		right.addChildNode(rightKeyPort)
		
		let rightKeyLabel = SCNLabel(text: "falvet")
		rightKeyLabel.position = SCNVector3(0.4,0,0)
		rightKeyPort.addChildNode(rightKeyLabel)
		
		rightPilotPort = SCNPort(host: self, input: eventTypes.none, output: eventTypes.location)
		rightPilotPort.position = SCNVector3(templates.leftMargin + 0.9,0.2,0)
		right.addChildNode(rightPilotPort)
		
		let rightPilotLabel = SCNLabel(text: "> Pilot", color:white)
		rightPilotLabel.position = SCNVector3(0.4,0,0)
		rightPilotPort.addChildNode(rightPilotLabel)
		
		rightThrusterPort = SCNPort(host: self, input: eventTypes.none, output: eventTypes.location)
		rightThrusterPort.position = SCNVector3(templates.leftMargin + 0.9,-0.2,0)
		right.addChildNode(rightThrusterPort)
		
		let rightThrusterLabel = SCNLabel(text: "> Thruster", color:white)
		rightThrusterLabel.position = SCNVector3(0.4,0,0)
		rightThrusterPort.addChildNode(rightThrusterLabel)
		
		rightKeyPort.enable()
		rightKeyPort.requirement = items.loiqePortal
		
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0,0), nodeB: SCNVector3(templates.leftMargin,0.6,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4,0,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.2,0.2,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.2,-0.2,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4 + 0.2,-0.2,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,-0.2,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4 + 0.2,0.2,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,0.2,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0.6,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,0.6,0), color: grey))
		
		// Left
		
		let left = SCNNode()
		
		leftKeyPort = SCNPort(host: self, input: eventTypes.item, output: eventTypes.none)
		leftKeyPort.position = SCNVector3(templates.leftMargin + 0.9,0.6,0)
		left.addChildNode(leftKeyPort)
		
		let leftKeyLabel = SCNLabel(text: "usul")
		leftKeyLabel.position = SCNVector3(0.4,0,0)
		leftKeyPort.addChildNode(leftKeyLabel)
		
		leftPilotPort = SCNPort(host: self, input: eventTypes.none, output: eventTypes.location)
		leftPilotPort.position = SCNVector3(templates.leftMargin + 0.9,0.2,0)
		left.addChildNode(leftPilotPort)
		
		let leftPilotLabel = SCNLabel(text: "> Pilot", color:grey)
		leftPilotLabel.position = SCNVector3(0.4,0,0)
		leftPilotPort.addChildNode(leftPilotLabel)
		
		leftThrusterPort = SCNPort(host: self, input: eventTypes.none, output: eventTypes.location)
		leftThrusterPort.position = SCNVector3(templates.leftMargin + 0.9,-0.2,0)
		left.addChildNode(leftThrusterPort)
		
		let leftThrusterLabel = SCNLabel(text: "> Thruster", color:grey)
		leftThrusterLabel.position = SCNVector3(0.4,0,0)
		leftThrusterPort.addChildNode(leftThrusterLabel)
		
		leftKeyPort.enable()
		leftKeyPort.requirement = items.loiqePortal
		
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0,0), nodeB: SCNVector3(templates.leftMargin,0.6,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4,0,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.2,0.2,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.2,-0.2,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4 + 0.2,-0.2,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,-0.2,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4 + 0.2,0.2,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,0.2,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0.6,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,0.6,0), color: grey))
		
		
		right.position = SCNVector3(0,0.5,0)
		left.position = SCNVector3(0,-0.9,0)
		
		newPanel.addChildNode(right)
		newPanel.addChildNode(left)
		
		rightPilotPort.enable()
		rightThrusterPort.enable()
		
		return newPanel
	}
	
	// MARK: Icon -
	
	override func updateIcon()
	{
		if isSeen == false			{ icon.replace(icons.portal(grey)) }
		else if isKnown == false	{ icon.replace(icons.portal(white)) }
		else if isComplete == true	{ icon.replace(icons.portal(cyan)) }
		else						{ icon.replace(icons.portal(red)) }
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}