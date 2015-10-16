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
	
	var at:CGPoint = universe.loiqe_city.at
	var travel:Float = 0
	
	var direction:CGFloat! = 1
	var sector:sectors = sectors.normal
	var instance:Event!
	
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
		connectDefaultPorts()
		dockbay.start()
	}
	
	// MARK: Breaker -
	
	func setActive()
	{
	}
	
	func setInactive()
	{
	}
	
	// MARK: Docking -
	
	func dock(newDock:Location)
	{
		dock = newDock
		custom.dock(dock)
		thruster.disable()
		dockbay.update()
	}
	
	func undock()
	{
		dock = nil
		custom.undock()
		thruster.enable()
	}
	
	func connectDefaultPorts()
	{
		battery.output.connect(thruster.input)
		battery.outCell1.connect(battery.inOxygen)
		cargo.output.connect(console.input)
		radar.output.connect(pilot.input)
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
			var line = SCNLine(nodeA: SCNVector3(-0.1,-3,templates.radius), nodeB: SCNVector3(0.1,-3,templates.radius), color: grey)
			line.eulerAngles.y += Float(degToRad(CGFloat(i) * 4))
			mesh.addChildNode(line)
			if i <= 50 && i >= 32 || i >= 85 || i <= 13 || i == 17 || i >= 65 && i <= 69 {
			}
			else{
				line = SCNLine(nodeA: SCNVector3(0,0.1,templates.radius), nodeB: SCNVector3(0,-0.1,templates.radius), color: grey)
				line.eulerAngles.x += Float(degToRad(CGFloat(i) * 4))
				mesh.addChildNode(line)
			}
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
		custom = PanelQuest()
		dockbay = PanelDock()
		northPanels.addChildNode(custom)
		northPanels.addChildNode(dockbay)
		let handle1 = PanelHandle()
		handle1.destination = SCNVector3(0,0,1.5)
		northPanels.addChildNode(handle1)
		
		let northEastPanels = SCNNode()
		cargo = PanelCargo()
		northEastPanels.addChildNode(cargo)
		
		let northWestPanels = SCNNode()
		thruster = PanelThruster()
		northWestPanels.addChildNode(thruster)
		
		let eastPanels = SCNNode()
		console = PanelConsole()
		eastPanels.addChildNode(console)
		let handle2 = PanelHandle()
		handle2.destination = SCNVector3(-1.5,0,0)
		eastPanels.addChildNode(handle2)
		
		let southEastPanels = SCNNode()
		beacon = PanelHatch()
		southEastPanels.addChildNode(beacon)
		
		let southWestPanels = SCNNode()
		pilot = PanelPilot()
		southWestPanels.addChildNode(pilot)
		
		let southPanels = SCNNode()
		battery = PanelBattery()
		radiation = PanelRadiation()
		radio = PanelRadio()
		southPanels.addChildNode(battery)
		southPanels.addChildNode(radio)
		southPanels.addChildNode(radiation)
		let handle3 = PanelHandle()
		handle3.destination = SCNVector3(0,0,-1.5)
		southPanels.addChildNode(handle3)
		
		let westPanels = SCNNode()
		radar = PanelRadar()
		translator = PanelTranslator()
		targetter = PanelTargetter()
		westPanels.addChildNode(radar)
		westPanels.addChildNode(translator)
		westPanels.addChildNode(targetter)
		let handle4 = PanelHandle()
		handle4.destination = SCNVector3(1.5,0,0)
		westPanels.addChildNode(handle4)
		
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
		
		let handle5 = PanelHandle()
		handle5.destination = SCNVector3(0,4,0)
		handle5.eulerAngles.x += Float(degToRad(90))
		self.addChildNode(handle5)
		
		let handle6 = PanelHandle()
		handle6.destination = SCNVector3(0,0,0)
		handle6.eulerAngles.x += Float(degToRad(-100))
		self.addChildNode(handle6)
		
		window = PanelWindow()
		self.addChildNode(window)
		breaker = PanelBreaker()
		self.addChildNode(breaker)
//		monitor = PanelMonitor()
//		self.addChildNode(monitor)
	}
}