import UIKit
import QuartzCore
import SceneKit
import Foundation

class Location : Event
{
	var service = services.none
	var interaction = "connected"
	
	var sprite = SCNNode()
	var angle:CGFloat!
	var align:CGFloat!
	var distance:CGFloat!
	
	var inCollision:Bool = false
	var inApproach:Bool = false
	var inDiscovery:Bool = false
	var inSight:Bool = false
	
	var isVisible:Bool = true
	var isTargetted:Bool = false
	var isKnown:Bool = false
	var isSeen:Bool = false
	var isSelected:Bool = false
	var isComplete:Bool = false
	
	var interface = Panel()
	
	var label = SCNLabel()
	
	init(name:String = "", at: CGPoint! = nil, service:services = services.none)
	{
		super.init(newName:name, at:at, type:eventTypes.location)

		self.at = at
		
		geometry = SCNPlane(width: 0.5, height: 0.5)
		geometry?.firstMaterial?.diffuse.contents = clear
		
		addChildNode(sprite)
		addChildNode(trigger)
		
		label = SCNLabel(text: name, scale: 0.06, align: alignment.center, color: grey)
		label.position = SCNVector3(0,-0.3,-0.35)
		addChildNode(label)
	}
	
	// MARK: System -
	
	override func start()
	{
		position = SCNVector3(at.x,at.y,0)
		
		position = SCNVector3(at.x,at.y,0)
		distance = distanceBetweenTwoPoints(capsule.at, point2: at)
		angle = calculateAngle()
		align = calculateAlignment()
	}
	
	override func fixedUpdate()
	{		
		position = SCNVector3(at.x,at.y,0)
		distance = distanceBetweenTwoPoints(capsule.at, point2: at)
		angle = calculateAngle()
		align = calculateAlignment()
		
		if distance <= settings.sight { if inSight == false { sight() ; inSight = true ; isSeen = true } ; sightUpdate() }
		else{ inSight = false }
		
		if distance <= settings.approach { if inApproach == false { inApproach = true ; approach() } ; approachUpdate() }
		else{ inApproach = false }
		
		if distance <= settings.collision { if inCollision == false {  inCollision = true ; collide() } ; collisionUpdate() }
		else{ inCollision = false }
		
		radarCulling()
		clean()
	}
	
	override func lateUpdate()
	{
	}
	
	func sight()
	{
		print("* EVENT    | Sighted \(self.name!)")
		isSeen = true
		sprite.replace(_sprite())
	}
	
	func discover()
	{
		print("* EVENT    | Discovered \(self.name!)")
		sprite.replace(_sprite())
	}
	
	func approach()
	{
		print("* EVENT    | Approached \(self.name!)")
		space.startInstance(self)
		sprite.replace(_sprite())
		capsule.dock(self)
	}
	
	func collide()
	{
		print("* EVENT    | Collided \(self.name!)")
	}
	
	func docked()
	{
		print("* EVENT    | Docked at \(self.name!)")
		isKnown = true
		sprite.replace(_sprite())
	}
	
	func sightUpdate()
	{
		
	}
	
	func approachUpdate()
	{
		
	}
	
	func collisionUpdate()
	{
		
	}
	
	func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 3
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius,2,0), nodeB: SCNVector3(0,2,radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,2,radius), nodeB: SCNVector3(radius,2,0), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,2,0), nodeB: SCNVector3(0,2,-radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,2,-radius), nodeB: SCNVector3(-radius,2,0), color: white))
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius,-2,0), nodeB: SCNVector3(0,-2,radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,-2,radius), nodeB: SCNVector3(radius,-2,0), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,-2,0), nodeB: SCNVector3(0,-2,-radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,-2,-radius), nodeB: SCNVector3(-radius,-2,0), color: white))

		return mesh
	}
	
	func radarCulling()
	{
		let verticalDistance = abs(capsule.at.y - at.y)
		let horizontalDistance = abs(capsule.at.x - at.x)
		
		if player.inRadar == true {
			self.opacity = 1
		}
		else if Float(verticalDistance) > templates.topMargin {
			self.opacity = 0
		}
		else if Float(horizontalDistance) > templates.right {
			self.opacity = 0
		}
		else {
			self.opacity = 1
		}
		
		if connection != nil {
			if connection.opacity == 1 {
				wire.opacity = 1
			}
			else{
				wire.opacity = 0
			}
		}
	}

	// MARK: Events -
	
	func addService(service:services)
	{
		self.service = service
	}
	
	override func touch(id:Int)
	{
		if radar.port.event == nil {
			radar.addTarget(self)
		}
		else if radar.port.event == self {
			radar.removeTarget()
		}
		else{
			radar.addTarget(self)
		}
	}
	
	func _sprite() -> SCNNode
	{
		var size = self.size/10
		size = 0.05
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
		}
		else{
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
		}
		
		return spriteNode
	}
	
	func calculateAngle() -> CGFloat
	{
		let p1 = capsule.at
		let p2 = self.at
		let center = capsule.at
		
		let v1 = CGVector(dx: p1.x - center.x, dy: p1.y - center.y)
		let v2 = CGVector(dx: p2.x - center.x, dy: p2.y - center.y)
		
		let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
		
		return (360 - (radToDeg(angle) - 90)) % 360
	}
	
	func calculateAlignment(direction:CGFloat = capsule.direction) -> CGFloat
	{
		var diff = max(direction, self.angle) - min(direction, self.angle)
		if (diff > 180){ diff = 360 - diff }
		
		return diff
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}