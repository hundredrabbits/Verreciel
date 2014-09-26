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
		scene = SCNScene(named: "art.scnassets/source.dae")
		
		// Camera
		var cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.name = "cameraNode"
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(cameraNode)
		
		// create and add a light to the scene
		let lightNode = SCNNode()
		lightNode.light = SCNLight()
		lightNode.light!.type = SCNLightTypeOmni
		lightNode.position = SCNVector3(x: 0, y: 20, z: 0)
		scene.rootNode.addChildNode(lightNode)
		
		// create and add an ambient light to the scene
		let ambientLightNode = SCNNode()
		ambientLightNode.light = SCNLight()
		ambientLightNode.light!.type = SCNLightTypeAmbient
		ambientLightNode.light!.color = UIColor.grayColor()
		scene.rootNode.addChildNode(ambientLightNode)
	}
	
	func objectSetup()
	{
		let sphere = SCNSphere(radius: 0.2)
		let sphereNode = SCNNode(geometry: sphere)
		sphereNode.name = "sphere"
		sphereNode.position = SCNVector3(x: 0, y: 0, z: 10)
		scene.rootNode.addChildNode(sphereNode)
		
		let sphere2 = SCNSphere(radius: 0.2)
		let sphereNode2 = SCNNode(geometry: sphere2)
		sphereNode2.name = "sphere2"
		sphereNode2.position = SCNVector3(x: 0, y: 0, z: -10)
		scene.rootNode.addChildNode(sphereNode2)
		
		// SourceFile
		let meshLibrary = SCNScene(named: "art.scnassets/source.dae")
		
		// External
		
		let capsule = meshLibrary.rootNode.childNodeWithName("capsule1", recursively: true)!
		capsule.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
		capsule.position = SCNVector3(x: 0, y: 0, z: 0)
		scene.rootNode.addChildNode(capsule)
		
		let capsule2 = meshLibrary.rootNode.childNodeWithName("capsule2", recursively: true)!
		capsule2.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
		capsule2.position = SCNVector3(x: 0, y: 0, z: 10)
		scene.rootNode.addChildNode(capsule2)
		
		var capsule3 = meshLibrary.rootNode.childNodeWithName("capsule3", recursively: true)!
		capsule3.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
		capsule3.position = SCNVector3(x: 0, y: 0, z: -10)
		scene.rootNode.addChildNode(capsule3)
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
		scnView.backgroundColor = UIColor.yellowColor()
		
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