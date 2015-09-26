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

class SCNInstance : SCNNode
{
	var event:SCNEvent!
	
	init(event:SCNEvent)
	{
		super.init()
		self.event = event
		
		self.geometry = SCNSphere(radius: 0.5)
		self.geometry?.firstMaterial?.doubleSided = true
		self.geometry?.firstMaterial?.diffuse.contents = red
		
		print("Begin instance : \(event.name!)")
	}
	
	override func update()
	{
		let distance = event.distanceFromCapsule * 15.0
		
		let angleBetweenPoints = (angleBetweenTwoPoints(capsule.location, point2: event.location, center: capsule.location) + 0) % 360
		let positionFromAngle = capsule.direction - angleBetweenPoints
		
		let newAngle = Double(abs(positionFromAngle)) * M_PI / 180.0
		
		let flattenedDistance = CGFloat(cos(newAngle)) * distance // important
		
		
		let p1 = capsule.location
		let p2 = event.location
		let center = capsule.location
		
		let v1 = CGVector(dx: p1.x - center.x, dy: p1.y - center.y)
		let v2 = CGVector(dx: p2.x - center.x, dy: p2.y - center.y)
		
		let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
		
		
		let shipInRadian = Double(capsule.direction) * M_PI / 180.0
		
		
		
		let angleInDeg = ((Double(angle) * 180.0 / M_PI) + 360) % 360
		let angleInRad = Double(angleInDeg) * M_PI / 180.0
		
		
		
		let difference = (abs(shipInRadian) - Double(abs(angleInRad)))
		
		let differenceInDeg = (difference * 180.0 / M_PI) % 180
		
		print("\(shipInRadian)(\(capsule.direction)) - \(angleInRad)(\(angleInDeg)) = \(abs(differenceInDeg))")
		
		
		// test
		let eventDirection = (angleBetweenTwoPoints(capsule.location, point2: event.location, center: event.location) + 270) % 360
		let testOri = abs(eventDirection - capsule.direction) % 360
		
		if testOri % 180 > 90 {
			self.position = SCNVector3(0,abs(flattenedDistance) * -0.5,0)
		}
		else{
			self.position = SCNVector3(0,abs(flattenedDistance) * 0.5,0)
		}
		
//		print(testOri)
		
		
		if event.distanceFromCapsule > 1.5 {
			leaveInstance()
		}
	}
	
	func leaveInstance()
	{
		print("Leaving instance: \(self.event.name!)")
		capsule.instance = nil
		self.removeFromParentNode()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}