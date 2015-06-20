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

extension GameViewController
{
	func worldSetup()
	{
		sceneSetup()
		objectSetup()
		createCapsule()
		sceneComplete()
	}
	
	func createCapsule()
	{
		NSLog("WORLD  | Setup")
		
		var scale:Float = 0.25
		var height:Float = -2
		
		let floor1 = SCNVector3(x: 2 * scale, y: height, z: -4 * scale)
		let floor2 = SCNVector3(x: 4 * scale, y: height, z: -2 * scale)
		let floor3 = SCNVector3(x: 4 * scale, y: height, z: 2 * scale)
		let floor4 = SCNVector3(x: 2 * scale, y: height, z: 4 * scale)
		let floor5 = SCNVector3(x: -2 * scale, y: height, z: 4 * scale)
		let floor6 = SCNVector3(x: -4 * scale, y: height, z: 2 * scale)
		let floor7 = SCNVector3(x: -4 * scale, y: height, z: -2 * scale)
		let floor8 = SCNVector3(x: -2 * scale, y: height, z: -4 * scale)
		
		scene.rootNode.addChildNode(lineBetweenNodeA(floor1,floor2))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor2,floor3))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor3,floor4))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor4,floor5))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor5,floor6))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor6,floor7))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor7,floor8))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor8,floor1))
		
		height = 2
		
		let ceiling1 = SCNVector3(x: 2 * scale, y: height, z: -4 * scale)
		let ceiling2 = SCNVector3(x: 4 * scale, y: height, z: -2 * scale)
		let ceiling3 = SCNVector3(x: 4 * scale, y: height, z: 2 * scale)
		let ceiling4 = SCNVector3(x: 2 * scale, y: height, z: 4 * scale)
		let ceiling5 = SCNVector3(x: -2 * scale, y: height, z: 4 * scale)
		let ceiling6 = SCNVector3(x: -4 * scale, y: height, z: 2 * scale)
		let ceiling7 = SCNVector3(x: -4 * scale, y: height, z: -2 * scale)
		let ceiling8 = SCNVector3(x: -2 * scale, y: height, z: -4 * scale)
		
		scene.rootNode.addChildNode(lineBetweenNodeA(ceiling1,ceiling2))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceiling2,ceiling3))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceiling3,ceiling4))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceiling4,ceiling5))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceiling5,ceiling6))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceiling6,ceiling7))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceiling7,ceiling8))
		scene.rootNode.addChildNode(lineBetweenNodeA(ceiling8,ceiling1))
		
		scale = 1
		height = -1.5
		
		let lowRing1 = SCNVector3(x: 2 * scale, y: height, z: -4 * scale)
		let lowRing2 = SCNVector3(x: 4 * scale, y: height, z: -2 * scale)
		let lowRing3 = SCNVector3(x: 4 * scale, y: height, z: 2 * scale)
		let lowRing4 = SCNVector3(x: 2 * scale, y: height, z: 4 * scale)
		let lowRing5 = SCNVector3(x: -2 * scale, y: height, z: 4 * scale)
		let lowRing6 = SCNVector3(x: -4 * scale, y: height, z: 2 * scale)
		let lowRing7 = SCNVector3(x: -4 * scale, y: height, z: -2 * scale)
		let lowRing8 = SCNVector3(x: -2 * scale, y: height, z: -4 * scale)
		
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing1,lowRing2))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing2,lowRing3))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing3,lowRing4))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing4,lowRing5))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing5,lowRing6))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing6,lowRing7))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing7,lowRing8))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing8,lowRing1))
		
		scale = 1
		height = 1.5
		
		let highRing1 = SCNVector3(x: 2 * scale, y: height, z: -4 * scale)
		let highRing2 = SCNVector3(x: 4 * scale, y: height, z: -2 * scale)
		let highRing3 = SCNVector3(x: 4 * scale, y: height, z: 2 * scale)
		let highRing4 = SCNVector3(x: 2 * scale, y: height, z: 4 * scale)
		let highRing5 = SCNVector3(x: -2 * scale, y: height, z: 4 * scale)
		let highRing6 = SCNVector3(x: -4 * scale, y: height, z: 2 * scale)
		let highRing7 = SCNVector3(x: -4 * scale, y: height, z: -2 * scale)
		let highRing8 = SCNVector3(x: -2 * scale, y: height, z: -4 * scale)
		
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing1,highRing2))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing2,highRing3))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing3,highRing4))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing4,highRing5))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing5,highRing6))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing6,highRing7))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing7,highRing8))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing8,highRing1))
		
		
		
		scene.rootNode.addChildNode(lineBetweenNodeA(floor1,lowRing1))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing1,highRing1))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing1,ceiling1))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor2,lowRing2))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing2,highRing2))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing2,ceiling2))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor3,lowRing3))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing3,highRing3))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing3,ceiling3))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor4,lowRing4))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing4,highRing4))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing4,ceiling4))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor5,lowRing5))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing5,highRing5))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing5,ceiling5))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor6,lowRing6))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing6,highRing6))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing6,ceiling6))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor7,lowRing7))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing7,highRing7))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing7,ceiling7))
		scene.rootNode.addChildNode(lineBetweenNodeA(floor8,lowRing8))
		scene.rootNode.addChildNode(lineBetweenNodeA(lowRing8,highRing8))
		scene.rootNode.addChildNode(lineBetweenNodeA(highRing8,ceiling8))
		
		
		scene.rootNode.addChildNode(redLine(lowRing1,highRing8))
		scene.rootNode.addChildNode(redLine(lowRing8,highRing1))
		
		
		
		
		
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
		
		// create and add an ambient light to the scene
		let ambientLightNode = SCNNode()
		ambientLightNode.light = SCNLight()
		ambientLightNode.light!.type = SCNLightTypeAmbient
		ambientLightNode.light!.color = UIColor.grayColor()
		scene.rootNode.addChildNode(ambientLightNode)
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