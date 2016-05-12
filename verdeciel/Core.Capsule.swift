
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreCapsule: Empty
{	
	var at:CGPoint = universe.loiqe_spawn.at
	
	var direction:Float! = 1
	var system:Systems = .loiqe
	
	var mesh:Empty!
	
	var shieldRoot = Empty()
	
	var radiation:CGFloat = 0
	
	// MARK: Default -
	
	override init()
	{
		super.init()
		
		self.direction = 0
		
		nodeSetup()
		interfaceSetup()
	}
	
	override func whenRenderer()
	{
		super.whenRenderer()
		
		// Docking
		
		if dock != nil && isDocked != true {
			
			var approachSpeed:CGFloat = 0.005
			
			let distanceRatio = distanceBetweenTwoPoints(at, point2: dock.at)/0.5
			approachSpeed = (CGFloat(approachSpeed) * CGFloat(distanceRatio))
			
			var speed:Float = Float(distanceRatio)/600 ; if speed < 0.0005 { speed = 0.0005 }
			let angle:Float = Float((capsule.direction) % 360)
			
			capsule.at.x += CGFloat(speed) * CGFloat(sin(degToRad(angle)))
			capsule.at.y += CGFloat(speed) * CGFloat(cos(degToRad(angle)))
			
			if distanceBetweenTwoPoints(capsule.at, point2: capsule.dock.at) < 0.003 { docked() }
			
		}
		
		// Warping
		
		if isWarping == true {
			if warp.distance > 1.5 {
				warpUp()
			}
			else{
				warpDown()
			}
			let speed:Float = Float(thruster.actualSpeed)/600
			let angle:Float = Float((capsule.direction) % 360)
			
			let angleRad = degToRad(angle)
			
			capsule.at.x += CGFloat(speed) * CGFloat(sin(angleRad))
			capsule.at.y += CGFloat(speed) * CGFloat(cos(angleRad))
		}
		
		if isFleeing == true {
			helmet.addWarning("Auto-Pilot", duration: 0.1, flag: "fleeing")
		}
		else if radiation > 0 {
			helmet.addWarning("Radiation \(String(format: "%.1f",radiation * 100))%", duration: 0.1, flag: "radiation")
		}
		
		if closestLocation().distance > 1.25 && isWarping == false {
			helmet.addWarning("Returning", duration: 0.1, flag: "returning")
			autoReturn()
		}
	}
	
	func beginAtLocation(location:Location)
	{
		at = location.at
		dock = location
		dock.isKnown = true
		dock(location)
		docked()
		
		space.onSystemEnter(location.system)
	}
	
	override func whenSecond()
	{
		super.whenSecond()
		
		let cl = closestLocation()
		if cl.system != nil && cl.system != system { space.onSystemEnter(cl.system) }
	}
	
	func closestLocation() -> Location
	{
		var closestLocation:Location!
		for location in universe.childNodes as! [Location] {
			if closestLocation == nil { closestLocation = location }
			if location.distance > closestLocation.distance { continue }
			closestLocation = location
		}
		return closestLocation
	}
	
	func closestStar() -> Location
	{
		if system == .loiqe { return universe.loiqe }
		else if system == .valen { return universe.valen }
		else if system == .senni { return universe.senni }
		else if system == .usul { return universe.usul }
		else if system == .close { return universe.close }
		
		return universe.loiqe
	}
	
	func closestKnownLocation() -> Location!
	{
		var closestLocation:Location!
		for location in universe.childNodes as! [Location] {
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
		let portal = dock as! LocationPortal
		
		portal.pilotPort.disconnect()
		portal.thrusterPort.disconnect()
		portal.onWarp()
		if intercom.port.origin != nil { intercom.port.origin.disconnect() }
		
		destination.isKnown = true
		radar.addTarget(destination)
		warp = destination
		isWarping = true
		undock()
	}

	func warpUp()
	{
		if thruster.actualSpeed < 10 { thruster.actualSpeed += 0.025 }
	}
	
	func warpDown()
	{
		thruster.speed = 1
		if thruster.actualSpeed > 1 { thruster.actualSpeed -= 0.1 }
		else{ warpStop() }
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
		addChildNode(completion)
		
		// Panels
		addChildNode(battery)
		addChildNode(hatch)
		addChildNode(console)
		addChildNode(cargo)
		addChildNode(intercom)
		addChildNode(pilot)
		addChildNode(radar)
		addChildNode(thruster)
		
		addChildNode(above)
		addChildNode(below)
		
		hatch.eulerAngles.y = degToRad(45)
		console.eulerAngles.y = degToRad(90)
		cargo.eulerAngles.y = degToRad(135)
		intercom.eulerAngles.y = degToRad(180)
		pilot.eulerAngles.y = degToRad(225)
		radar.eulerAngles.y = degToRad(270)
		thruster.eulerAngles.y = degToRad(315)
		
		journey.eulerAngles.y = battery.eulerAngles.y
		exploration.eulerAngles.y = console.eulerAngles.y
		progress.eulerAngles.y = intercom.eulerAngles.y
		completion.eulerAngles.y = radar.eulerAngles.y
		
		// Widgets
		radar.footer.addChildNode(map)
		battery.footer.addChildNode(radio)
		console.footer.addChildNode(shield)
		intercom.footer.addChildNode(enigma)
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
	
	func docked()
	{
		lastLocation = dock
		if isFleeing == true { isFleeing = false ; thruster.unlock() }
		isReturning = false
		
		isDocked = true
		capsule.at = dock.at
		dock.onDock()
		radar.removeTarget()
		
		helmet.addPassive("Docked at \(dock.name!)")
		
		intercom.connectToLocation(dock)
	}
	
	func undock()
	{		
		dock.onUndock()
		isDocked = false
		dock = nil
		thruster.enable()
		
		helmet.addPassive("in flight")
		
		intercom.disconnectFromLocation()
	}
	
	// MARK: Fleeing -
	
	var isFleeing:Bool = false
	var lastLocation:Location!
	
	func flee()
	{
		self.isFleeing = true
		thruster.lock()
		thruster.speed = thruster.maxSpeed()
		radar.addTarget(capsule.lastLocation)
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
		
		mesh = Empty()
		mesh.position = SCNVector3(0,0,0)
		addChildNode(mesh)
	}
	
	func teleport(location:Location)
	{
		dock = location
		at = location.at
		isDocked = true
		dock.onDock()
		intercom.connectToLocation(dock)
		radar.removeTarget()
		helmet.addPassive("Docked at \(dock.name!)")
	}
	
	func isDockedAtLocation(location:Location) -> Bool
	{
		if isDocked == true && dock != nil && dock == location { return true }
		return false
	}
	
	func hasShield() -> Bool
	{
		if shield.isPowered() == true && shield.port.hasItemOfType(.shield) == true { return true }
		return false
	}
	
	// MARK: Systems -
	
	func systemsInstalledCount() -> Int
	{
		var count = 0
		for node in childNodes {
			if node is Panel && (node as! Panel).isInstalled == true { count += 1}
		}
		return count
	}
	
	func systemsCount() -> Int
	{
		var count = 0
		for node in childNodes {
			if node is Panel { count += 1}
		}
		return count
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}