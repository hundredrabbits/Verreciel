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
	
	func sightUpdate()
	{
	
	}
	
	override func update()
	{
		self.position = SCNVector3(at.x,at.y,0)
		self.distance = distanceBetweenTwoPoints(capsule.at, point2: self.at)
		self.angle = calculateAngle()
		self.align = calculateAlignment()
		
		// Sighted
		if self.distance < 2 {
			if self.inSight == false {
				self.inSight = true
				self.isKnown = true
				sight()
			}
			sightUpdate()
		}
		else{
			inSight = false
		}
		
		// Approach
		if self.distance <= 0.6 {
			if self.inApproach == false {
				approach()
				self.inApproach = true
			}
		}
		else{
			inApproach = false
		}
		
		// Collide
		if self.distance < 0.01 {
			if self.inCollision == false {
				collide()
				self.inCollision = true
			}
		}
		else{
			inCollision = false
		}
		
		radarCulling()
		clean()
	}

	// MARK: Events -
	
	func sight()
	{
		print("* EVENT    | Sighted \(self.name!)")
		updateSprite()
	}
	
	func approach()
	{
		print("* EVENT    | Approached \(self.name!)")
		capsule.instance = self
		space.startInstance(self)
		player.activateEvent(self)
		updateSprite()
	}
	
	func collide()
	{
		print("* EVENT    | Collided \(self.name!)")
		updateSprite()
		capsule.dock(self)
	}
	
	func addService(service:services)
	{
		self.service = service
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}