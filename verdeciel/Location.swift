import UIKit
import QuartzCore
import SceneKit
import Foundation

class Location : Event
{
	var service = services.none
	var interaction = "connected"
	
	init(name:String,at: CGPoint, service:services = services.none)
	{
		super.init(newName:name, at:at, type:eventTypes.location)

		self.at = at
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
	}
	
	func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 3
		let distance:Float = 4
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius,distance,0), nodeB: SCNVector3(0,distance,radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,distance,radius), nodeB: SCNVector3(radius,distance,0), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,distance,0), nodeB: SCNVector3(0,distance,-radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,distance,-radius), nodeB: SCNVector3(-radius,distance,0), color: white))

		return mesh
	}
	
	func addService(service:services)
	{
		self.service = service
	}
	
	override func collide()
	{
		capsule.dock(self)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}