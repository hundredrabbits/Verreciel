//
//  extraFile.swift
//  verdeciel
//
//  Created by Devine Lu Linvega on 2014-09-25.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//
import UIKit
import QuartzCore
import SceneKit
import Foundation

var ceilingNode:Array<SCNVector3>!
var highMidNode:Array<SCNVector3>!
var highNode:Array<SCNVector3>!
var lowNode:Array<SCNVector3>!
var lowMidNode:Array<SCNVector3>!
var floorNode:Array<SCNVector3>!

var radar:PanelRadar!
var navigation:PanelNavigation!
var monitor:PanelMonitor!
var thruster:PanelThruster!
var breaker:PanelBreaker!
var beacon:PanelBeacon!
var radio:PanelRadio!
var console:PanelConsole!
var scanner:PanelScanner!

var capsule:CapsuleNode!
var player:PlayerNode!

enum alignment {
	case left
	case center
	case right
}
enum cardinals {
	case n
	case ne
	case e
	case se
	case s
	case sw
	case w
	case nw
}
enum eventTypes {
	case unknown
	case station
	case star
}

extension GameViewController
{
	func worldSetup()
	{
		// Basics
		nodeNetworkSetup()
		
		//
		
		capsule = CapsuleNode()
		scene.rootNode.addChildNode(capsule)
		
		player = PlayerNode()
		scene.rootNode.addChildNode(player)
		
		//
		
		var northPanels = SCNNode()
		navigation = PanelNavigation()
		northPanels.addChildNode(navigation)
		radar = PanelRadar()
		northPanels.addChildNode(radar)
		northPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2)); // rotate 90 degrees
		
		//
		
		var northEastPanels = SCNNode()
		thruster = PanelThruster()
		northEastPanels.addChildNode(thruster)
		northEastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1.5)); // rotate 90 degrees
		
		//
		
		var eastPanels = SCNNode()
		breaker = PanelBreaker()
		eastPanels.addChildNode(breaker)
		eastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1)); // rotate 90 degrees
		
		//
		
		var southEastPanels = SCNNode()
		beacon = PanelBeacon()
		southEastPanels.addChildNode(beacon)
		southEastPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0.5)); // rotate 90 degrees
		
		//
		
		var southPanels = SCNNode()
		radio = PanelRadio()
		southPanels.addChildNode(radio)
		scanner = PanelScanner()
		southPanels.addChildNode(scanner)
		southPanels.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0)); // rotate 90 degrees
		
		//
		
		var westPanels = SCNNode()
		console = PanelConsole()
		westPanels.addChildNode(console)
		westPanels.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 1)); // rotate 90 degrees

		// Add
		
		scene.rootNode.addChildNode(northPanels)
		scene.rootNode.addChildNode(northEastPanels)
		scene.rootNode.addChildNode(eastPanels)
		scene.rootNode.addChildNode(southEastPanels)
		scene.rootNode.addChildNode(southPanels)
		scene.rootNode.addChildNode(westPanels)
		
		monitor = PanelMonitor()
		scene.rootNode.addChildNode(monitor)
		
		radio.update()
		
		//
		
		radar.addEvent(SCNEvent(newName:"su-ar37",x:0,z:2,size:1,range:5,type:eventTypes.star))
		radar.addEvent(SCNEvent(newName:"home",x:0,z:0,size:1,range:5,type:eventTypes.station))
		radar.addEvent(SCNEvent(newName:"asteroid",x:0.5,z:0.5,size:0.5,range:0,type:eventTypes.unknown))
		
		console.addLine("hello there")
		console.addLine("how are you")
		console.addLine("0123456789")
		console.addLine("a,b,c,d,e,f,g")
		console.addLine("")
		console.addLine("halt catch fire")
		console.addLine("")
		console.addLine("bios")
		console.addLine("bias")
		console.addLine("ftw")
		
		sceneComplete()
	}
	
	func nodeNetworkSetup()
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
	
	// MARK: Scenes
	
	func sceneComplete()
	{
		// retrieve the SCNView
		let scnView = self.view as! SCNView
		
		// set the scene to the view
		scnView.scene = scene
		
		// show statistics such as fps and timing information
		scnView.showsStatistics = false
		
		// configure the view
		scnView.backgroundColor = UIColor.blackColor()
		
		scnView.antialiasingMode = SCNAntialiasingMode.None
		
		scnView.tintColor = UIColor.redColor()
//		scnView.tintAdjustmentMode = UIViewTintAdjustmentMode.Dimmed
		
		// add a tap gesture recognizer
		let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
		let gestureRecognizers = NSMutableArray()
		gestureRecognizers.addObject(tapGesture)
		if let existingGestureRecognizers = scnView.gestureRecognizers {
			gestureRecognizers.addObjectsFromArray(existingGestureRecognizers)
		}
		scnView.gestureRecognizers = gestureRecognizers as [AnyObject]
	}	
}