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
	var electricity:Float = 100.0
	var shield:Float = 100.0
	var temperature:Float = 100.0
	var oxygen:Float = 50.0
	var hull:Float = 100.0
	var radiation:Float = 100.0
	
	var location:CGPoint = CGPoint()
	
	var direction:CGFloat! = 1
	
	override init()
	{
		super.init()
		
		self.direction = 0
		nodeSetup()
		
		capsuleSetup()
		panelSetup()
		linkSetup()
		
		capsuleMesh()
		
		connectDefaultPorts()
	}
	
	func connectDefaultPorts()
	{
		battery.outCell1.connect(battery.inOxygen)
		battery.outCell2.connect(battery.inShield)
		battery.outCell3.connect(battery.inRepair)
		
		battery.output.connect(thruster.input)
		
		radar.output.connect(pilot.input)
		
		cargo.output.connect(console.input)
	}
	
	func nodeSetup()
	{
		NSLog("WORLD  | Capsule Coordinates")
		
		var scale:Float = 0.25
		var height:Float = -2.65
		floorNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 0.3
		height = -2.75
		lowMidNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = -2.4
		lowGapNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = -1.5
		lowNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		scale = 1
		height = 1.5
		highNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = 2.4
		highGapNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 0.3
		height = 2.5
		highMidNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 0.25
		height = 3
		ceilingNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale), SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
	}
	
	override func update()
	{
		radar.update()
		pilot.update()
		monitor.update()
		thruster.update()
		beacon.update()
		console.update()
	}
	
	func panelSetup()
	{
		let northPanels = SCNNode()
		
		let northEastPanels = SCNNode()
		cargo = PanelCargo()
		northEastPanels.addChildNode(cargo)
		
		let northWestPanels = SCNNode()
		thruster = PanelThruster()
		northWestPanels.addChildNode(thruster)
		
		let eastPanels = SCNNode()
		console = PanelConsole()
		eastPanels.addChildNode(console)
		
		let southEastPanels = SCNNode()
		beacon = PanelHatch()
		southEastPanels.addChildNode(beacon)
		
		let southWestPanels = SCNNode()
		pilot = PanelPilot()
		southWestPanels.addChildNode(pilot)
		
		let southPanels = SCNNode()
		battery = PanelBattery()
		radio = PanelRadio()
		southPanels.addChildNode(battery)
		southPanels.addChildNode(radio)
		
		let westPanels = SCNNode()
		radar = PanelRadar()
		translator = PanelTranslator()
		westPanels.addChildNode(radar)
		westPanels.addChildNode(translator)
		
		northPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2))
		northEastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1.5))
		northWestPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 3.5))
		eastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1))
		southEastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0.5))
		southWestPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2.5))
		southPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0))
		westPanels.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 1))
		
		window = PanelWindow()
		
		self.addChildNode(northPanels)
		self.addChildNode(northEastPanels)
		self.addChildNode(northWestPanels)
		self.addChildNode(eastPanels)
		self.addChildNode(southEastPanels)
		self.addChildNode(southWestPanels)
		self.addChildNode(southPanels)
		self.addChildNode(westPanels)
		
		self.addChildNode(window)
		
		monitor = PanelMonitor()
		self.addChildNode(monitor)
	}
	
	func linkSetup()
	{
		let northNode = SCNLink(location: SCNVector3(x: 0, y: 0, z: -4.5), newDestination: SCNVector3(x: 0, y: 0, z: -1), scale: 6)
		scene.rootNode.addChildNode(northNode)
		
		let southNode = SCNLink(location: SCNVector3(x: 0, y: 0, z: 4.5), newDestination: SCNVector3(x: 0, y: 0, z: 1), scale: 6)
		southNode.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 2));
		scene.rootNode.addChildNode(southNode)
		
		let eastNode = SCNLink(location: SCNVector3(x: 4.5, y: 0, z: 0), newDestination: SCNVector3(x: 1, y: 0, z: 0), scale: 6)
		eastNode.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 1));
		scene.rootNode.addChildNode(eastNode)
		
		let westNode = SCNLink(location: SCNVector3(x: -4.5, y: 0, z: 0), newDestination: SCNVector3(x: -1, y: 0, z: 0), scale: 6)
		westNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1));
		scene.rootNode.addChildNode(westNode)
		
		let northWestNode = SCNLink(location: SCNVector3(x: -4, y: 0, z: -4), newDestination: SCNVector3(x: -1, y: 0, z: -1), scale: 6)
		northWestNode.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 3.5));
		scene.rootNode.addChildNode(northWestNode)
		
		let northEastNode = SCNLink(location: SCNVector3(x: 4, y: 0, z: -4), newDestination: SCNVector3(x: 1, y: 0, z: -1), scale: 6)
		northEastNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 3.5));
		scene.rootNode.addChildNode(northEastNode)
		
		let southWestNode = SCNLink(location: SCNVector3(x: -4, y: 0, z: 4), newDestination: SCNVector3(x: -1, y: 0, z: 1), scale: 6)
		southWestNode.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 2.5));
		scene.rootNode.addChildNode(southWestNode)
		
		let southEastNode = SCNLink(location: SCNVector3(x: 4, y: 0, z: 4), newDestination: SCNVector3(x: 1, y: 0, z: 1), scale: 6)
		southEastNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2.5));
		scene.rootNode.addChildNode(southEastNode)
		
		let topNode = SCNLink(location: SCNVector3(x: 0, y: 4, z: 0), newDestination: SCNVector3(x: 0, y: 1, z: 0), scale: 9)
		topNode.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 1));
		scene.rootNode.addChildNode(topNode)
		
		let bottomNode = SCNLink(location: SCNVector3(x: 0, y: -4, z: 0), newDestination: SCNVector3(x: 0, y: -1, z: 0), scale: 9)
		bottomNode.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 1));
		scene.rootNode.addChildNode(bottomNode)
		
		let windowNode = SCNLink(location: SCNVector3(x: 0, y: 3.5, z: 0), newDestination: SCNVector3(x: 0, y: 3.5, z: 0), scale: 4)
		windowNode.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 1));
		scene.rootNode.addChildNode(windowNode)
	}
	
	func capsuleSetup()
	{
		NSLog("WORLD  | Capsule Draw")
		
		// Connect floors
		var i = 0
		while i < floorNode.count
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: floorNode[i],nodeB: lowMidNode[i],color:white))
			scene.rootNode.addChildNode(SCNLine(nodeA: lowMidNode[i],nodeB: lowGapNode[i],color:white))
			scene.rootNode.addChildNode(SCNLine(nodeA: lowGapNode[i],nodeB: highGapNode[i],color:white))
			scene.rootNode.addChildNode(SCNLine(nodeA: highGapNode[i],nodeB: highMidNode[i],color:white))
			scene.rootNode.addChildNode(SCNLine(nodeA: highMidNode[i],nodeB: ceilingNode[i],color:white))
			i += 1
		}
		
		// Connect Floor
		i = 0
		while i < floorNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: floorNode[i],nodeB: floorNode[i+1],color:white))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: floorNode[7],nodeB: floorNode[0],color:white))
		
		// Connect Window Low
		i = 0
		while i < lowMidNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: lowMidNode[i],nodeB: lowMidNode[i+1],color:white))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: lowMidNode[7],nodeB: lowMidNode[0],color:white))
		
		// Connect Low Gap
		i = 0
		while i < lowGapNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: lowGapNode[i],nodeB: lowGapNode[i+1],color:grey))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: lowGapNode[7],nodeB: lowGapNode[0],color:grey))
		
		// Connect Low
		i = 0
		while i < lowNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: lowNode[i],nodeB: lowNode[i+1],color:white))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: lowNode[7],nodeB: lowNode[0],color:white))
		
		// Connect High
		i = 0
		while i < highNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: highNode[i],nodeB: highNode[i+1],color:white))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: highNode[7],nodeB: highNode[0],color:white))
		
		// Connect High Gap
		i = 0
		while i < highGapNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: highGapNode[i],nodeB: highGapNode[i+1],color:grey))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: highGapNode[7],nodeB: highGapNode[0],color:grey))
		
		// Connect Window High
		i = 0
		while i < highMidNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: highMidNode[i],nodeB: highMidNode[i+1],color:white))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: highMidNode[7],nodeB: highMidNode[0],color:white))
		
		// Connect Ceiling
		i = 0
		while i < ceilingNode.count - 1
		{
			scene.rootNode.addChildNode(SCNLine(nodeA: ceilingNode[i],nodeB: ceilingNode[i+1],color:white))
			i += 1
		}
		scene.rootNode.addChildNode(SCNLine(nodeA: ceilingNode[7],nodeB: ceilingNode[0],color:white))
		
		// Closed windows
	}
	
	func capsuleMesh()
	{
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}