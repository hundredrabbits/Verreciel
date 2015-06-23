//
//  displayNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNLabel : SCNNode
{
	init(text:String)
	{
		super.init()
		
		let textPivot = SCNNode()
		
		let characters = Array(text)
		
		var scale:Float = 0.15
		
		var letterPos = 0
		for letterCur in characters
		{
			var letterNode = letter(String(letterCur))
			letterNode.position = SCNVector3(x: (scale * 1.5) * Float(letterPos), y: 0, z: 0)
			textPivot.addChildNode(letterNode)
			
			letterPos += 1
		}
		
		
		self.addChildNode(textPivot)
	}
	
	func letter(letter:String) -> SCNNode
	{
		var scale:Float = 0.15
		
		let letterPivot = SCNNode()
		letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: scale, z: 0)))
		
		letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
		letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
		letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		return letterPivot
		
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}