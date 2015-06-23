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

extension GameViewController
{
	func worldSetup()
	{
		// Basics
		sceneSetup()
		nodeNetworkSetup()
		
		// Capsule
		capsuleSetup()
		linkSetup()
		
		// Panels
		panel_commander()
		panel_radar()
		panel_navigation()
		panel_thruster()
		
		panel_test()
		
		sceneComplete()
	
		triggersSetup()
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
	
	func capsuleSetup()
	{
		NSLog("WORLD  | Capsule Draw")
		
		// Connect floors
		var i = 0
		while i < floorNode.count
		{
			scene.rootNode.addChildNode(line(floorNode[i],lowMidNode[i]))
			scene.rootNode.addChildNode(line(lowMidNode[i],lowNode[i]))
			scene.rootNode.addChildNode(line(lowNode[i],highNode[i]))
			scene.rootNode.addChildNode(line(highNode[i],highMidNode[i]))
			scene.rootNode.addChildNode(line(highMidNode[i],ceilingNode[i]))
			i += 1
		}
		
		// Connect Floor
		i = 0
		while i < floorNode.count - 1
		{
			scene.rootNode.addChildNode(line(floorNode[i],floorNode[i+1]))
			i += 1
		}
		scene.rootNode.addChildNode(line(floorNode[7],floorNode[0]))
		
		// Connect Window Low
		i = 0
		while i < lowMidNode.count - 1
		{
			scene.rootNode.addChildNode(grey(lowMidNode[i],lowMidNode[i+1]))
			i += 1
		}
		scene.rootNode.addChildNode(grey(lowMidNode[7],lowMidNode[0]))
		
		// Connect Low
		i = 0
		while i < lowNode.count - 1
		{
			scene.rootNode.addChildNode(grey(lowNode[i],lowNode[i+1]))
			i += 1
		}
		scene.rootNode.addChildNode(grey(lowNode[7],lowNode[0]))
		
		// Connect High
		i = 0
		while i < highNode.count - 1
		{
			scene.rootNode.addChildNode(grey(highNode[i],highNode[i+1]))
			i += 1
		}
		scene.rootNode.addChildNode(grey(highNode[7],highNode[0]))
		
		// Connect Window High
		i = 0
		while i < highMidNode.count - 1
		{
			scene.rootNode.addChildNode(grey(highMidNode[i],highMidNode[i+1]))
			i += 1
		}
		scene.rootNode.addChildNode(grey(highMidNode[7],highMidNode[0]))
		
		// Connect Ceiling
		i = 0
		while i < ceilingNode.count - 1
		{
			scene.rootNode.addChildNode(line(ceilingNode[i],ceilingNode[i+1]))
			i += 1
		}
		scene.rootNode.addChildNode(line(ceilingNode[7],ceilingNode[0]))
		
		// Closed windows
		
		scene.rootNode.addChildNode(grey(SCNVector3(x: 0.25, y: ceilingNode[0].y + 2, z: 0.25),SCNVector3(x: -0.25, y: ceilingNode[0].y + 2, z: -0.25)))
		scene.rootNode.addChildNode(grey(SCNVector3(x: 0.25, y: ceilingNode[0].y + 2, z: -0.25),SCNVector3(x: -0.25, y: ceilingNode[0].y + 2, z: 0.25)))
		
	}
	
	// MARK: Scenes
	
	func sceneSetup()
	{
		NSLog("SCENES | Setup")
		scene = SCNScene()
		
		// Camera
		var cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.camera?.xFov = 75
		cameraNode.name = "cameraNode"
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
		cameraNode.camera?.aperture = 100
		cameraNode.camera?.automaticallyAdjustsZRange = true
		scene.rootNode.addChildNode(cameraNode)
	}
	
	func linkSetup()
	{
		let linkC = SCNNode(geometry: SCNSphere(radius: 0.2))
		linkC.name = "trigger.move"
		linkC.position = SCNVector3(x: 0, y: 0, z: 0)
		linkC.geometry?.firstMaterial?.diffuse.contents = red
		scene.rootNode.addChildNode(linkC)
		
		let linkW = SCNNode(geometry: SCNSphere(radius: 0.2))
		linkW.name = "trigger.move"
		linkW.position = SCNVector3(x: -2, y: 0, z: 0)
		linkW.geometry?.firstMaterial?.diffuse.contents = red
		scene.rootNode.addChildNode(linkW)
		
		let linkE = SCNNode(geometry: SCNSphere(radius: 0.2))
		linkE.name = "trigger.move"
		linkE.position = SCNVector3(x: 2, y: 0, z: 0)
		linkE.geometry?.firstMaterial?.diffuse.contents = red
		scene.rootNode.addChildNode(linkE)
		
		let linkN = SCNNode(geometry: SCNSphere(radius: 0.2))
		linkN.name = "trigger.move"
		linkN.position = SCNVector3(x: 0, y: 0, z: 2)
		linkN.geometry?.firstMaterial?.diffuse.contents = red
		scene.rootNode.addChildNode(linkN)
		
		let linkS = SCNNode(geometry: SCNSphere(radius: 0.2))
		linkS.name = "trigger.move"
		linkS.position = SCNVector3(x: 0, y: 0, z: -2)
		linkS.geometry?.firstMaterial?.diffuse.contents = red
		scene.rootNode.addChildNode(linkS)
		
		/*
		let linkT = SCNNode(geometry: SCNSphere(radius: 0.2))
		linkT.name = "trigger.move"
		linkT.position = SCNVector3(x: 0, y: 2, z: 0)
		linkT.geometry?.firstMaterial?.diffuse.contents = red
		scene.rootNode.addChildNode(linkT)
		
		let linkB = SCNNode(geometry: SCNSphere(radius: 0.2))
		linkB.name = "trigger.move"
		linkB.position = SCNVector3(x: 0, y: -2, z: 0)
		linkB.geometry?.firstMaterial?.diffuse.contents = red
		scene.rootNode.addChildNode(linkB)
*/
		
	}
	
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