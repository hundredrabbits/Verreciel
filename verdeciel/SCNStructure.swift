//
//  SCNCommand.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNStructure : SCNNode
{
	var event:SCNEvent!
	
	init(event:SCNEvent)
	{
		super.init()
		self.event = event
		
		self.geometry = SCNSphere(radius: 0.5)
		self.geometry?.firstMaterial?.doubleSided = true
		self.geometry?.firstMaterial?.diffuse.contents = red
	}
	
	override func update()
	{
		if event.name == nil { return }
		
		let angleBetweenPoints = (angleBetweenTwoPoints(capsule.location, point2: event.location, center: capsule.location) + 270) % 360
		var positionFromAngle = capsule.direction - angleBetweenPoints
		if positionFromAngle < -180 { positionFromAngle += 360}
		positionFromAngle = positionFromAngle % 360
		
		
		self.position = SCNVector3(positionFromAngle * 0.01,event.distanceFromCapsule * 20,0)
		
		print("Approaching \(event.name!) at \( angleBetweenPoints ), ship at \(capsule.direction) : \( (positionFromAngle) )")
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}