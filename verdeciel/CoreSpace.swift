
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
	var spaceColor:SCNNode!
	var structuresRoot:SCNNode!
	var starsRoot:SCNNode!
	var starTimer:Float = 0
	
	override init()
	{
		super.init()
		
		structuresRoot = SCNNode()
		addChildNode(structuresRoot)
		
		starsRoot = SCNNode()
		addChildNode(starsRoot)
	}
	
	override func fixedUpdate()
	{
		if starTimer > 10 {
			addStar()
			starTimer -= 10
		}
		
		let targetDirectionNormal = Double(Float(capsule.direction)/180) * 1
		self.rotation = SCNVector4Make(0, 1, 0, Float(M_PI * targetDirectionNormal))
		
		updateStars()
	}
	
	func prepareLines()
	{
		thruster.actualSpeed = 3
		var i = 0
		while i < 50 {
			addStar()
			updateStars()
			i += 1
		}
		thruster.actualSpeed = 0
		updateStars()
		
	}
	
	func startInstance(location:Location)
	{
		structuresRoot.addChildNode(Instance(event: location))
		player.alert("Approaching \(location.name!)")
	}
	
	/*
	override func update()
	{
		if capsule.sector == sectors.cyanine { spaceColor.geometry?.firstMaterial?.diffuse.contents = cyanTone }
		if capsule.sector == sectors.opal { spaceColor.geometry?.firstMaterial?.diffuse.contents = whiteTone }
		if capsule.sector == sectors.vermiles { spaceColor.geometry?.firstMaterial?.diffuse.contents = redTone }
		if capsule.sector == sectors.void { spaceColor.geometry?.firstMaterial?.diffuse.contents = greyTone }
		
		if thruster.actualSpeed > 0 {
			
			if capsule.travel > 0.5 {
				addLines()
				capsule.travel -= 0.5
			}
	
		}
	
		let targetDirectionNormal = Double(Float(capsule.direction)/180) * 1
		self.rotation = SCNVector4Make(0, 1, 0, Float(M_PI * targetDirectionNormal))
		
		updateStructures()
	}
*/
	
	func updateStructures()
	{
		for instance in structuresRoot.childNodes{
			instance.update()
		}
	}
	
	func addStar()
	{
		if starsRoot.childNodes.count > 350 { return }
		
		var randX = Int(arc4random_uniform(40)) - 20
		var randZ = Int(arc4random_uniform(40)) - 20
		
		while( distanceBetweenTwoPoints(CGPoint(x: CGFloat(randX), y: CGFloat(randZ)), point2: CGPoint(x: 0, y: 0)) < 6 ){
			randX = Int(arc4random_uniform(40)) - 20
			randZ = Int(arc4random_uniform(40)) - 20
		}
		
		var color = white
		if capsule.sector == sectors.cyanine { color = black }
		if capsule.sector == sectors.vermiles { color = black }
		if capsule.sector == sectors.opal { color = black }
		if capsule.sector == sectors.void { color = grey }
		
		let newLine = SCNLine(nodeA: SCNVector3(x: Float(randX), y: 0, z: Float(randZ)), nodeB: SCNVector3(x: Float(randX), y: 1, z: Float(randZ)), color: color)
		newLine.position = SCNVector3(x: newLine.position.x, y: 45, z: newLine.position.z)
		starsRoot.addChildNode(newLine)
	}
	
	func updateStars()
	{
		let lineSpeed = Float(thruster.actualSpeed) / 2
		for node in starsRoot.childNodes
		{
			let line = node as! SCNLine
			line.position = SCNVector3(x: line.position.x, y: line.position.y - lineSpeed, z: line.position.z)
			line.updateHeight(thruster.actualSpeed + 0.2)
			if line.position.y < -10 { line.removeFromParentNode() }
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}