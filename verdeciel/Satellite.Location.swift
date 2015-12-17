import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationSatellite : Location
{
	var port:SCNPortSlot!
	var message:String!

	init(name:String, system:Systems, at: CGPoint = CGPoint(), message:String,item:Event!)
	{
		super.init(name:name, at:at)
		
		self.name = name
		self.system = system
		self.at = at
		self.note = ""
		self.mesh = structures.cargo()
		icon.replace(icons.none())
		
		self.message = message
		
		port = SCNPortSlot(host: self, hasDetails:true)
		
		if item != nil { port.addEvent(item) }
		update()
	}
	
	// MARK: Panel
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let nodeFrame = SCNNode()
		nodeFrame.position = SCNVector3(templates.leftMargin + 0.3,0,0)
		
		port.position = SCNVector3(x: 0, y: -0.5, z: 0)
		port.enable()
		nodeFrame.addChildNode(port)
		
		newPanel.addChildNode(nodeFrame)
		
		let messageLabel = SCNLabel(text: self.message)
		messageLabel.position = SCNVector3(templates.leftMargin,templates.topMargin - 0.2,0)
		newPanel.addChildNode(messageLabel)
		
		return newPanel
	}
	
	override func update()
	{
		if port.event == nil { isComplete = true }
		updateIcon()
	}
	
	// MARK: Mesh -
	
	override func animateMesh(mesh:SCNNode)
	{
		for node in mesh.childNodes {
			node.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.5)))
			node.eulerAngles.x = Float(degToRad(CGFloat(time.elapsed * 0.25)))
			node.eulerAngles.z = Float(degToRad(CGFloat(time.elapsed * 0.125)))
		}
	}
	
	// MARK: Icon -
	
	override func updateIcon()
	{
		if isSeen == false			{ icon.replace(icons.satellite(grey)) }
		else if isKnown == false	{ icon.replace(icons.satellite(white)) }
		else if isComplete == true	{ icon.replace(icons.satellite(cyan)) }
		else						{ icon.replace(icons.satellite(red)) }
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}