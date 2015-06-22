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
}