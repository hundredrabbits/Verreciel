//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelPilot : MainPanel
{
	var target:Location!
	var targetDirection = CGFloat()
	var targetDirectionIndicator = Empty()
	var activeDirectionIndicator = Empty()
	var staticDirectionIndicator = Empty()
	var eventsDirectionIndicator = Empty()
	
	override init()
	{
		super.init()
		
		name = "pilot"
		info = "[missing text]"
		
		targetDirectionIndicator = Empty()
		targetDirectionIndicator.addChildNode(SCNLine(vertices: [SCNVector3(0, 0.55, 0), SCNVector3(0, 0.7, 0)], color: white))
		mainNode.addChildNode(targetDirectionIndicator)
		
		activeDirectionIndicator = Empty()
		activeDirectionIndicator.addChildNode(SCNLine(vertices: [SCNVector3(0, 0.4, -0.1), SCNVector3(0, 0.55, -0)], color: grey))
		mainNode.addChildNode(activeDirectionIndicator)
		
		staticDirectionIndicator = Empty()
		staticDirectionIndicator.addChildNode(SCNLine(vertices: [SCNVector3(0, 0.2, -0.1), SCNVector3(0, 0.4, -0)], color: cyan))
		staticDirectionIndicator.addChildNode(SCNLine(vertices: [SCNVector3(0, -0.2, -0.1), SCNVector3(0, -0.4, -0)], color: red))
		staticDirectionIndicator.addChildNode(SCNLine(vertices: [SCNVector3(0.2, 0, -0.1), SCNVector3(0.4, 0, -0)], color: red))
		staticDirectionIndicator.addChildNode(SCNLine(vertices: [SCNVector3(-0.2, 0, -0.1), SCNVector3(-0.4, 0, -0)], color: red))
		mainNode.addChildNode(staticDirectionIndicator)
		
		eventsDirectionIndicator = Empty()
		eventsDirectionIndicator.addChildNode(SCNLine(vertices: [SCNVector3(0, 0.2, -0.1), SCNVector3(0.2, 0, -0)], color: white))
		eventsDirectionIndicator.addChildNode(SCNLine(vertices: [SCNVector3(0, 0.2, -0.1), SCNVector3(-0.2, 0, -0)], color: white))
		mainNode.addChildNode(eventsDirectionIndicator)
	
		decals.empty()
		
		detailsLabel.update("Ready", color: grey)
	}
	
	override func touch(id:Int = 0)
	{
		
	}
	
	override func whenRenderer()
	{
		super.whenRenderer()
		
		target = nil
		
		if capsule.isFleeing == true {
			target = capsule.lastLocation
		}
		else if capsule.isReturning == true {
			target = capsule.closestKnownLocation()
		}
		else if port.isReceivingEventOfTypeLocation(){
			target = port.origin.event as! Location
		}
		
		if target != nil { align() }
		else{ detailsLabel.update("--", color:grey) }
	}
	
	func align()
	{
		let left = target.calculateAlignment(capsule.direction - 0.5)
		let right = target.calculateAlignment(capsule.direction + 0.5)
		
		let target_align = abs(target.align * 0.035) < 0.01 ? target.align : target.align * 0.035
		
		if left <= right {
			turnLeft(target_align)
		}
		else {
			turnRight(target_align)
		}
		
		animate()
	}
	
	func turnLeft(deg:CGFloat)
	{
		capsule.direction = capsule.direction - deg
		capsule.direction = capsule.direction % 360
	}
	
	func turnRight(deg:CGFloat)
	{
		capsule.direction = capsule.direction + deg
		capsule.direction = capsule.direction % 360
	}
	
	func animate()
	{
		targetDirectionIndicator.eulerAngles.z = (degToRad(capsule.direction)) * -1
		staticDirectionIndicator.eulerAngles.z = (degToRad(capsule.direction))
		
		if capsule.isFleeing == true { detailsLabel.update("Auto", color:red) }
		else if abs(target.align) > 25 { detailsLabel.update(String(format: "%.0f",abs(target.align)), color:red) }
		else if abs(target.align) < 1 { detailsLabel.update("ok", color:cyan) }
		else { detailsLabel.update(String(format: "%.0f",abs(target.align)), color:white) }
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		player.lookAt(deg: -135)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}