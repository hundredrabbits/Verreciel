import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationCargo : Location
{
	var port1:SCNPort!
	var port1Label:SCNLabel!
	var port1Note:SCNLabel!
	
	var port2:SCNPort!
	var port2Label:SCNLabel!
	var port2Note:SCNLabel!
	
	var locationLabel:SCNLabel!
	
	init(name:String,at: CGPoint = CGPoint(), item:Event!, item2:Event! = nil, isRadioQuest:Bool = false)
	{
		super.init(name:name, at:at)
		
		self.name = name
		self.at = at
		self.size = 1
		self.note = ""
		self.isRadioQuest = isRadioQuest
		self.mesh = structures.cargo
		icon.replace(icons.cargo())
		
		port1 = SCNPort(host: self)
		port1.event = item
		port2 = SCNPort(host: self)
		port2.event = item2
		
		update()
	}
	
	// MARK: Panel
	
	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()
		
		locationLabel = SCNLabel(text: note)
		locationLabel.position = SCNVector3(templates.leftMargin,templates.topMargin - 0.25,0)
		newPanel.addChildNode(locationLabel)
		
		// Interface
		
		let nodeFrame = SCNNode()
		nodeFrame.position = SCNVector3(templates.leftMargin + 0.3,0,0)
		
		port1.position = SCNVector3(x: 0, y: 0.6, z: 0)
		port1.enable()
		nodeFrame.addChildNode(port1)
		port1Label = SCNLabel(text: port1.event.name!)
		port1Label.position = SCNVector3(x: 0.5, y: 0, z: 0)
		port1.addChildNode(port1Label)
		port1Note = SCNLabel(text: port1.event.note, scale:0.08, color:grey)
		port1Note.position = SCNVector3(x: 0.5, y: -0.4, z: 0)
		port1.addChildNode(port1Note)
		
		port2.position = SCNVector3(x: 0, y: -0.6, z: 0)
		port2.enable()
		nodeFrame.addChildNode(port2)
		port2Label = SCNLabel()
		port2Label.position = SCNVector3(x: 0.5, y: 0, z: 0)
		port2.addChildNode(port2Label)
		port2Note = SCNLabel(scale:0.08, color:grey)
		port2Note.position = SCNVector3(x: 0.5, y: -0.4, z: 0)
		port2.addChildNode(port2Note)
		
		newPanel.addChildNode(nodeFrame)
		
		return newPanel
	}
	
	// MARK: Docked
	
	override func dockedUpdate()
	{
		if port1.event != nil && port1.event.size < 1 {
			port1.event = nil
		}
		if port2.event != nil && port2.event.size < 1 {
			port2.event = nil
		}
		
		if port1.event == nil {
			port1Label.update("Empty", color: grey)
			port1Note.update("--", color: grey)
			isComplete = true
			port1.disable()
		}
		else{
			port1Label.update(port1.event.name!)
			port1Note.update(port1.event.note)
		}
		
		if port2.event == nil {
			port2Label.update("Empty", color: grey)
			port2Note.update("--", color: grey)
			isComplete = true
			port2.disable()
		}
		else{
			port2Label.update(port2.event.name!)
			port2Note.update(port2.event.note)
		}
	}
	
	// MARK: I/O
	
	override func bang()
	{
		if port1.connection != nil && port1.event != nil{ port1.connection.host.listen(port1.event) }
		if port2.connection != nil && port2.event != nil{ port2.connection.host.listen(port2.event) }
		
		update()
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
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}