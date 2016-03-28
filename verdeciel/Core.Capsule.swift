
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
	
	var mesh:SCNNode!
	
	var shieldRoot = SCNNode()
	
	var radiation:CGFloat = 0
	
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
		
		onSystemEnter(.valen)
	}
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		docking()
		warping()
		
		if isFleeing == false && radiation > 0 { helmet.showWarning("Radiation \(String(format: "%.1f",radiation * 100))%") }
		else if isFleeing == true && radiation > 0.5 { helmet.showWarning("Autopilot engaged") }
		else if closestLocation().distance > 1.25 && isWarping == false { autoReturn() ; helmet.showWarning("Autopilot engaged") }
		else{ helmet.hideWarning() }
	}
	
	func onSeconds()
	{
		let cl = closestLocation()
		if cl.system != nil && cl.system != system { onSystemEnter(cl.system) }
	}
	
	func onSystemEnter(system:Systems)
	{
		print("Entering \(system)")
		self.system = system

		switch system {
		case .valen  : space.targetSpaceColor = [0.2,0.2,0.2] ; space.currentStarsColor = [0.7,0.7,0.7] ; grey = UIColor(white: 0.5, alpha: 1)
		case .falvet : space.targetSpaceColor = [0.0,0.0,0.0] ; space.currentStarsColor = [0.5,0.5,0.5] ; grey = UIColor(white: 0.5, alpha: 1)
		case .senni  : space.targetSpaceColor = [0.0,0.0,0.0] ; space.currentStarsColor = [1.0,0.0,0.0] ; grey = UIColor(white: 0.5, alpha: 1)
		case .usul   : space.targetSpaceColor = [0.0,0.0,0.0] ; space.currentStarsColor = [1.0,0.0,0.0] ; grey = UIColor(white: 0.5, alpha: 1)
		case .nevic  : space.targetSpaceColor = [0.0,0.0,0.0] ; space.currentStarsColor = [0.2,0.0,0.0] ; grey = UIColor(white: 0.5, alpha: 1)
		default      : space.targetSpaceColor = [0.0,0.0,0.0] ; space.currentStarsColor = [1.0,1.0,1.0] ; grey = UIColor(white: 0.5, alpha: 1)
		}
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
	
	var isWarping:Bool = false
	var warp:Location!

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
		thruster.speed = 1
		if thruster.actualSpeed > 1 { thruster.actualSpeed -= 0.1 }
		else{ warpStop() }
		space.starTimer += thruster.actualSpeed
	}
	
	func warpStop()
	{
		isWarping = false
		warp = nil
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
		
		addChildNode(above)
		addChildNode(below)
		
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
	
	var isDocked:Bool = false
	var dock:Location!
	
	func dock(newDock:Location)
	{
		print("* DOCK     | Init: \(newDock.name)")
		
		dock = newDock
		thruster.disable()
		
		helmet.addPassive("Approaching \(dock.name!)")
	}
	
	func docking()
	{
		if dock == nil { return }
		if isDocked == true { return }
		
		var approachSpeed:CGFloat = 0.005
		
		let distanceRatio = distanceBetweenTwoPoints(at, point2: dock.at)/0.5
		approachSpeed = (CGFloat(approachSpeed) * CGFloat(distanceRatio))
		
		var speed:Float = Float(distanceRatio)/600 ; if speed < 0.0005 { speed = 0.0005 }
		let angle:CGFloat = CGFloat((capsule.direction) % 360)

		capsule.at.x += CGFloat(speed) * CGFloat(sin(degToRad(angle)))
		capsule.at.y += CGFloat(speed) * CGFloat(cos(degToRad(angle)))
		
		if distanceBetweenTwoPoints(capsule.at, point2: capsule.dock.at) < 0.003 { docked() }
	}
	
	func docked()
	{
		lastLocation = dock
		isFleeing = false
		isReturning = false
		
		isDocked = true
		capsule.at = dock.at
		dock.onDock()
		radar.removeTarget()
		
		helmet.addPassive("Docked at \(dock.name!)")
		
		mission.connectToLocation(dock)
	}
	
	func undock()
	{
		dock.onUndock()
		dock.disconnectPanel()
		isDocked = false
		dock = nil
		thruster.enable()
		
		helmet.addPassive("in flight")
		
		mission.disconnectFromLocation()
	}
	
	// MARK: Fleeing -
	
	var isFleeing:Bool = false
	var lastLocation:Location!
	
	func flee()
	{
		self.isFleeing = true
	}
	
	var isReturning:Bool = false
	
	func autoReturn()
	{
		self.isReturning = true
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
	}
	
	func teleport(location:Location)
	{
		dock = location
		at = location.at
		isDocked = true
		dock.onDock()
		mission.connectToLocation(dock)
		radar.removeTarget()
		helmet.addPassive("Docked at \(dock.name!)")
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