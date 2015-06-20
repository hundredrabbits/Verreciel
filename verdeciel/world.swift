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
var highNode:Array<SCNVector3>!
var lowNode:Array<SCNVector3>!
var floorNode:Array<SCNVector3>!

extension GameViewController
{
	
	func worldSetup()
	{
		sceneSetup()
		
		capsuleCoordinates()
		capsuleDraw()
		
		objectSetup()
		sceneComplete()
	}
	
	func capsuleCoordinates()
	{
		NSLog("WORLD  | Capsule Coordinates")
		
		var scale:Float = 0.25
		var height:Float = -2
		
		floorNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]

		height = 2
		ceilingNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale), SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = -1.5
		
		lowNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = 1.5
		
		highNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
	}
	
	func capsuleDraw()
	{
		NSLog("WORLD  | Capsule Draw")
		
		// Draw Floor
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[0],floorNode[1]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[1],floorNode[2]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[2],floorNode[3]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[3],floorNode[4]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[4],floorNode[5]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[5],floorNode[6]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[6],floorNode[7]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[7],floorNode[0]))
		
		// Draw Low Ring
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[0],lowNode[1]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[1],lowNode[2]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[2],lowNode[3]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[3],lowNode[4]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[4],lowNode[5]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[5],lowNode[6]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[6],lowNode[7]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[7],lowNode[0]))
		
		// Draw High Ring
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[0],highNode[1]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[1],highNode[2]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[2],highNode[3]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[3],highNode[4]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[4],highNode[5]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[5],highNode[6]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[6],highNode[7]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[7],highNode[0]))
		
		// Draw Ceiling
		scene.rootNode.addChildNode(lineBetweenNodeA(ceilingNode[0],ceilingNode[1]))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceilingNode[1],ceilingNode[2]))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceilingNode[2],ceilingNode[3]))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceilingNode[3],ceilingNode[4]))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceilingNode[4],ceilingNode[5]))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceilingNode[5],ceilingNode[6]))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceilingNode[6],ceilingNode[7]))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceilingNode[7],ceilingNode[0]))
		
		// Connect floors
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[0],lowNode[0]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[0],highNode[0]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[0],ceilingNode[0]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[1],lowNode[1]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[1],highNode[1]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[1],ceilingNode[1]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[2],lowNode[2]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[2],highNode[2]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[2],ceilingNode[2]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[3],lowNode[3]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[3],highNode[3]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[3],ceilingNode[3]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[4],lowNode[4]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[4],highNode[4]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[4],ceilingNode[4]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[5],lowNode[5]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[5],highNode[5]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[5],ceilingNode[5]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[6],lowNode[6]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[6],highNode[6]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[6],ceilingNode[6]))
		scene.rootNode.addChildNode(lineBetweenNodeA(floorNode[7],lowNode[7]))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowNode[7],highNode[7]))
		scene.rootNode.addChildNode(lineBetweenNodeA(highNode[7],ceilingNode[7]))
	}
	
	func sceneSetup()
	{
		NSLog("SCENES | Setup")
		scene = SCNScene()
		
		fogCapsule()
		
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
	
	func objectSetup()
	{
		let sphere = SCNSphere(radius: 0.5)
		let sphereNode = SCNNode(geometry: sphere)
		sphereNode.name = "trigger.move"
		sphereNode.position = SCNVector3(x: 0, y: 0, z: 10)
		scene.rootNode.addChildNode(sphereNode)
		
		let sphere3 = SCNSphere(radius: 0.5)
		let sphereNode3 = SCNNode(geometry: sphere3)
		sphereNode3.name = "trigger.move"
		sphereNode3.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(sphereNode3)
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
		scnView.tintAdjustmentMode = UIViewTintAdjustmentMode.Dimmed
		
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