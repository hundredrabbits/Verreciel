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

extension GameViewController {
	
	func sceneSetup()
	{
		NSLog("SCENE | Setup")
		scene = SCNScene(named: "art.scnassets/source.dae")
		
		scene.fogStartDistance = 0
		scene.fogEndDistance = 10
		scene.fogDensityExponent = 4
		scene.fogColor = UIColor.blackColor()
		
		// Camera
		var cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.camera?.xFov = 65
		cameraNode.name = "cameraNode"
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(cameraNode)
		
		// create and add a light to the scene
//		let lightNode = SCNNode()
//		lightNode.light = SCNLight()
//		lightNode.light!.type = SCNLightTypeOmni
//		lightNode.position = SCNVector3(x: 0, y: 20, z: 0)
//		scene.rootNode.addChildNode(lightNode)
		
		// create and add an ambient light to the scene
		let ambientLightNode = SCNNode()
		ambientLightNode.light = SCNLight()
		ambientLightNode.light!.type = SCNLightTypeAmbient
		ambientLightNode.light!.color = UIColor.grayColor()
		scene.rootNode.addChildNode(ambientLightNode)
	}
	
	func capsuleSetup()
	{
		NSLog("CAPSL | Setup")
		
		let meshLibrary = SCNScene(named: "art.scnassets/source.dae")
		
		let scaleValue : Float = 0.0055
		
		let mainCapsule = meshLibrary.rootNode.childNodeWithName("mainCapsule", recursively: true)!
		mainCapsule.scale = SCNVector3(x: scaleValue, y: scaleValue, z: scaleValue)
		mainCapsule.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(mainCapsule)
		
		let supportCapsule = meshLibrary.rootNode.childNodeWithName("supportCapsule", recursively: true)!
		supportCapsule.scale = SCNVector3(x: scaleValue, y: scaleValue, z: scaleValue)
		supportCapsule.position = SCNVector3(x: 0, y: 0, z: 5)
		scene.rootNode.addChildNode(supportCapsule)
		
		let radarCapsule = meshLibrary.rootNode.childNodeWithName("radarCapsule", recursively: true)!
		radarCapsule.scale = SCNVector3(x: scaleValue, y: scaleValue, z: scaleValue)
		radarCapsule.position = SCNVector3(x: 0, y: 0, z: -5)
		scene.rootNode.addChildNode(radarCapsule)
	}
	
	func objectSetup()
	{
		let sphere = SCNSphere(radius: 0.2)
		let sphereNode = SCNNode(geometry: sphere)
		sphereNode.name = "link"
		sphereNode.position = SCNVector3(x: 0, y: 0, z: 5)
		scene.rootNode.addChildNode(sphereNode)
		
		let sphere2 = SCNSphere(radius: 0.2)
		let sphereNode2 = SCNNode(geometry: sphere2)
		sphereNode2.name = "link"
		sphereNode2.position = SCNVector3(x: 0, y: 0, z: -5)
		scene.rootNode.addChildNode(sphereNode2)
		
		let sphere3 = SCNSphere(radius: 0.2)
		let sphereNode3 = SCNNode(geometry: sphere2)
		sphereNode3.name = "link"
		sphereNode3.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(sphereNode3)
	}
	
	func sceneComplete()
	{
		// retrieve the SCNView
		let scnView = self.view as SCNView
		
		// set the scene to the view
		scnView.scene = scene
		
		// show statistics such as fps and timing information
		scnView.showsStatistics = false
		
		// configure the view
		scnView.backgroundColor = UIColor.blackColor()
		
		// add a tap gesture recognizer
		let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
		let gestureRecognizers = NSMutableArray()
		gestureRecognizers.addObject(tapGesture)
		if let existingGestureRecognizers = scnView.gestureRecognizers {
			gestureRecognizers.addObjectsFromArray(existingGestureRecognizers)
		}
		scnView.gestureRecognizers = gestureRecognizers
	}	
}