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
	var speedLines:SCNNode!
	
	override init()
	{
		super.init()
	
		let sphereNode = SCNNode()
		sphereNode.geometry = SCNSphere(radius: 40.0)
		sphereNode.geometry?.firstMaterial?.doubleSided = true
		sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor(white: 0, alpha: 1)
		self.addChildNode(sphereNode)
		
		speedLines = SCNNode()
		speedLines.position = SCNVector3(x: 0, y: 0, z: 0)
		self.addChildNode(speedLines)
	}
	
	override func update()
	{
		// Speedlines
		for node in speedLines.childNodes
		{
			let line = node 
			line.position = SCNVector3(x: line.position.x, y: line.position.y - 0.5, z: line.position.z)
			if line.position.y < -10 { line.removeFromParentNode() }
		}
		
		// Add a new line
		var randX = Int(arc4random_uniform(40)) - 20
		var randZ = Int(arc4random_uniform(40)) - 20
		
		while( distanceBetweenTwoPoints(CGPoint(x: CGFloat(randX), y: CGFloat(randZ)), point2: CGPoint(x: 0, y: 0)) < 6 ){
			randX = Int(arc4random_uniform(40)) - 20
			randZ = Int(arc4random_uniform(40)) - 20
		}
		
		let newLine = SCNLine(nodeA: SCNVector3(x: Float(randX), y: 0, z: Float(randZ)), nodeB: SCNVector3(x: Float(randX), y: 1, z: Float(randZ)), color: white)
		newLine.position = SCNVector3(x: newLine.position.x, y: 45, z: newLine.position.z)
		speedLines.addChildNode(newLine)
	}
	
	func speedLine()
	{
		
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