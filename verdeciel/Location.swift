import UIKit
import QuartzCore
import SceneKit
import Foundation

class Location : Event
{
	var system:Systems!
	
	var angle:CGFloat!
	var align:CGFloat!
	var distance:CGFloat!
	
	var inCollision:Bool = false
	var inApproach:Bool = false
	var inDiscovery:Bool = false
	var inSight:Bool = false
	
	var mapRequirement:Item!
	
	var isTargetted:Bool = false
	var isKnown:Bool = false
	var isSeen:Bool = false
	var isSelected:Bool = false
	var isComplete:Bool! = nil
	
	var structure:Structure!
	var icon:Icon!
	var connection:Location!
	
	var storage:Array<SCNPort> = []
	var isPortEnabled:Bool = false
	
	init(name:String = "",system:Systems = .unknown, at: CGPoint, icon:Icon, structure:Structure)
	{
		super.init(name:name, at:at)
		
		self.name = name
		self.at = at
		self.system = system
		self.icon = icon
		self.structure = structure
		
		geometry = SCNPlane(width: 0.5, height: 0.5)
		geometry?.firstMaterial?.diffuse.contents = clear
	
		addChildNode(icon)
		
		structure.addHost(self)
		icon.addHost(self)
	}
	
	// MARK: System -
	
	override func whenStart()
	{
		super.whenStart()
		
		position = SCNVector3(at.x,at.y,0)
		distance = distanceBetweenTwoPoints(capsule.at, point2: at)
		angle = calculateAngle()
		align = calculateAlignment()
		
		icon.onUpdate()
	}
	
	func setup()
	{
	
	}
	
	func refresh()
	{
		
	}
	
	override func whenRenderer()
	{
		super.whenRenderer()
		
		position = SCNVector3(at.x,at.y,0)
		distance = distanceBetweenTwoPoints(capsule.at, point2: at)
		angle = calculateAngle()
		align = calculateAlignment()
		
		if distance <= settings.sight { if inSight == false { onSight() ; inSight = true ; isSeen = true } ; sightUpdate() }
		else{ inSight = false }
		
		if distance <= settings.approach { if inApproach == false { inApproach = true ; onApproach() } ; approachUpdate() }
		else{ inApproach = false }
		
		if distance <= settings.collision { if inCollision == false {  inCollision = true ; onCollision() } }
		else{ inCollision = false }
		
		if capsule.isDocked == true && capsule.dock == self { dockUpdate() }
		
		radarCulling()
		clean()
	}
	
	func onSight()
	{
		print("* EVENT    | Sighted \(self.name!)")
		isSeen = true
		update()
		structure.onSight()
		icon.onUpdate()
	}
	
	func onApproach()
	{
		print("* EVENT    | Approached \(self.name!)")
		space.startInstance(self)
		capsule.dock(self)
		update()
		
	}
	
	func onCollision()
	{
		print("* EVENT    | Collided \(self.name!)")
		update()
	}
	
	func onDock()
	{
		print("* EVENT    | Docked at \(self.name!)")
		isKnown = true
		update()
		structure.onDock()
		icon.onUpdate()
	}
	
	func onUndock()
	{
		retrieveStorage()
		structure.onUndock()
	}
	
	func retrieveStorage()
	{
		if storage.count == 0 { return }
		
		print("* STORAGE  | Retrieving \(storage.count) items from \(name!)")
		
		for port in storage {
			if port.hasItem() == true {
				cargo.addItem(port.event as! Item)
				port.removeEvent()
			}
		}
	}
	
	func onComplete()
	{
		self.isComplete = true
		progress.refresh()
		icon.onUpdate()
		structure.onComplete()
		intercom.complete()
	}
	
	func sightUpdate()
	{
		structure.sightUpdate()
	}
	
	func approachUpdate()
	{
		
	}
	
	func collisionUpdate()
	{
		
	}
	
	func dockUpdate()
	{
		structure.dockUpdate()
	}
	
	func radarCulling()
	{
		let verticalDistance = abs(capsule.at.y - at.y)
		let horizontalDistance = abs(capsule.at.x - at.x)
		
		// In Sight
		if Float(verticalDistance) <= 1.5 && Float(horizontalDistance) <= 1.5 || radar.overviewMode == true && distance < 7{
			if self.mapRequirement == nil {
				self.opacity = 1
			}
			else if self.mapRequirement != nil {
				self.opacity = (map.hasMap(self.mapRequirement) == true && battery.isMapPowered() == true) ? 1 : 0
			}
		}
		// Out Of Sight
		else{
			self.opacity = 0
		}
		
		// Connections
		if connection != nil {
			if connection.opacity == 1 {
				icon.wire.opacity = 1
			}
			else{
				icon.wire.opacity = 0
			}
		}
	}
	
	func connect(location:Location)
	{
		connection = location
		icon.wire.draw([SCNVector3(0,0,0), SCNVector3( (connection.at.x - self.at.x),(connection.at.y - self.at.y),0)], color: grey)
	}

	// MARK: Events -
	
	override func touch(id:Int)
	{
		if isSeen == false { print("Unseen..") ; return }
		
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
	
	func details() -> String
	{
		return "--"
	}
	
	// MARK: Storage -
	
	func storedItems() -> Array<Event>
	{
		var collection:Array<Event> = []
		for port in storage{
			if port.hasEvent() == true && port.event.isQuest == true { collection.append(port.event) }
		}
		return collection
	}
	
	func isStorageEmpty() -> Bool
	{
		for port in storage{
			if port.hasEvent() == true { return true}
		}
		return false
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}