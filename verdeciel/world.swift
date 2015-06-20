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
		capsuleSetup()
		objectSetup()
		sceneComplete()
		
		doorClose()
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
	
	func capsuleSetup()
	{
		NSLog("CAPSUL | Setup")
		
		let meshLibrary = SCNScene(named: "art.scnassets/source.dae")
	
		let mainCapsule = meshLibrary?.rootNode.childNodeWithName("mainCapsule", recursively: true)!
		mainCapsule?.scale = SCNVector3(x: scaleValue, y: scaleValue, z: scaleValue)
		mainCapsule?.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(mainCapsule!)
		
		let radarCapsule = meshLibrary?.rootNode.childNodeWithName("radarCapsule", recursively: true)!
		radarCapsule?.scale = SCNVector3(x: scaleValue, y: scaleValue, z: scaleValue)
		radarCapsule?.position = SCNVector3(x: 0, y: 0, z: 10)
		scene.rootNode.addChildNode(radarCapsule!)
		
		let comCapsule = meshLibrary?.rootNode.childNodeWithName("comCapsule", recursively: true)!
		comCapsule?.scale = SCNVector3(x: scaleValue, y: scaleValue, z: scaleValue)
		comCapsule?.position = SCNVector3(x: 0, y: 0, z: -10)
		scene.rootNode.addChildNode(comCapsule!)
		
		let spaceFar = meshLibrary?.rootNode.childNodeWithName("space", recursively: true)!
		spaceFar?.scale = SCNVector3(x: 1, y: 1, z: 1)
		spaceFar?.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(spaceFar!)
		
		scene.rootNode.childNodeWithName("space", recursively: true)!.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 0, z: 2, duration: 20)))
	}
	
	func objectSetup()
	{
		let sphere = SCNSphere(radius: 3)
		let sphereNode = SCNNode(geometry: sphere)
		sphereNode.name = "trigger.move"
		sphereNode.position = SCNVector3(x: 0, y: 0, z: 10)
		sphereNode.opacity = 0.01
		scene.rootNode.addChildNode(sphereNode)
		
		let camCapsuleLinkMesh = SCNSphere(radius: 3)
		let camCapsuleLink = SCNNode(geometry: camCapsuleLinkMesh)
		camCapsuleLink.name = "trigger.move"
		camCapsuleLink.position = SCNVector3(x: 0, y: 0, z: -10)
		camCapsuleLink.opacity = 0.01
		scene.rootNode.addChildNode(camCapsuleLink)
		
		let sphere3 = SCNSphere(radius: 3)
		let sphereNode3 = SCNNode(geometry: sphere3)
		sphereNode3.name = "trigger.move"
		sphereNode3.position = SCNVector3(x: 0, y: 0, z: 0)
		sphereNode3.opacity = 0.01
		scene.rootNode.addChildNode(sphereNode3)
	}
	
	func sceneComplete()
	{
		// Fix textures
		scene.rootNode.childNodeWithName("door.window.mesh", recursively: true)!.geometry?.firstMaterial?.transparency = 0.1
		scene.rootNode.childNodeWithName("trigger.power", recursively: true)!.geometry?.firstMaterial?.transparency = 0
		
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