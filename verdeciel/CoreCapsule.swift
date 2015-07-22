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
	
	override init()
	{
		super.init()
		
		nodeSetup()
		
		capsuleSetup()
		panelSetup()
		linkSetup()
	}
	
	func nodeSetup()
	{
		NSLog("WORLD  | Capsule Coordinates")
		
		var scale:Float = 0.25
		var height:Float = -2.4
		floorNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 0.3
		height = -2.5
		lowMidNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = -1.5
		lowNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		scale = 1
		height = 1.5
		highNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 0.3
		height = 2.5
		highMidNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 0.25
		height = 3
		ceilingNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale), SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
	}
	
	func update()
	{
		radar.update()
		navigation.update()
		monitor.update()
		thruster.update()
		breaker.update()
		beacon.update()
		radio.update()
		console.update()
		scanner.update()
	}
	
	func panelSetup()
	{
		let northPanels = SCNNode()
		navigation = PanelNavigation()
		northPanels.addChildNode(navigation)
		radar = PanelRadar()
		northPanels.addChildNode(radar)
		northPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2)); // rotate 90 degrees
		
		let northEastPanels = SCNNode()
		thruster = PanelThruster()
		northEastPanels.addChildNode(thruster)
		northEastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1.5)); // rotate 90 degrees
		
		let eastPanels = SCNNode()
		breaker = PanelBreaker()
		eastPanels.addChildNode(breaker)
		eastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1)); // rotate 90 degrees
		
		let southEastPanels = SCNNode()
		beacon = PanelBeacon()
		southEastPanels.addChildNode(beacon)
		southEastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0.5)); // rotate 90 degrees
		
		let southPanels = SCNNode()
		radio = PanelRadio()
		southPanels.addChildNode(radio)
		scanner = PanelScanner()
		southPanels.addChildNode(scanner)
		southPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0)); // rotate 90 degrees
		
		let westPanels = SCNNode()
		console = PanelConsole()
		westPanels.addChildNode(console)
		westPanels.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 1)); // rotate 90 degrees
		
		self.addChildNode(northPanels)
		self.addChildNode(northEastPanels)
		self.addChildNode(eastPanels)
		self.addChildNode(southEastPanels)
		self.addChildNode(southPanels)
		self.addChildNode(westPanels)
		
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
			scene.rootNode.addChildNode(SCNLine(nodeA: lowMidNode[i],nodeB: lowNode[i],color:white))
			scene.rootNode.addChildNode(SCNLine(nodeA: lowNode[i],nodeB: highNode[i],color:white))
			scene.rootNode.addChildNode(SCNLine(nodeA: highNode[i],nodeB: highMidNode[i],color:white))
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
		
		scene.rootNode.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.25, y: ceilingNode[0].y + 2, z: 0.25),nodeB: SCNVector3(x: -0.25, y: ceilingNode[0].y + 2, z: -0.25),color:white))
		scene.rootNode.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.25, y: ceilingNode[0].y + 2, z: -0.25),nodeB: SCNVector3(x: -0.25, y: ceilingNode[0].y + 2, z: 0.25),color:white))
	}
	
	func fogEvent()
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		scene.fogStartDistance = 0
		scene.fogEndDistance = 5000
		scene.fogDensityExponent = 4
		scene.fogColor = UIColor.redColor()
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	func fogCapsule()
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		scene.fogStartDistance = 0
		scene.fogEndDistance = 17
		scene.fogDensityExponent = 4
		scene.fogColor = UIColor.blackColor()
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}