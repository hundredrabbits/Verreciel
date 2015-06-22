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
	
	// MARK: Panels
	
	func panel_thruster()
	{
		let panelNode = SCNNode()
		panelNode.position = SCNVector3(x:0,y:floorNode[0].y,z:0)
		panelNode.addChildNode(knob("speed",position:SCNVector3(x: 0, y: 0, z: 0)))
		panelNode.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 1)); // rotate 90 degrees
		
		scene.rootNode.addChildNode(panelNode)
	}
	
	func panel_navigation()
	{
		let scale:Float = 0.8
		
		let HookA = lowNode[7]
		let HookB = lowNode[0]
		let HookC = lowMidNode[7]
		let HookD = lowMidNode[0]
		
		let nodeA = SCNVector3(x: HookA.x * scale, y: HookA.y, z: HookA.z * 0.9)
		let nodeB = SCNVector3(x: HookB.x * scale, y: HookB.y, z: HookB.z * 0.9)
		let nodeC = SCNVector3(x: HookC.x * scale, y: HookC.y * 0.9, z: HookC.z * 1.1)
		let nodeD = SCNVector3(x: HookD.x * scale, y: HookD.y * 0.9, z: HookD.z * 1.1)
		
		let panelNode = SCNNode()
		let optionPanel = SCNNode(geometry: SCNPlane(width: 2, height: 2))
		optionPanel.geometry?.firstMaterial?.diffuse.contents = clear
		optionPanel.position = SCNVector3(x: 0, y: -2, z: HookA.z * 0.65)
		
		optionPanel.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 0.85)); // rotate 90 degrees
		
		let text2 = SCNText(string: "STEER", extrusionDepth: 0.0)
		text2.font = UIFont(name: "CourierNewPSMT", size: 14)
		let node3 = SCNNode(geometry: text2)
		node3.scale = SCNVector3(x:0.02,y:0.02,z:0.02)
		node3.position = SCNVector3(x: -0.5, y: -1, z: 0)
		optionPanel.addChildNode(node3)
		
		scene.rootNode.addChildNode(optionPanel)
		
	}
	
	func panel_radar()
	{
		// Draw the frame
		
		let scale:Float = 0.8
		let nodeA = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale, z: highNode[7].z)
		let nodeB = SCNVector3(x: highNode[0].x * scale, y: highNode[0].y * scale, z: highNode[0].z)
		let nodeC = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale, z: lowNode[7].z)
		let nodeD = SCNVector3(x: lowNode[0].x * scale, y: lowNode[0].y * scale, z: lowNode[0].z)
		
		// Draw Radar
		
		let panelNode = SCNNode()
		panelNode.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		
		// Frame
		panelNode.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * scale, z: 0),SCNVector3(x: highNode[7].x * scale, y: 0, z: 0)))
		panelNode.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * -scale, z: 0),SCNVector3(x: highNode[7].x * scale, y: 0, z: 0)))
		panelNode.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * scale, z: 0),SCNVector3(x: highNode[7].x * -scale, y: 0, z: 0)))
		panelNode.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * -scale, z: 0),SCNVector3(x: highNode[7].x * -scale, y: 0, z: 0)))
		// Ship
		panelNode.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0),SCNVector3(x: 0.25, y: 0, z: 0)))
		panelNode.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0),SCNVector3(x: -0.25, y: 0, z: 0)))
		panelNode.addChildNode(grey(SCNVector3(x: 0, y: 0.25, z: 0),SCNVector3(x: 0, y: -0.25, z: 0)))
		
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
		let nodeA = SCNVector3(x: highNode[3].x * scale, y: highNode[3].y * scale, z: highNode[3].z)
		let nodeB = SCNVector3(x: highNode[4].x * scale, y: highNode[4].y * scale, z: highNode[4].z)
		let nodeC = SCNVector3(x: lowNode[3].x * scale, y: lowNode[3].y * scale, z: lowNode[3].z)
		let nodeD = SCNVector3(x: lowNode[4].x * scale, y: lowNode[4].y * scale, z: lowNode[4].z)
		
		// Interface
		
		let panelNode = SCNNode()
		panelNode.position = SCNVector3(x: 0, y: 0, z: lowNode[3].z)
		
		panelNode.addChildNode(toggle("thruster",position: SCNVector3(x: 0.75, y: 0.35, z: 0)))
		panelNode.addChildNode(toggle("electric",position: SCNVector3(x: -0.75, y: 0.35, z: 0)))
		
		panelNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2)); // rotate 90 degrees
		scene.rootNode.addChildNode(panelNode)
	}
	
	// MARK: Interfaces
	
	func toggle(name:String,position:SCNVector3) -> SCNNode
	{
		// Draw interaction plane
		let optionPanel = SCNNode(geometry: SCNPlane(width: 1, height: 1))
		optionPanel.geometry?.firstMaterial?.diffuse.contents = clear
		optionPanel.position = position
		optionPanel.name = "trigger.\(name)"
		
		let lineTest = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: 0.5, y: 0.5, z: 0))
		lineTest.name = "\(name).handle.top"
		optionPanel.addChildNode(lineTest)
		
		let lineTest2 = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: -0.5, y: -0.5, z: 0))
		lineTest2.name = "\(name).handle.left"
		optionPanel.addChildNode(lineTest2)
		
		let lineTest3 = redLine(SCNVector3(x: -0.5, y: -0.5, z: 0),SCNVector3(x: 0.5, y: -0.5, z: 0))
		lineTest3.name = "\(name).handle.bottom"
		optionPanel.addChildNode(lineTest3)
		
		let lineTest4 = redLine(SCNVector3(x: 0.5, y: -0.5, z: 0),SCNVector3(x: 0.5, y: 0.5, z: 0))
		lineTest3.name = "\(name).handle.right"
		optionPanel.addChildNode(lineTest4)
		
		let lineTest5 = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: 0.5, y: -0.5, z: 0))
		lineTest5.name = "\(name).handle.cross1"
		optionPanel.addChildNode(lineTest5)
		
		let lineTest6 = redLine(SCNVector3(x: 0.5, y: 0.5, z: 0),SCNVector3(x: -0.5, y: -0.5, z: 0))
		lineTest6.name = "\(name).handle.cross2"
		optionPanel.addChildNode(lineTest6)
		
		let lineTest7 = redLine(SCNVector3(x: 0.5, y: 0, z: 0),SCNVector3(x: -0.5, y: 0, z: 0))
		lineTest7.name = "\(name).handle.cross3"
		optionPanel.addChildNode(lineTest7)
		
		let text2 = SCNText(string: name, extrusionDepth: 0.0)
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
		
		return optionPanel
	}
	
	func knob(name:String,position:SCNVector3) -> SCNNode
	{
		var knob = SCNNode(geometry: SCNPlane(width: 1, height: 1))
		knob.geometry?.firstMaterial?.diffuse.contents = clear
		knob.position = position
		knob.name = "trigger.\(name)"
		
		var knobMesh = SCNNode()
		knobMesh.name = "knob.mesh"
		
		// Base
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0, y: 0.5, z: 0),SCNVector3(x: 0.35, y: 0.35, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0.35, y: 0.35, z: 0),SCNVector3(x: 0.5, y: 0, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0.5, y: 0, z: 0),SCNVector3(x: 0.35, y: -0.35, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0.35, y: -0.35, z: 0),SCNVector3(x: 0, y: -0.5, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0, y: -0.5, z: 0),SCNVector3(x: -0.35, y: -0.35, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: -0.35, y: -0.35, z: 0),SCNVector3(x: -0.5, y: 0, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: -0.5, y: 0, z: 0),SCNVector3(x: -0.35, y: 0.35, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: -0.35, y: 0.35, z: 0),SCNVector3(x: 0, y: 0.5, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0, y: 0.15, z: 0),SCNVector3(x: 0, y: 0.5, z: 0)))
		
		
		knob.addChildNode(line(SCNVector3(x: 0, y: 0.6, z: 0),SCNVector3(x: 0, y: 0.7, z: 0)))
		knob.addChildNode(line(SCNVector3(x: 0, y: -0.6, z: 0),SCNVector3(x: 0, y: -0.7, z: 0)))
		knob.addChildNode(line(SCNVector3(x: 0.6, y: 0, z: 0),SCNVector3(x: 0.7, y: 0, z: 0)))
		knob.addChildNode(line(SCNVector3(x: -0.6, y: 0, z: 0),SCNVector3(x: -0.7, y: 0, z: 0)))
		
		knob.addChildNode(knobMesh)
		
		// Top
		knob.position = position
		
		// Label
		let labelMesh = SCNText(string: "-", extrusionDepth: 0.0)
		labelMesh.font = UIFont(name: "CourierNewPSMT", size: 12)
		let labelNode = SCNNode(geometry: labelMesh)
		labelNode.name = "label"
		labelNode.scale = SCNVector3(x:0.015,y:0.015,z:0.015)
		labelNode.position = SCNVector3(x: 0.1, y: -0.75, z: 0)
		knob.addChildNode(labelNode)
		
		// Label
		let interfaceLabelMesh = SCNText(string: name.uppercaseString, extrusionDepth: 0.0)
		interfaceLabelMesh.font = UIFont(name: "CourierNewPSMT", size: 12)
		let interfaceLabelNode = SCNNode(geometry: interfaceLabelMesh)
		interfaceLabelNode.name = "label"
		interfaceLabelNode.scale = SCNVector3(x:0.015,y:0.015,z:0.015)
		interfaceLabelNode.position = SCNVector3(x: 0.1, y: 0.55, z: 0)
		interfaceLabelMesh.firstMaterial?.diffuse.contents = grey
		knob.addChildNode(interfaceLabelNode)
		
		return knob
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