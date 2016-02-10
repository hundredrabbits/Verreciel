
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreCapsule: SCNNode
{	
	var at:CGPoint = universe.loiqe_spawn.at
	
	var direction:CGFloat! = 1
	var system:Systems = .loiqe
	var sector:sectors = .normal
	
	var isDocked:Bool = false
	var dock:Location!
	
	var isWarping:Bool = false
	var warp:Location!
	
	var mesh:SCNNode!
	
	var shield:SCNNode!
	
	// MARK: Default -
	
	override init()
	{
		super.init()
		
		self.direction = 0
		
		nodeSetup()
		interfaceSetup()
	}
	
	func start(location:Location)
	{
		at = location.at
		dock = location
		dock.isKnown = true
		dock(location)
		docked()
		
		battery.install()
	}
	
	override func fixedUpdate()
	{
		docking()
		warping()
		
		// Todo: Remove from fixed update
		let cl = closestLocation()
		if cl.system != nil { system = cl.system }
		
		// animate shield
		shield.eulerAngles.x += 0.0001
		shield.eulerAngles.y += 0.001
		shield.eulerAngles.z += 0.01
	}
	
	func closestLocationOfType(type:LocationTypes) -> Location
	{
		var closestLocation:Location!
		for location in universe.childNodes {
			let location = location as! Location
			if location.type != type { continue }
			if closestLocation == nil { closestLocation = location }
			if location.distance > closestLocation.distance { continue }
			closestLocation = location
		}
		return closestLocation
	}
	
	func closestLocation() -> Location
	{
		var closestLocation:Location!
		for location in universe.childNodes {
			let location = location as! Location
			if closestLocation == nil { closestLocation = location }
			if location.distance > closestLocation.distance { continue }
			closestLocation = location
		}
		return closestLocation
	}
	
	func closestKnownLocation() -> Location!
	{
		var closestLocation:Location!
		for location in universe.childNodes {
			let location = location as! Location
			if location.isKnown == false { continue }
			if closestLocation == nil { closestLocation = location }
			if location.distance > closestLocation.distance { continue }
			closestLocation = location
		}
		return closestLocation
	}
	
	// MARK: Warping -
	
	func warp(destination:Location)
	{
		dock.disconnectPanel()
		
		destination.isKnown = true
		radar.addTarget(destination)
		warp = destination
		isWarping = true
		undock()
	}
	
	func warping()
	{
		if isWarping == false { return }
	
		if warp.distance > 1.5 {
			warpUp()
		}
		else{
			warpDown()
		}
		
		warpTravel()
	}
	
	func warpTravel()
	{
		let speed:Float = Float(thruster.actualSpeed)/600
		let angle:CGFloat = CGFloat((capsule.direction) % 360)
		
		let angleRad = degToRad(angle)
		
		capsule.at.x += CGFloat(speed) * CGFloat(sin(angleRad))
		capsule.at.y += CGFloat(speed) * CGFloat(cos(angleRad))
	}
	
	func warpUp()
	{
		if thruster.actualSpeed < 10 { thruster.actualSpeed += 0.025 }
		space.starTimer += thruster.actualSpeed
	}
	
	func warpDown()
	{
		// todo: Make sure the capsule reaches its destination, unlock controls.
		thruster.speed = 1
		if thruster.actualSpeed > 1 { thruster.actualSpeed -= 0.1 }
		else{ warpStop() }
		space.starTimer += thruster.actualSpeed
	}
	
	func warpStop()
	{
		isWarping = false
		warp = nil
		thruster.button.enable("??")
	}
	
	func interfaceSetup()
	{
		// Monitors
		addChildNode(journey)
		addChildNode(exploration)
		addChildNode(progress)
		addChildNode(complete)
		
		// Panels
		addChildNode(battery)
		addChildNode(hatch)
		addChildNode(console)
		addChildNode(cargo)
		addChildNode(mission)
		addChildNode(pilot)
		addChildNode(radar)
		addChildNode(thruster)
		
		hatch.eulerAngles.y = Float(degToRad(45))
		console.eulerAngles.y = Float(degToRad(90))
		cargo.eulerAngles.y = Float(degToRad(135))
		mission.eulerAngles.y = Float(degToRad(180))
		pilot.eulerAngles.y = Float(degToRad(225))
		radar.eulerAngles.y = Float(degToRad(270))
		thruster.eulerAngles.y = Float(degToRad(315))
		
		journey.eulerAngles.y = battery.eulerAngles.y
		exploration.eulerAngles.y = console.eulerAngles.y
		progress.eulerAngles.y = mission.eulerAngles.y
		complete.eulerAngles.y = radar.eulerAngles.y
		
		// Widgets
		radar.footer.addChildNode(map)
		battery.footer.addChildNode(radio)
		console.footer.addChildNode(shield)
		mission.footer.addChildNode(enigma)
	}
	
	// MARK: Docking -
	
	func dock(newDock:Location)
	{
		print("init dock")
		dock = newDock
		thruster.disable()
		
		ui.addPassive("Approaching \(dock.name!)")
	}
	
	func docking()
	{
		if dock == nil { return }
		if isDocked == true { return }
		
		var approachSpeed:CGFloat = 0.001
		
		let distanceRatio = distanceBetweenTwoPoints(at, point2: dock.at)/0.5
		approachSpeed = (CGFloat(approachSpeed) * CGFloat(distanceRatio))
		
		var speed:Float = Float(distanceRatio)/600 ; if speed < 0.0005 { speed = 0.0005 }
		let angle:CGFloat = CGFloat((capsule.direction) % 360)

		capsule.at.x += CGFloat(speed) * CGFloat(sin(degToRad(angle)))
		capsule.at.y += CGFloat(speed) * CGFloat(cos(degToRad(angle)))
		
		if distanceBetweenTwoPoints(capsule.at, point2: capsule.dock.at) < 0.001 { docked() }
	}
	
	func docked()
	{
		isDocked = true
		capsule.at = dock.at
		dock.onDock()
		
		ui.addPassive("Docked at \(dock.name!)")
		
		mission.connectToLocation(dock)
	}
	
	func undock()
	{
		dock.disconnectPanel()
		isDocked = false
		dock = nil
		thruster.enable()
		
		ui.addPassive("in flight")
		
		mission.disconnectFromLocation()
	}
	
	// MARK: Custom -
	
	func nodeSetup()
	{
		var scale:Float = 0.25
		var height:Float = -3.35
		
		scale = 1
		height = 1.5
		
		var highNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		templates.left = highNode[7].x
		templates.right = highNode[0].x
		templates.top = highNode[0].y
		templates.bottom = -highNode[0].y
		templates.leftMargin = highNode[7].x * 0.8
		templates.rightMargin = highNode[0].x * 0.8
		templates.topMargin = highNode[0].y * 0.8
		templates.bottomMargin = -highNode[0].y * 0.8
		templates.radius = highNode[0].z
		templates.margin = abs(templates.left - templates.leftMargin)
		
		mesh = SCNNode()
		mesh.position = SCNVector3(0,0,0)
		addChildNode(mesh)
		
		
		createShield()
	}
	
	func createShield()
	{
		shield = SCNNode()
		shield.position = SCNVector3(0,0,0)
		addChildNode(shield)
		self.position = SCNVector3(0,0,0)
		
		let radius:CGFloat = 10
		var geometries:Array<SCNVector3> = []
		
		// Ring 1
		
		geometries.append(SCNVector3(radius * 0.25,0,radius * 0.75))
		geometries.append(SCNVector3(radius * 0.75,0,radius * 0.25))
		geometries.append(SCNVector3(radius * 0.75,0,-radius * 0.25))
		geometries.append(SCNVector3(radius * 0.25,0,-radius * 0.75))
		
		geometries.append(SCNVector3(-radius * 0.25,0,-radius * 0.75))
		geometries.append(SCNVector3(-radius * 0.75,0,-radius * 0.25))
		geometries.append(SCNVector3(-radius * 0.75,0,radius * 0.25))
		geometries.append(SCNVector3(-radius * 0.25,0,radius * 0.75))
		
		
		// Ring 2
		
		geometries.append(SCNVector3(radius * 0.5,radius * 0.5,radius * 0.5))
		geometries.append(SCNVector3(radius * 0.5,radius * 0.5,-radius * 0.5))
		geometries.append(SCNVector3(-radius * 0.5,radius * 0.5,-radius * 0.5))
		geometries.append(SCNVector3(-radius * 0.5,radius * 0.5,radius * 0.5))
		
		geometries.append(SCNVector3(radius * 0.5,-radius * 0.5,radius * 0.5))
		geometries.append(SCNVector3(radius * 0.5,-radius * 0.5,-radius * 0.5))
		geometries.append(SCNVector3(-radius * 0.5,-radius * 0.5,-radius * 0.5))
		geometries.append(SCNVector3(-radius * 0.5,-radius * 0.5,radius * 0.5))
		
		// Ring 3
		
		geometries.append(SCNVector3(0,radius * 0.75,radius * 0.25))
		geometries.append(SCNVector3(radius * 0.25,radius * 0.75,0))
		geometries.append(SCNVector3(0,radius * 0.75,-radius * 0.25))
		geometries.append(SCNVector3(-radius * 0.25,radius * 0.75,0))
		
		geometries.append(SCNVector3(0,-radius * 0.75,radius * 0.25))
		geometries.append(SCNVector3(radius * 0.25,-radius * 0.75,0))
		geometries.append(SCNVector3(0,-radius * 0.75,-radius * 0.25))
		geometries.append(SCNVector3(-radius * 0.25,-radius * 0.75,0))
		
		
		shield.addChildNode(SCNLine(nodeA: geometries[0], nodeB: geometries[12], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[1], nodeB: geometries[12], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[0], nodeB: geometries[8], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[1], nodeB: geometries[8], color: white))
		
		shield.addChildNode(SCNLine(nodeA: geometries[2], nodeB: geometries[13], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[3], nodeB: geometries[13], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[2], nodeB: geometries[9], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[3], nodeB: geometries[9], color: white))
		
		shield.addChildNode(SCNLine(nodeA: geometries[4], nodeB: geometries[14], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[5], nodeB: geometries[14], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[4], nodeB: geometries[10], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[5], nodeB: geometries[10], color: white))
		
		shield.addChildNode(SCNLine(nodeA: geometries[6], nodeB: geometries[15], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[7], nodeB: geometries[15], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[6], nodeB: geometries[11], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[7], nodeB: geometries[11], color: white))
		
		// Top circle
		shield.addChildNode(SCNLine(nodeA: geometries[16], nodeB: geometries[17], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[17], nodeB: geometries[18], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[18], nodeB: geometries[19], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[19], nodeB: geometries[16], color: white))
		
		// Middle
		shield.addChildNode(SCNLine(nodeA: geometries[0], nodeB: geometries[1], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[1], nodeB: geometries[2], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[2], nodeB: geometries[3], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[3], nodeB: geometries[4], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[4], nodeB: geometries[5], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[5], nodeB: geometries[6], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[6], nodeB: geometries[7], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[7], nodeB: geometries[0], color: white))
		
		// Bottom circle
		shield.addChildNode(SCNLine(nodeA: geometries[20], nodeB: geometries[21], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[21], nodeB: geometries[22], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[22], nodeB: geometries[23], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[23], nodeB: geometries[20], color: white))
		
		shield.addChildNode(SCNLine(nodeA: geometries[12], nodeB: geometries[21], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[13], nodeB: geometries[21], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[13], nodeB: geometries[22], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[14], nodeB: geometries[22], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[14], nodeB: geometries[23], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[15], nodeB: geometries[23], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[15], nodeB: geometries[20], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[12], nodeB: geometries[20], color: white))
		
		shield.addChildNode(SCNLine(nodeA: geometries[8], nodeB: geometries[17], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[9], nodeB: geometries[17], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[9], nodeB: geometries[18], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[10], nodeB: geometries[18], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[10], nodeB: geometries[19], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[11], nodeB: geometries[19], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[11], nodeB: geometries[16], color: white))
		shield.addChildNode(SCNLine(nodeA: geometries[8], nodeB: geometries[16], color: white))
	}
	
	func teleport(location:Location)
	{
		dock = location
		at = location.at
		isDocked = true
		dock.onDock()
		mission.connectToLocation(dock)
		radar.removeTarget()
		ui.addPassive("Docked at \(dock.name!)")
	}
	
	func isDockedAtLocation(location:Location) -> Bool
	{
		if isDocked == true && dock != nil && dock == location { return true }
		return false
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}