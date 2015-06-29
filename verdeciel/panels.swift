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
		
		
		var testLabel = SCNLabel(text: "speed", scale: 0.05, align: alignment.left)
		testLabel.position = SCNVector3(x: 0.1, y: 0.65, z: 0)
		panelNode.addChildNode(testLabel)
		
		var testLabel2 = SCNLabel(text: "-", scale: 0.05, align: alignment.left)
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
		
		var nameLabel = SCNLabel(text: "navigation", scale: 0.05, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: -0.5, z: 0)
		nameLabel.name = "label.navigation"
		panelNode.addChildNode(nameLabel)
		
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
	
	func panel_test()
	{
		let test:SCNLabel = SCNLabel(text: "abcdefgh", scale: 0.15, align: alignment.left)
		test.position = SCNVector3(x: -1, y: 2, z: lowNode[7].z)
		scene.rootNode.addChildNode(test)
		
		let test2:SCNLabel = SCNLabel(text: "abcdefgh",scale:0.1, align: alignment.left)
		test2.position = SCNVector3(x: -1, y: 2.50, z: lowNode[7].z)
		scene.rootNode.addChildNode(test2)
		
		let test3:SCNLabel = SCNLabel(text: "abcdefgh",scale:0.05, align: alignment.left)
		test3.position = SCNVector3(x: -1, y: 2.85, z: lowNode[7].z)
		scene.rootNode.addChildNode(test3)
	}
	
}