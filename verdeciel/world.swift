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
		
		sceneComplete()
	
		triggersSetup()
	}
	
	func nodeNetworkSetup()
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
		
		scale = 0.5
		height = -2
		lowMidNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		scale = 1
		height = 1.5
		highNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
	}
	
	func capsuleSetup()
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
	
	// MARK: Panels
	
	func panel_navigation()
	{
		let scale:Float = 0.8
		
		let HookA = lowNode[7]
		let HookB = lowNode[0]
		let HookC = lowMidNode[7]
		let HookD = lowMidNode[0]
		
		let nodeA = SCNVector3(x: HookA.x * scale, y: HookA.y, z: HookA.z * 0.9)
		let nodeB = SCNVector3(x: HookB.x * scale, y: HookB.y, z: HookB.z * 0.9)
		let nodeC = SCNVector3(x: HookC.x * scale, y: HookC.y, z: HookC.z * 0.9)
		let nodeD = SCNVector3(x: HookD.x * scale, y: HookD.y, z: HookD.z * 0.9)
		
		scene.rootNode.addChildNode(line(nodeA,nodeB))
		scene.rootNode.addChildNode(line(nodeC,nodeD))
		scene.rootNode.addChildNode(line(nodeA,nodeC))
		scene.rootNode.addChildNode(line(nodeB,nodeD))
		
		scene.rootNode.addChildNode(line(nodeA,HookA))
		scene.rootNode.addChildNode(line(nodeB,HookB))
		
		scene.rootNode.addChildNode(line(nodeC,floorNode[7]))
		scene.rootNode.addChildNode(line(nodeD,floorNode[0]))
		
	}
	
	func panel_radar()
	{
		// Draw the frame
		
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
		
		// Draw Radar
		
		let panelNode = SCNNode()
		panelNode.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z * 0.9)
		
		// Frame
		panelNode.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * scale, z: 0),SCNVector3(x: highNode[7].x * scale, y: 0, z: 0)))
		panelNode.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * -scale, z: 0),SCNVector3(x: highNode[7].x * scale, y: 0, z: 0)))
		panelNode.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * scale, z: 0),SCNVector3(x: highNode[7].x * -scale, y: 0, z: 0)))
		panelNode.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * -scale, z: 0),SCNVector3(x: highNode[7].x * -scale, y: 0, z: 0)))
		// Ship
		panelNode.addChildNode(line(SCNVector3(x: 0, y: -0.25, z: 0),SCNVector3(x: 0, y: 0.25, z: 0)))
		panelNode.addChildNode(line(SCNVector3(x: -0.25, y: 0, z: 0),SCNVector3(x: 0.25, y: 0, z: 0)))
		
		let text2 = SCNText(string: "RADAR", extrusionDepth: 0.0)
		text2.font = UIFont(name: "CourierNewPSMT", size: 14)
		let node3 = SCNNode(geometry: text2)
		node3.scale = SCNVector3(x:0.02,y:0.02,z:0.02)
		node3.position = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale, z: 0)
		panelNode.addChildNode(node3)
		
		scene.rootNode.addChildNode(panelNode)
	}
	
	func panel_commander()
	{
		// Draw the frame
		
		let scale:Float = 0.8
		let nodeA = SCNVector3(x: highNode[3].x * scale, y: highNode[3].y * scale, z: highNode[3].z * 0.9)
		let nodeB = SCNVector3(x: highNode[4].x * scale, y: highNode[4].y * scale, z: highNode[4].z * 0.9)
		let nodeC = SCNVector3(x: lowNode[3].x * scale, y: lowNode[3].y * scale, z: lowNode[3].z * 0.9)
		let nodeD = SCNVector3(x: lowNode[4].x * scale, y: lowNode[4].y * scale, z: lowNode[4].z * 0.9)
		
		scene.rootNode.addChildNode(line(nodeA,nodeB))
		scene.rootNode.addChildNode(line(nodeC,nodeD))
		scene.rootNode.addChildNode(line(nodeA,nodeC))
		scene.rootNode.addChildNode(line(nodeB,nodeD))
		
		scene.rootNode.addChildNode(line(nodeA,highNode[3]))
		scene.rootNode.addChildNode(line(nodeB,highNode[4]))
		scene.rootNode.addChildNode(line(nodeC,lowNode[3]))
		scene.rootNode.addChildNode(line(nodeD,lowNode[4]))
		
		// Interface
		
		let panelNode = SCNNode()
		panelNode.position = SCNVector3(x: 0, y: 0, z: lowNode[3].z * 0.9)
	
		panelNode.addChildNode(line(SCNVector3(x: 0, y: highNode[3].y * scale, z: 0),SCNVector3(x: 0, y: lowNode[3].y * scale, z: 0)))
		panelNode.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0),SCNVector3(x: lowNode[3].x * -0.8, y: 0, z: 0)))
		
		// Draw interaction plane
		let optionPanel = SCNNode(geometry: SCNPlane(width: 1, height: 1))
		optionPanel.geometry?.firstMaterial?.diffuse.contents = clear
		optionPanel.position = SCNVector3(x: 0.75, y: 0.35, z: 0)
		optionPanel.name = "trigger.power"
		
		let lineTest = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: 0.5, y: 0.5, z: 0))
		lineTest.name = "power.handle.top"
		optionPanel.addChildNode(lineTest)
		
		let lineTest2 = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: -0.5, y: -0.5, z: 0))
		lineTest2.name = "power.handle.left"
		optionPanel.addChildNode(lineTest2)
		
		let lineTest3 = redLine(SCNVector3(x: -0.5, y: -0.5, z: 0),SCNVector3(x: 0.5, y: -0.5, z: 0))
		lineTest3.name = "power.handle.bottom"
		optionPanel.addChildNode(lineTest3)
		
		let lineTest4 = redLine(SCNVector3(x: 0.5, y: -0.5, z: 0),SCNVector3(x: 0.5, y: 0.5, z: 0))
		lineTest3.name = "power.handle.right"
		optionPanel.addChildNode(lineTest4)
		
		let lineTest5 = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: 0.5, y: -0.5, z: 0))
		lineTest5.name = "power.handle.cross1"
		optionPanel.addChildNode(lineTest5)
		
		let lineTest6 = redLine(SCNVector3(x: 0.5, y: 0.5, z: 0),SCNVector3(x: -0.5, y: -0.5, z: 0))
		lineTest6.name = "power.handle.cross2"
		optionPanel.addChildNode(lineTest6)
		
		let lineTest7 = redLine(SCNVector3(x: 0.5, y: 0, z: 0),SCNVector3(x: -0.5, y: 0, z: 0))
		lineTest7.name = "power.handle.cross3"
		optionPanel.addChildNode(lineTest7)
		
		let text2 = SCNText(string: "POWER", extrusionDepth: 0.0)
		text2.font = UIFont(name: "CourierNewPSMT", size: 14)
		let node3 = SCNNode(geometry: text2)
		node3.position = SCNVector3(x: -0.5, y: -1, z: 0)
		node3.scale = SCNVector3(x:0.02,y:0.02,z:0.02)
		optionPanel.addChildNode(node3)
		
		let text3 = SCNText(string: "0.5", extrusionDepth: 0.0)
		text3.font = UIFont(name: "CourierNewPSMT", size: 14)
		let node4 = SCNNode(geometry: text3)
		node4.position = SCNVector3(x: -0.5, y: -1.25, z: 0)
		node4.scale = SCNVector3(x:0.02,y:0.02,z:0.02)
		optionPanel.addChildNode(node4)
		
		panelNode.addChildNode(optionPanel)
		panelNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2)); // rotate 90 degrees
		scene.rootNode.addChildNode(panelNode)
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
		let linkC = SCNNode(geometry: SCNSphere(radius: 0.5))
		linkC.name = "trigger.move"
		linkC.position = SCNVector3(x: 0, y: 0, z: 0)
		linkC.geometry?.firstMaterial?.diffuse.contents = clear
		scene.rootNode.addChildNode(linkC)
		
		let linkW = SCNNode(geometry: SCNSphere(radius: 0.5))
		linkW.name = "trigger.move"
		linkW.position = SCNVector3(x: -2, y: 0, z: 0)
		linkW.geometry?.firstMaterial?.diffuse.contents = clear
		scene.rootNode.addChildNode(linkW)
		
		let linkE = SCNNode(geometry: SCNSphere(radius: 0.5))
		linkE.name = "trigger.move"
		linkE.position = SCNVector3(x: 2, y: 0, z: 0)
		linkE.geometry?.firstMaterial?.diffuse.contents = clear
		scene.rootNode.addChildNode(linkE)
		
		let linkN = SCNNode(geometry: SCNSphere(radius: 0.5))
		linkN.name = "trigger.move"
		linkN.position = SCNVector3(x: 0, y: 0, z: 2)
		linkN.geometry?.firstMaterial?.diffuse.contents = clear
		scene.rootNode.addChildNode(linkN)
		
		let linkS = SCNNode(geometry: SCNSphere(radius: 0.5))
		linkS.name = "trigger.move"
		linkS.position = SCNVector3(x: 0, y: 0, z: -2)
		linkS.geometry?.firstMaterial?.diffuse.contents = clear
		scene.rootNode.addChildNode(linkS)
		
		let linkT = SCNNode(geometry: SCNSphere(radius: 0.5))
		linkT.name = "trigger.move"
		linkT.position = SCNVector3(x: 0, y: 2, z: 0)
		linkT.geometry?.firstMaterial?.diffuse.contents = clear
		scene.rootNode.addChildNode(linkT)
		
		let linkB = SCNNode(geometry: SCNSphere(radius: 0.5))
		linkB.name = "trigger.move"
		linkB.position = SCNVector3(x: 0, y: -2, z: 0)
		linkB.geometry?.firstMaterial?.diffuse.contents = clear
		scene.rootNode.addChildNode(linkB)
		
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