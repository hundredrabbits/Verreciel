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
	func worldStart()
	{
		sceneSetup()
		capsuleSetup()
		objectSetup()
		sceneComplete()
	}
	
	func sceneSetup()
	{
		NSLog("SCENE | Setup")
		scene = SCNScene()
		
		scene.fogStartDistance = 0
		scene.fogEndDistance = 17
		scene.fogDensityExponent = 4
		scene.fogColor = UIColor.blackColor()
		
		// Camera
		var cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.camera?.xFov = 75
		cameraNode.name = "cameraNode"
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
		cameraNode.camera?.aperture = 100
		cameraNode.camera?.automaticallyAdjustsZRange = 1
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
		NSLog("CAPSL | Setup")
		
		let meshLibrary = SCNScene(named: "art.scnassets/source.dae")
		
		let mainCapsule = meshLibrary.rootNode.childNodeWithName("mainCapsule", recursively: true)!
		mainCapsule.scale = SCNVector3(x: scaleValue, y: scaleValue, z: scaleValue)
		mainCapsule.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(mainCapsule)
		
		let radarCapsule = meshLibrary.rootNode.childNodeWithName("radarCapsule", recursively: true)!
		radarCapsule.scale = SCNVector3(x: scaleValue, y: scaleValue, z: scaleValue)
		radarCapsule.position = SCNVector3(x: 0, y: 0, z: 10)
		scene.rootNode.addChildNode(radarCapsule)
		
		let comCapsule = meshLibrary.rootNode.childNodeWithName("comCapsule", recursively: true)!
		comCapsule.scale = SCNVector3(x: scaleValue, y: scaleValue, z: scaleValue)
		comCapsule.position = SCNVector3(x: 0, y: 0, z: -10)
		scene.rootNode.addChildNode(comCapsule)
	}
	
	func objectSetup()
	{
		let sphere = SCNSphere(radius: 1.5)
		let sphereNode = SCNNode(geometry: sphere)
		sphereNode.name = "link"
		sphereNode.position = SCNVector3(x: 0, y: 0, z: 10)
		sphereNode.opacity = 0.01
		scene.rootNode.addChildNode(sphereNode)
		
		let camCapsuleLinkMesh = SCNSphere(radius: 1.5)
		let camCapsuleLink = SCNNode(geometry: camCapsuleLinkMesh)
		camCapsuleLink.name = "link"
		camCapsuleLink.position = SCNVector3(x: 0, y: 0, z: -10)
		camCapsuleLink.opacity = 0.01
		scene.rootNode.addChildNode(camCapsuleLink)
		
		let sphere3 = SCNSphere(radius: 1.5)
		let sphereNode3 = SCNNode(geometry: sphere3)
		sphereNode3.name = "link"
		sphereNode3.position = SCNVector3(x: 0, y: 0, z: 0)
		sphereNode3.opacity = 0.01
		scene.rootNode.addChildNode(sphereNode3)
	}
	
	func sceneComplete()
	{
		scene.rootNode.childNodeWithName("door.window.mesh", recursively: true)!.opacity = 0.2
		
		// retrieve the SCNView
		let scnView = self.view as SCNView
		
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
		scnView.gestureRecognizers = gestureRecognizers
	}	
}