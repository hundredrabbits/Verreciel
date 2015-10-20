//
//  CapsuleNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreCapsule: SCNNode
{
	var hull:Float = 100
	var shield:Float = 100
	var oxygen:Float = 100
	
	var at:CGPoint = universe.loiqe_spawn.at
	var journey:Float = 0
	
	var direction:CGFloat! = 1
	var sector:sectors = sectors.normal
	
	var dock:Location!
	var mesh:SCNNode!
	
	override init()
	{
		super.init()
		
		self.direction = 0
		
		nodeSetup()

		panelSetup()
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func start()
	{
		dockbay.start()
		radar.install()
	}
	
	// MARK: Breaker -
	
	func setActive()
	{
		radar.setPower(true)
		pilot.setPower(true)
		mission.setPower(true)
		cargo.setPower(true)
		console.setPower(true)
		hatch.setPower(true)
		battery.setPower(true)
		thruster.setPower(true)
	}
	
	func setInactive()
	{
		radar.setPower(false)
		pilot.setPower(false)
		mission.setPower(false)
		cargo.setPower(false)
		console.setPower(false)
		hatch.setPower(false)
		battery.setPower(false)
		thruster.setPower(false)
	}
	
	// MARK: Docking -
	
	func dock(newDock:Location)
	{
		dock = newDock
		mission.dock(dock)
		thruster.disable()
		dockbay.update()
	}
	
	func undock()
	{
		dock = nil
		mission.undock()
		thruster.enable()
	}
	
	func connectDefaultPorts()
	{
		battery.outCell1.connect(battery.inOxygen)
		battery.outCell2.connect(battery.inThruster)
		cargo.port.connect(console.port)
		radar.port.connect(pilot.port)
	}
	
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
		
		mesh = SCNNode()
		mesh.position = SCNVector3(0,0,0)
		addChildNode(mesh)
		
		var i = 0
		while i < 90 {
			let line = SCNLine(nodeA: SCNVector3(-0.1,-3,templates.radius), nodeB: SCNVector3(0.1,-3,templates.radius), color: grey)
			line.eulerAngles.y += Float(degToRad(CGFloat(i) * 4))
			mesh.addChildNode(line)
			i += 1
		}
	}
	
	override func fixedUpdate()
	{		
		service()
		systems()
	}
	
	func systems()
	{
		if battery.inOxygen.origin != nil {
			if battery.inOxygen.origin.event.type == eventTypes.cell && capsule.oxygen < 100 { capsule.oxygen += 0.5 }
		}
		if battery.inShield.origin != nil {
			if battery.inShield.origin.event.type == eventTypes.cell && capsule.shield < 100 { capsule.shield += 0.5 }
		}
	}
	
	func service()
	{
		if dock == nil { return }
		if dock.service == services.electricity && battery.value < 100 { battery.recharge() }
		if dock.service == services.hull && capsule.hull < 100 { capsule.hull += 0.5 }
	}
	
	func panelSetup()
	{
		let northPanels = SCNNode()
		northPanels.addChildNode(mission)
		northPanels.addChildNode(dockbay)
		northPanels.addChildNode(PanelHandle(destination: SCNVector3(0,0,1.5)))
		
		let northEastPanels = SCNNode()
		northEastPanels.addChildNode(cargo)
		
		let northWestPanels = SCNNode()
		northWestPanels.addChildNode(thruster)
		
		let eastPanels = SCNNode()
		eastPanels.addChildNode(console)
		eastPanels.addChildNode(PanelHandle(destination: SCNVector3(-1.5,0,0)))
		
		let southEastPanels = SCNNode()
		southEastPanels.addChildNode(hatch)
		
		let southWestPanels = SCNNode()
		southWestPanels.addChildNode(pilot)
		
		let southPanels = SCNNode()
		southPanels.addChildNode(battery)
		southPanels.addChildNode(radio)
		southPanels.addChildNode(radiation)
		southPanels.addChildNode(PanelHandle(destination: SCNVector3(0,0,-1.5)))
		
		let westPanels = SCNNode()
		westPanels.addChildNode(radar)
		westPanels.addChildNode(translator)
		westPanels.addChildNode(targetter)
		westPanels.addChildNode(PanelHandle(destination: SCNVector3(1.5,0,0)))
		
		northPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2))
		northEastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1.5))
		northWestPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 3.5))
		eastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1))
		southEastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0.5))
		southWestPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2.5))
		southPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0))
		westPanels.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 1))
		
		self.addChildNode(northPanels)
		self.addChildNode(northEastPanels)
		self.addChildNode(northWestPanels)
		self.addChildNode(eastPanels)
		self.addChildNode(southEastPanels)
		self.addChildNode(southWestPanels)
		self.addChildNode(southPanels)
		self.addChildNode(westPanels)
		
		/*
		let handle5 = PanelHandle(destination: SCNVector3(0,4,0))
		handle5.eulerAngles.x += Float(degToRad(90))
		self.addChildNode(handle5)
		
		let handle6 = PanelHandle(destination: SCNVector3(0,0,0))
		handle6.eulerAngles.x += Float(degToRad(-100))
		self.addChildNode(handle6)
		*/
		
		self.addChildNode(window)
		self.addChildNode(breaker)
//		monitor = PanelMonitor()
//		self.addChildNode(monitor)
	}
}