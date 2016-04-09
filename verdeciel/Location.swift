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
	
	var isAccessible:Bool = false
	var mapRequirement:Item!
	
	var isTargetted:Bool = false
	var isKnown:Bool = false
	var isSeen:Bool = false
	var isSelected:Bool = false
	var isComplete:Bool! = nil
	
	var interface = SCNNode()
	
	// Radar
	var icon = SCNNode()
	var label = SCNLabel()
	var trigger = SCNNode()
	var wire:SCNLine!
	var connection:Event!
	
	var structure = SCNNode()
	
	var storage:Array<SCNPort> = []
	var isPortEnabled:Bool = false
	
	init(name:String = "",system:Systems = .unknown, at: CGPoint)
	{
		super.init(name:name, at:at)
		
		self.name = name
		self.at = at
		self.system = system
		
		geometry = SCNPlane(width: 0.5, height: 0.5)
		geometry?.firstMaterial?.diffuse.contents = clear
		
		addChildNode(trigger)
		addChildNode(icon)
		
		label = SCNLabel(text: "", scale: 0.06, align: alignment.center, color: grey)
		label.position = SCNVector3(0,-0.3,-0.35)
		self.addChildNode(label)
		
		wire = SCNLine()
		wire.position = SCNVector3(0,0,-0.01)
		wire.opacity = 0
		self.addChildNode(wire)
	}
	
	// MARK: System -
	
	override func start()
	{		
		position = SCNVector3(at.x,at.y,0)
		distance = distanceBetweenTwoPoints(capsule.at, point2: at)
		angle = calculateAngle()
		align = calculateAlignment()
		
		if mapRequirement != nil { label.update(cyan) }
	}
	
	func setup()
	{
	
	}
	
	func refresh()
	{
		
	}
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		position = SCNVector3(at.x,at.y,0)
		distance = distanceBetweenTwoPoints(capsule.at, point2: at)
		angle = calculateAngle()
		align = calculateAlignment()
		
		if distance <= settings.sight { if inSight == false { onSight() ; inSight = true ; isSeen = true } ; sightUpdate() }
		else{ inSight = false }
		
		if distance <= settings.approach { if inApproach == false { inApproach = true ; onApproach() } ; approachUpdate() ; animateMesh() }
		else{ inApproach = false }
		
		if distance <= settings.collision { if inCollision == false {  inCollision = true ; onCollision() } ; collisionUpdate() }
		else{ inCollision = false }
		
		if capsule.isDocked == true && capsule.dock == self { dockedUpdate() }
		
		radarCulling()
		clean()
	}
	
	func updateIcon()
	{
		if isSeen == false			{ icon.updateChildrenColors(grey) }
		else if isComplete == nil	{ icon.updateChildrenColors(white) }
		else if isComplete == true	{ icon.updateChildrenColors(cyan)  }
		else						{ icon.updateChildrenColors(red)  }
	}
	
	func onSight()
	{
		print("* EVENT    | Sighted \(self.name!)")
		isSeen = true
		update()
		updateIcon()
		label.update(name!)
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
	}
	
	func onUndock()
	{
		retrieveStorage()
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
	
	func complete()
	{
		self.isComplete = true
		progress.refresh()
	}
	
	func onComplete()
	{
		updateIcon()
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
	
	func dockedUpdate()
	{
		
	}
	
	func animateMesh()
	{
		
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
				wire.opacity = 1
			}
			else{
				wire.opacity = 0
			}
		}
	}
	
	func connect(event:Event)
	{
		connection = event
		self.wire.draw(SCNVector3(0,0,0), nodeB: SCNVector3( (connection.at.x - self.at.x),(connection.at.y - self.at.y),0), color: grey)
	}

	// MARK: Events -
	
	override func touch(id:Int)
	{
		if isAccessible == false { print("Unaccessible") ; return }
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