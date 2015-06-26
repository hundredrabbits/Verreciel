//
//  panels.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

extension GameViewController
{
	func panel_thruster()
	{
		let panelNode = SCNNode()
		panelNode.name = "panel.thurster"
		panelNode.position = SCNVector3(x:0,y:floorNode[0].y,z:0)
		panelNode.addChildNode(knob("speed",position:SCNVector3(x: 0, y: 0, z: 0)))
		panelNode.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 1)); // rotate 90 degrees
		
		
		var testLabel = SCNLabel(text: "speed", scale: 0.05)
		testLabel.position = SCNVector3(x: 0.1, y: 0.65, z: 0)
		panelNode.addChildNode(testLabel)
		
		var testLabel2 = SCNLabel(text: "-", scale: 0.05)
		testLabel2.position = SCNVector3(x: 0.1, y: -0.65, z: 0)
		testLabel2.name = "label.speed"
		panelNode.addChildNode(testLabel2)
		
		scene.rootNode.addChildNode(panelNode)
	}
	
	func panel_thruster_update()
	{
		let panelNode = scene.rootNode.childNodeWithName("panel.thurster", recursively: false)!
		
		let knobMesh = panelNode.childNodeWithName("knob.mesh", recursively: true)!
		let targetAngle = Double(user.speed) * -1
		knobMesh.runAction(SCNAction.rotateToAxisAngle(SCNVector4Make(0, 0, 1, Float(M_PI/2 * targetAngle)), duration: 0.7))
		
		for node in knobMesh.childNodes
		{
			var node: SCNNode = node as! SCNNode
			if( user.speed == 0){
				node.geometry!.firstMaterial?.diffuse.contents = red
			}
			else{
				node.geometry!.firstMaterial?.diffuse.contents = cyan
			}
		}
		
		let labelNode = panelNode.childNodeWithName("label.speed", recursively: true)! as! SCNLabel
		labelNode.update(String(Int(user.speed)))
	}
	
	func panel_navigation()
	{
		let panelNode = SCNNode()
		let scale:Float = 0.8
		
		let HookA = lowNode[7]
		let HookB = lowNode[0]
		let HookC = lowMidNode[7]
		let HookD = lowMidNode[0]
		
		let nodeA = SCNVector3(x: HookA.x * scale, y: HookA.y, z: HookA.z * 0.9)
		let nodeB = SCNVector3(x: HookB.x * scale, y: HookB.y, z: HookB.z * 0.9)
		let nodeC = SCNVector3(x: HookC.x * scale, y: HookC.y * 0.9, z: HookC.z * 1.1)
		let nodeD = SCNVector3(x: HookD.x * scale, y: HookD.y * 0.9, z: HookD.z * 1.1)
		
		panelNode.position = SCNVector3(x: 0, y: -2, z: HookA.z * 0.65)
		panelNode.addChildNode(label("labelStatic", text: "navigation", position: SCNVector3(x: 0, y: 1, z: 0), color: UIColor.whiteColor()))
		panelNode.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 0.85));
		
		let turnLeft = SCNNode(geometry: SCNPlane(width: 0.5, height: 0.5))
		turnLeft.geometry?.firstMaterial?.diffuse.contents = clear
		turnLeft.name = "trigger.turnLeft"
		turnLeft.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: 0.25, y: 0, z: 0)))
		turnLeft.addChildNode(line(SCNVector3(x: 0.25, y: 0, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnLeft.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnLeft.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: -0.25, y: 0, z: 0)))
		turnLeft.position = SCNVector3(x: 0.5, y: 0, z: 0)
		panelNode.addChildNode(turnLeft)
		
		let turnRight = SCNNode(geometry: SCNPlane(width: 0.5, height: 0.5))
		turnRight.geometry?.firstMaterial?.diffuse.contents = clear
		turnRight.name = "trigger.turnRight"
		turnRight.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: -0.25, y: 0, z: 0)))
		turnRight.addChildNode(line(SCNVector3(x: -0.25, y: 0, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnRight.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnRight.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0.25, y: 0, z: 0)))
		turnRight.position = SCNVector3(x: -0.5, y: 0, z: 0)
		panelNode.addChildNode(turnRight)
		
		scene.rootNode.addChildNode(panelNode)
	}
	
	func panel_radar_update()
	{
		let interfaceNode = scene.rootNode.childNodeWithName("radar", recursively: false)!
		
		let radarLabel = interfaceNode.childNodeWithName("radar.label", recursively: true)! as! SCNLabel
		radarLabel.update("test")
		
		let xPosLabel = interfaceNode.childNodeWithName("radar.x", recursively: true)! as! SCNLabel
		xPosLabel.update(String(Int(user.x/20)))
		
		let zPosLabel = interfaceNode.childNodeWithName("radar.z", recursively: true)! as! SCNLabel
		zPosLabel.update(String(Int(user.z/20)))
		
		let rLabel = interfaceNode.childNodeWithName("radar.r", recursively: true)! as! SCNLabel
		rLabel.update(String(Int(user.orientation)))
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
		
		let interface = SCNNode()
		interface.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		
		// Frame
		interface.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * scale, z: 0),SCNVector3(x: highNode[7].x * scale, y: 0, z: 0)))
		interface.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * -scale, z: 0),SCNVector3(x: highNode[7].x * scale, y: 0, z: 0)))
		interface.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * scale, z: 0),SCNVector3(x: highNode[7].x * -scale, y: 0, z: 0)))
		interface.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * -scale, z: 0),SCNVector3(x: highNode[7].x * -scale, y: 0, z: 0)))
		// Ship
		interface.addChildNode(line(SCNVector3(x: 0, y: 0.15, z: 0),SCNVector3(x: 0.15, y: 0, z: 0)))
		interface.addChildNode(line(SCNVector3(x: 0, y: 0.15, z: 0),SCNVector3(x: -0.15, y: 0, z: 0)))
		interface.addChildNode(grey(SCNVector3(x: 0, y: 0, z: 0),SCNVector3(x: 0, y: -0.15, z: 0)))
		
		var radarLabel = SCNLabel(text: "radar", scale: 0.1)
		radarLabel.position = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale, z: 0)
		radarLabel.name = "radar.label"
		interface.addChildNode(radarLabel)
		
		var xPosLabel = SCNLabel(text: "x", scale: 0.1)
		xPosLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale, z: 0)
		xPosLabel.name = "radar.x"
		interface.addChildNode(xPosLabel)
		
		var zPosLabel = SCNLabel(text: "z", scale: 0.1)
		zPosLabel.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale - 0.3, z: 0)
		zPosLabel.name = "radar.z"
		interface.addChildNode(zPosLabel)
		
		var angleLabel = SCNLabel(text: "r", scale: 0.1)
		angleLabel.position = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale + 0.3, z: 0)
		angleLabel.name = "radar.r"
		interface.addChildNode(angleLabel)
		
		interface.name = "radar"
		
		scene.rootNode.addChildNode(interface)
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
	
	func panel_test()
	{
		let test:SCNLabel = SCNLabel(text: "abcdefgh", scale: 0.15)
		test.position = SCNVector3(x: -1, y: 2, z: lowNode[7].z)
		scene.rootNode.addChildNode(test)
		
		let test2:SCNLabel = SCNLabel(text: "abcdefgh",scale:0.1)
		test2.position = SCNVector3(x: -1, y: 2.50, z: lowNode[7].z)
		scene.rootNode.addChildNode(test2)
		
		let test3:SCNLabel = SCNLabel(text: "abcdefgh",scale:0.05)
		test3.position = SCNVector3(x: -1, y: 2.85, z: lowNode[7].z)
		scene.rootNode.addChildNode(test3)
	}
	
}