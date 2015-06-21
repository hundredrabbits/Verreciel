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
		
		panel_commander()
		
		objectSetup()
		sceneComplete()
	}
	
	func capsuleCoordinates()
	{
		NSLog("WORLD  | Capsule Coordinates")
		
		var scale:Float = 0.25
		var height:Float = -3
		floorNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 0.25
		height = 3
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
		scene.rootNode.addChildNode(line(floorNode[0],floorNode[1]))
		scene.rootNode.addChildNode(line(floorNode[1],floorNode[2]))
		scene.rootNode.addChildNode(line(floorNode[2],floorNode[3]))
		scene.rootNode.addChildNode(line(floorNode[3],floorNode[4]))
		scene.rootNode.addChildNode(line(floorNode[4],floorNode[5]))
		scene.rootNode.addChildNode(line(floorNode[5],floorNode[6]))
		scene.rootNode.addChildNode(line(floorNode[6],floorNode[7]))
		scene.rootNode.addChildNode(line(floorNode[7],floorNode[0]))
		
		// Draw Low Ring
		scene.rootNode.addChildNode(line(lowNode[0],lowNode[1]))
		scene.rootNode.addChildNode(line(lowNode[1],lowNode[2]))
		scene.rootNode.addChildNode(line(lowNode[2],lowNode[3]))
		scene.rootNode.addChildNode(line(lowNode[3],lowNode[4]))
		scene.rootNode.addChildNode(line(lowNode[4],lowNode[5]))
		scene.rootNode.addChildNode(line(lowNode[5],lowNode[6]))
		scene.rootNode.addChildNode(line(lowNode[6],lowNode[7]))
		scene.rootNode.addChildNode(line(lowNode[7],lowNode[0]))
		
		// Draw High Ring
		scene.rootNode.addChildNode(line(highNode[0],highNode[1]))
		scene.rootNode.addChildNode(line(highNode[1],highNode[2]))
		scene.rootNode.addChildNode(line(highNode[2],highNode[3]))
		scene.rootNode.addChildNode(line(highNode[3],highNode[4]))
		scene.rootNode.addChildNode(line(highNode[4],highNode[5]))
		scene.rootNode.addChildNode(line(highNode[5],highNode[6]))
		scene.rootNode.addChildNode(line(highNode[6],highNode[7]))
		scene.rootNode.addChildNode(line(highNode[7],highNode[0]))
		
		// Draw Ceiling
		scene.rootNode.addChildNode(line(ceilingNode[0],ceilingNode[1]))
		scene.rootNode.addChildNode(line(ceilingNode[1],ceilingNode[2]))
		scene.rootNode.addChildNode(line(ceilingNode[2],ceilingNode[3]))
		scene.rootNode.addChildNode(line(ceilingNode[3],ceilingNode[4]))
		scene.rootNode.addChildNode(line(ceilingNode[4],ceilingNode[5]))
		scene.rootNode.addChildNode(line(ceilingNode[5],ceilingNode[6]))
		scene.rootNode.addChildNode(line(ceilingNode[6],ceilingNode[7]))
		scene.rootNode.addChildNode(line(ceilingNode[7],ceilingNode[0]))
		
		// Connect floors
		var i = 0
		while i < floorNode.count
		{
			scene.rootNode.addChildNode(line(floorNode[i],lowNode[i]))
			scene.rootNode.addChildNode(line(lowNode[i],highNode[i]))
			scene.rootNode.addChildNode(line(highNode[i],ceilingNode[i]))
			i += 1
		}
	}
	
	func panel_commander()
	{
		let scale:Float = 0.8
		let nodeA = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale, z: highNode[7].z * 0.9)
		let nodeB = SCNVector3(x: highNode[0].x * scale, y: highNode[0].y * scale, z: highNode[0].z * 0.9)
		let nodeC = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale, z: lowNode[7].z * 0.9)
		let nodeD = SCNVector3(x: lowNode[0].x * scale, y: lowNode[0].y * scale, z: lowNode[0].z * 0.9)
		
		scene.rootNode.addChildNode(line(nodeA,nodeB))
		scene.rootNode.addChildNode(line(nodeC,nodeD))
		scene.rootNode.addChildNode(line(nodeA,nodeC))
		scene.rootNode.addChildNode(line(nodeB,nodeD))
		
		scene.rootNode.addChildNode(line(nodeA,highNode[7]))
		scene.rootNode.addChildNode(line(nodeB,highNode[0]))
		scene.rootNode.addChildNode(line(nodeC,lowNode[7]))
		scene.rootNode.addChildNode(line(nodeD,lowNode[0]))
		
		let text = SCNText(string: "MENU", extrusionDepth: 0.0)
		text.font = UIFont(name: "CourierNewPSMT", size: 14)
		let node = SCNNode(geometry: text)
		node.position = nodeC
		node.scale = SCNVector3(x:0.02,y:0.02,z:0.02)
		
		scene.rootNode.addChildNode(node)
		
		// Interface
		
		scene.rootNode.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * scale, z: highNode[7].z * 0.9),SCNVector3(x: 0, y: lowNode[7].y * scale, z: lowNode[7].z * 0.9)))
		scene.rootNode.addChildNode(line(SCNVector3(x: 0, y: 0, z: highNode[7].z * 0.9),SCNVector3(x: lowNode[7].x * 0.8, y: 0, z: lowNode[7].z * 0.9)))
		
		// Draw interaction plane
		let test = SCNPlane(width: 1, height: 1)
		test.firstMaterial?.lightingModelName = SCNLightingModelConstant
		test.firstMaterial?.diffuse.contents = UIColor.orangeColor()
		let node2 = SCNNode(geometry: test)
		node2.position = SCNVector3(x: 0, y: 0, z: nodeC.z - 0.1)
		node2.name = "trigger.power"
		
		let lineTest = redLine(SCNVector3(x: -5, y: 0, z: 0),SCNVector3(x: 5, y: 0, z: 0))
		lineTest.name = "power.handle"
		node2.addChildNode(lineTest)
		
		scene.rootNode.addChildNode(node2)

	}
	
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
	
	func objectSetup()
	{
		let sphere = SCNSphere(radius: 0.2)
		let sphereNode = SCNNode(geometry: sphere)
		sphereNode.name = "trigger.move"
		sphereNode.position = SCNVector3(x: 0, y: 0, z: 0)
		sphereNode.opacity = 0.5
		scene.rootNode.addChildNode(sphereNode)
		
		let linkW = SCNNode(geometry: SCNSphere(radius: 0.1))
		linkW.name = "trigger.move"
		linkW.opacity = 0.1
		linkW.position = SCNVector3(x: -2, y: 0, z: 0)
		scene.rootNode.addChildNode(linkW)
		
		let linkE = SCNNode(geometry: SCNSphere(radius: 0.1))
		linkE.name = "trigger.move"
		linkE.opacity = 0.1
		linkE.position = SCNVector3(x: 2, y: 0, z: 0)
		scene.rootNode.addChildNode(linkE)
		
		let linkN = SCNNode(geometry: SCNSphere(radius: 0.1))
		linkN.name = "trigger.move"
		linkN.opacity = 0.1
		linkN.position = SCNVector3(x: 0, y: 0, z: 2)
		scene.rootNode.addChildNode(linkN)
		
		let linkS = SCNNode(geometry: SCNSphere(radius: 0.1))
		linkS.name = "trigger.move"
		linkS.opacity = 0.1
		linkS.position = SCNVector3(x: 0, y: 0, z: -2)
		scene.rootNode.addChildNode(linkS)
		
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