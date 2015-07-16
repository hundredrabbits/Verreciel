//
//  CapsuleNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//


import UIKit
import QuartzCore
import SceneKit
import Foundation

class CapsuleNode : SCNNode
{
	override init()
	{
		super.init()
		
		capsuleSetup()
		linkSetup()
	}
	
	func update()
	{
		
	}
	
	func linkSetup()
	{
		var northNode = SCNLink(location: SCNVector3(x: 0, y: 0, z: -4.5), newDestination: SCNVector3(x: 0, y: 0, z: -1), scale: 6)
		scene.rootNode.addChildNode(northNode)
		
		var southNode = SCNLink(location: SCNVector3(x: 0, y: 0, z: 4.5), newDestination: SCNVector3(x: 0, y: 0, z: 1), scale: 6)
		southNode.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 2));
		scene.rootNode.addChildNode(southNode)
		
		var eastNode = SCNLink(location: SCNVector3(x: 4.5, y: 0, z: 0), newDestination: SCNVector3(x: 1, y: 0, z: 0), scale: 6)
		eastNode.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 1));
		scene.rootNode.addChildNode(eastNode)
		
		var westNode = SCNLink(location: SCNVector3(x: -4.5, y: 0, z: 0), newDestination: SCNVector3(x: -1, y: 0, z: 0), scale: 6)
		westNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1));
		scene.rootNode.addChildNode(westNode)
		
		var northWestNode = SCNLink(location: SCNVector3(x: -4, y: 0, z: -4), newDestination: SCNVector3(x: -1, y: 0, z: -1), scale: 6)
		northWestNode.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 3.5));
		scene.rootNode.addChildNode(northWestNode)
		
		var northEastNode = SCNLink(location: SCNVector3(x: 4, y: 0, z: -4), newDestination: SCNVector3(x: 1, y: 0, z: -1), scale: 6)
		northEastNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 3.5));
		scene.rootNode.addChildNode(northEastNode)
		
		var southWestNode = SCNLink(location: SCNVector3(x: -4, y: 0, z: 4), newDestination: SCNVector3(x: -1, y: 0, z: 1), scale: 6)
		southWestNode.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 2.5));
		scene.rootNode.addChildNode(southWestNode)
		
		var southEastNode = SCNLink(location: SCNVector3(x: 4, y: 0, z: 4), newDestination: SCNVector3(x: 1, y: 0, z: 1), scale: 6)
		southEastNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2.5));
		scene.rootNode.addChildNode(southEastNode)
		
		var topNode = SCNLink(location: SCNVector3(x: 0, y: 4, z: 0), newDestination: SCNVector3(x: 0, y: 1, z: 0), scale: 9)
		topNode.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 1));
		scene.rootNode.addChildNode(topNode)
		
		var bottomNode = SCNLink(location: SCNVector3(x: 0, y: -4, z: 0), newDestination: SCNVector3(x: 0, y: -1, z: 0), scale: 9)
		bottomNode.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 1));
		scene.rootNode.addChildNode(bottomNode)
		
		var windowNode = SCNLink(location: SCNVector3(x: 0, y: 3.5, z: 0), newDestination: SCNVector3(x: 0, y: 3.5, z: 0), scale: 4)
		windowNode.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 1));
		scene.rootNode.addChildNode(windowNode)
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
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}