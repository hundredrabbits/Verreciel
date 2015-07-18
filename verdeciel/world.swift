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

var time:NSTimer!

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
	case sentry
}

extension GameViewController
{
	func worldSetup()
	{
		capsule = CapsuleNode()
		scene.rootNode.addChildNode(capsule)
		
		player = PlayerNode()
		scene.rootNode.addChildNode(player)
		
		sceneComplete()
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