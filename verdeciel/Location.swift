import UIKit
import QuartzCore
import SceneKit
import Foundation

class Location : Event
{
	var system:Systems!
	var code:String!
	
	var angle:Float!
	var align:Float!
	var distance:CGFloat!
	
	var inCollision:Bool = false
	var inApproach:Bool = false
	var inDiscovery:Bool = false
	var inSight:Bool = false
	
	var mapRequirement:Item!
	
	var isTargetable:Bool = true
	var isTargeted:Bool = false
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
		self.details = "unknown"
		self.at = at
		self.system = system
		self.icon = icon
		self.structure = structure
		self.code = "\(system)-\(name)"
		
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
		isSeen = true
		update()
		structure.onSight()
		icon.onUpdate()
	}
	
	func onApproach()
	{
		if mapRequirement != nil && map.port.hasEvent(mapRequirement) == false { return }
		space.startInstance(self)
		// Don't try to dock if there is already a target
		if radar.port.hasEvent() == true && radar.port.event == self || capsule.isFleeing == true {
			capsule.dock(self)
		}
		else if radar.port.hasEvent() == false {
			capsule.dock(self)
		}
		update()
	}
	
	func onCollision()
	{
		update()
	}
	
	func onDock()
	{
		isKnown = true
		update()
		structure.onDock()
		icon.onUpdate()
		exploration.refresh()
		audio.playSound("beep2")
	}
	
	func onUndock()
	{
		retrieveStorage()
		structure.onUndock()
		exploration.refresh()
	}
	
	func retrieveStorage()
	{
		if storage.count == 0 { return }
		
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
		audio.playSound("beep1")
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
				self.show()
			}
			else if self.mapRequirement != nil {
				self.opacity = (map.hasMap(self.mapRequirement) == true && battery.isMapPowered() == true) ? 1 : 0
			}
		}
		// Out Of Sight
		else{
			self.hide()
		}
		
		// Connections
		if connection != nil {
			if connection.opacity == 1 {
				icon.wire.show()
			}
			else{
				icon.wire.hide()
			}
		}
	}
	
	func connect(location:Location)
	{
		connection = location
		icon.wire.update([SCNVector3(0,0,0), SCNVector3( (connection.at.x - self.at.x),(connection.at.y - self.at.y),0)], color: grey)
	}

	// MARK: Events -
	
	override func touch(id:Int)
	{
		if isTargetable == false { return }
		
		if radar.port.event == nil {
			radar.addTarget(self)
			audio.playSound("click3")
		}
		else if radar.port.event == self {
			radar.removeTarget()
			audio.playSound("click2")
		}
		else{
			radar.addTarget(self)
			audio.playSound("click1")
		}
	}
	
	func calculateAngle() -> Float
	{
		let p1 = capsule.at
		let p2 = self.at
		let center = capsule.at
		
		let v1 = CGVector(dx: p1.x - center.x, dy: p1.y - center.y)
		let v2 = CGVector(dx: p2.x - center.x, dy: p2.y - center.y)
		
		let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
		
		return (360 - (radToDeg(Float(angle)) - 90)) % 360
	}
	
	func calculateAlignment(direction:Float = capsule.direction) -> Float
	{
		var diff = max(direction, self.angle) - min(direction, self.angle)
		if (diff > 180){ diff = 360 - diff }
		
		return diff
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
	
	override func payload() -> ConsolePayload
	{
		return ConsolePayload(data:[
			ConsoleData(text: "Name", details: "\(name!)"),
			ConsoleData(text: "System", details: "\(system)"),
			ConsoleData(text: "Position", details: "\(Int(at.x)),\(Int(at.y))"),
			ConsoleData(text: "Distance", details: "\(Int(distance))"),
			ConsoleData(text: "Angle", details: "\(Int(angle))"),
			ConsoleData(text: details)
			])
	}
	
	func close()
	{
		icon.close()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}