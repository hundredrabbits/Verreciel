import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationPortal : Location
{
	var rightKeyPort:SCNPort!
	var rightThrusterPort:SCNPort!
	var rightPilotPort:SCNPort!
	var rightKeyLabel:SCNLabel!
	var rightThrusterLabel:SCNLabel!
	var rightPilotLabel:SCNLabel!
	
	var leftKeyPort:SCNPort!
	var leftThrusterPort:SCNPort!
	var leftPilotPort:SCNPort!
	var leftKeyLabel:SCNLabel!
	var leftThrusterLabel:SCNLabel!
	var leftPilotLabel:SCNLabel!
	
	var right:LocationPortal!
	var left:LocationPortal!
	var rightName:String!
	var leftName:String!
	
	var isUnlocked:Bool = false
	var key:Event!
	
	init(name:String,at: CGPoint, key: Event!, rightName:String, leftName:String)
	{
		super.init(name:name, at:at)
		
		self.at = at
		self.size = 1
		self.note = ""
		self.color = color
		self.mesh = structures.portal()
		icon.replace(icons.placeholder())
		
		self.key = key
		self.rightName = rightName
		self.leftName = leftName
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
		
		rightKeyLabel = SCNLabel(text: "\(rightName) key",color:red)
		rightKeyLabel.position = SCNVector3(0.4,0,0)
		rightKeyPort.addChildNode(rightKeyLabel)
		
		rightPilotPort = SCNPort(host: self, input: eventTypes.none, output: eventTypes.location)
		rightPilotPort.position = SCNVector3(templates.leftMargin + 0.9,0.2,0)
		right.addChildNode(rightPilotPort)
		
		rightPilotLabel = SCNLabel(text: "> Pilot", color:white)
		rightPilotLabel.position = SCNVector3(0.4,0,0)
		rightPilotPort.addChildNode(rightPilotLabel)
		
		rightThrusterPort = SCNPort(host: self, input: eventTypes.none, output: eventTypes.location)
		rightThrusterPort.position = SCNVector3(templates.leftMargin + 0.9,-0.2,0)
		right.addChildNode(rightThrusterPort)
		
		rightThrusterLabel = SCNLabel(text: "> Thruster", color:white)
		rightThrusterLabel.position = SCNVector3(0.4,0,0)
		rightThrusterPort.addChildNode(rightThrusterLabel)
		
		rightKeyPort.enable()
		rightKeyPort.requirement = items.valenPortalKey
		
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
		
		leftKeyLabel = SCNLabel(text: "\(leftName) key",color:red)
		leftKeyLabel.position = SCNVector3(0.4,0,0)
		leftKeyPort.addChildNode(leftKeyLabel)
		
		leftPilotPort = SCNPort(host: self, input: eventTypes.none, output: eventTypes.location)
		leftPilotPort.position = SCNVector3(templates.leftMargin + 0.9,0.2,0)
		left.addChildNode(leftPilotPort)
		
		leftPilotLabel = SCNLabel(text: "> Pilot", color:grey)
		leftPilotLabel.position = SCNVector3(0.4,0,0)
		leftPilotPort.addChildNode(leftPilotLabel)
		
		leftThrusterPort = SCNPort(host: self, input: eventTypes.none, output: eventTypes.location)
		leftThrusterPort.position = SCNVector3(templates.leftMargin + 0.9,-0.2,0)
		left.addChildNode(leftThrusterPort)
		
		leftThrusterLabel = SCNLabel(text: "> Thruster", color:grey)
		leftThrusterLabel.position = SCNVector3(0.4,0,0)
		leftThrusterPort.addChildNode(leftThrusterLabel)
		
		leftKeyPort.enable()
		leftKeyPort.requirement = items.valenPortalKey
		
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
	
	override func dockedUpdate()
	{
		if left.isUnlocked == true {
			leftPilotPort.enable()
			leftThrusterPort.enable()
			leftKeyLabel.updateColor(cyan)
			leftPilotLabel.updateColor(white)
			leftThrusterLabel.updateColor(white)
		}
		else{
			leftPilotPort.disable()
			leftThrusterPort.disable()
			leftKeyLabel.updateColor(red)
			leftPilotLabel.updateColor(grey)
			leftThrusterLabel.updateColor(grey)
		}
		
		if right.isUnlocked == true {
			rightPilotPort.enable()
			rightThrusterPort.enable()
			rightKeyLabel.updateColor(cyan)
			rightPilotLabel.updateColor(white)
			rightThrusterLabel.updateColor(white)
		}
		else{
			rightPilotPort.disable()
			rightThrusterPort.disable()
			rightKeyLabel.updateColor(red)
			rightPilotLabel.updateColor(grey)
			rightThrusterLabel.updateColor(grey)
		}
	}
	
	// MARK: Icon -
	
	override func updateIcon()
	{
		if isSeen == false			{ icon.replace(icons.portal(grey)) }
		else if isKnown == false	{ icon.replace(icons.portal(white)) }
		else if isComplete == true	{ icon.replace(icons.portal(cyan)) }
		else						{ icon.replace(icons.portal(red)) }
	}
	
	func addPortals(right:LocationPortal,left:LocationPortal)
	{
		self.right = right
		self.left = left
	}
	
	func addKeys(right:Event,left:Event)
	{
		self.rightKeyPort.requirement = right
		self.leftKeyPort.requirement = left
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}