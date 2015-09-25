
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

class CoreSpace: SCNNode
{
	var structuresRoot:SCNNode!
	var starsRoot:SCNNode!
	
	override init()
	{
		super.init()
	
		let sphereNode = SCNNode()
		sphereNode.geometry = SCNSphere(radius: 40.0)
		sphereNode.geometry?.firstMaterial?.doubleSided = true
		sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor(white: 0, alpha: 1)
		self.addChildNode(sphereNode)
		
		structuresRoot = SCNNode()
		structuresRoot.position = SCNVector3(x: 0, y: 0, z: 0)
		self.addChildNode(structuresRoot)
		
		starsRoot = SCNNode()
		starsRoot.position = SCNVector3(x: 0, y: 0, z: 0)
		self.addChildNode(starsRoot)
	}
	
	override func update()
	{
		if thruster.actualSpeed > 0 {
			addLines()
			updateLines()
		}
		
		let targetDirectionNormal = Double(Float(capsule.direction)/180) * 1
		self.rotation = SCNVector4Make(0, 1, 0, Float(M_PI * targetDirectionNormal))
		
		updateStructures()
	}
	
	func addStructure(event:SCNEvent)
	{
		print("added structure: \(event.name!)")
		structuresRoot.addChildNode(SCNStructure(event: event))
	}
	
	func removeStructure()
	{
		print("removed structure")
		for structure in structuresRoot.childNodes{
//			structure.removeFromParentNode()
		}
	}
	
	func updateStructures()
	{
		for structure in structuresRoot.childNodes{
			structure.update()
		}
	}
	
	func addLines()
	{
		var randX = Int(arc4random_uniform(40)) - 20
		var randZ = Int(arc4random_uniform(40)) - 20
		
		while( distanceBetweenTwoPoints(CGPoint(x: CGFloat(randX), y: CGFloat(randZ)), point2: CGPoint(x: 0, y: 0)) < 6 ){
			randX = Int(arc4random_uniform(40)) - 20
			randZ = Int(arc4random_uniform(40)) - 20
		}
		
		let newLine = SCNLine(nodeA: SCNVector3(x: Float(randX), y: 0, z: Float(randZ)), nodeB: SCNVector3(x: Float(randX), y: 1, z: Float(randZ)), color: white)
		newLine.position = SCNVector3(x: newLine.position.x, y: 45, z: newLine.position.z)
		starsRoot.addChildNode(newLine)
	}
	
	func updateLines()
	{
		let lineSpeed = Float(thruster.actualSpeed) / 2
		for node in starsRoot.childNodes
		{
			let line = node
			line.position = SCNVector3(x: line.position.x, y: line.position.y - lineSpeed, z: line.position.z)
			if line.position.y < -10 { line.removeFromParentNode() }
		}
	}
	
	func fogEvent()
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		scene.fogStartDistance = 0
		scene.fogEndDistance = 5000
		scene.fogDensityExponent = 4
		scene.fogColor = UIColor.redColor()
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	func fogCapsule()
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		scene.fogStartDistance = 0
		scene.fogEndDistance = 17
		scene.fogDensityExponent = 4
		scene.fogColor = UIColor.blackColor()
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}