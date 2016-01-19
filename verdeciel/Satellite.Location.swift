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
		super.init(name:name, system:system, at:at)
		
		self.name = name
		self.type = .satellite
		self.system = system
		self.at = at
		self.note = ""
		self.mesh = structures.cargo()
		self.isComplete = false
		
		icon.replace(icons.unseen())
		
		self.message = message
		
		port = SCNPortSlot(host: self, input:Item.self, output:Item.self, hasDetails:true)
		
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
	
	override func onDock()
	{
		super.onDock()
		port.refresh()
	}
	
	override func update()
	{
		if port.event == nil { isComplete = true }
		updateIcon()
	}
	
	override func onUploadComplete()
	{
		isComplete = true
		mission.complete()
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
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}