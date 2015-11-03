import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationCargo : Location
{
	var inventoryPort:SCNPort!
	var inventoryLabel:SCNLabel!
	var inventoryNote:SCNLabel!
	var locationLabel:SCNLabel!
	
	init(name:String,at: CGPoint = CGPoint(), item:Event!, isRadioQuest:Bool = false)
	{
		super.init(name:name, at:at)
		
		self.name = name
		self.at = at
		self.size = 1
		self.note = ""
		self.isRadioQuest = isRadioQuest
		self.mesh = structures.cargo
		self.icon = icons.cargo
		
		inventoryPort = SCNPort(host: self)
		inventoryPort.event = item
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
		nodeFrame.position = SCNVector3(templates.leftMargin + 0.3,-0.4,0)
		
		inventoryPort.position = SCNVector3(x: 0, y: 0, z: 0)
		inventoryPort.enable()
		nodeFrame.addChildNode(inventoryPort)
		
		inventoryLabel = SCNLabel(text: inventoryPort.event.name!)
		inventoryLabel.position = SCNVector3(x: 0.5, y: 0, z: 0)
		nodeFrame.addChildNode(inventoryLabel)
		
		inventoryNote = SCNLabel(text: inventoryPort.event.note, scale:0.08, color:grey)
		inventoryNote.position = SCNVector3(x: 0.5, y: -0.4, z: 0)
		nodeFrame.addChildNode(inventoryNote)
		
		newPanel.addChildNode(nodeFrame)
		
		return newPanel
	}
	
	override func update()
	{
		if inventoryPort.event != nil && inventoryPort.event.size < 1 {
			inventoryPort.event = nil
		}
		
		if inventoryPort.event == nil {
			inventoryLabel.update("Empty", color: grey)
			inventoryNote.update("--", color: grey)
			isComplete = true
			inventoryPort.disable()
		}
	}
	
	// MARK: I/O
	
	override func bang()
	{
		if inventoryPort.connection == nil { print("Missing connection") ; return }
		
		if inventoryPort.event != nil {
			inventoryPort.connection.host.listen(inventoryPort.event)
		}
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