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
	var targetDirectionIndicator = SCNNode()
	var activeDirectionIndicator = SCNNode()
	var staticDirectionIndicator = SCNNode()
	var eventsDirectionIndicator = SCNNode()
	
	override init()
	{
		super.init()
		
		name = "pilot"
		
		targetDirectionIndicator = SCNNode()
		targetDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.55, 0), nodeB: SCNVector3(0, 0.7, 0), color: white))
		mainNode.addChildNode(targetDirectionIndicator)
		
		activeDirectionIndicator = SCNNode()
		activeDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.4, -0.1), nodeB: SCNVector3(0, 0.55, -0), color: grey))
		mainNode.addChildNode(activeDirectionIndicator)
		
		staticDirectionIndicator = SCNNode()
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, -0.1), nodeB: SCNVector3(0, 0.4, -0), color: cyan))
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, -0.1), nodeB: SCNVector3(0, -0.4, -0), color: red))
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0.2, 0, -0.1), nodeB: SCNVector3(0.4, 0, -0), color: red))
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(-0.2, 0, -0.1), nodeB: SCNVector3(-0.4, 0, -0), color: red))
		mainNode.addChildNode(staticDirectionIndicator)
		
		eventsDirectionIndicator = SCNNode()
		eventsDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, -0.1), nodeB: SCNVector3(0.2, 0, -0), color: white))
		eventsDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, -0.1), nodeB: SCNVector3(-0.2, 0, -0), color: white))
		mainNode.addChildNode(eventsDirectionIndicator)
		
		port.input = Location.self
		port.output = Event.self
	}
	
	override func start()
	{
		decalsNode.opacity = 0
		mainNode.opacity = 0
		label.update("--", color: grey)
	}
	
	override func touch(id:Int = 0)
	{
		
	}
	
	override func fixedUpdate()
	{
		
//		// Approaching the sun
//		if capsule.closestLocationOfType(locationTypes.star).distance < 0.25 {
//			target = capsule.closestKnownLocation()
//		}
//		// Lost
//		else if capsule.closestKnownLocation().distance > 1.45 && capsule.isWarping == false{
//			target = capsule.closestKnownLocation()
//		}
//		// Port Location
////		else if port.isReceivingType(Location.self) == true {
////			target = port.origin.event as! Location
////		}
//		// Nothing
//		else{
//			target = nil
//		}
		
		if target != nil { align() }
	}
	
	func align()
	{
		let left = target.calculateAlignment(capsule.direction - 0.5)
		let right = target.calculateAlignment(capsule.direction + 0.5)
		
		let target_align = (target.align * 0.025) < 0.1 ? target.align : target.align * 0.025
		
		if left <= right {
			turnLeft(target_align)
		}
		else {
			turnRight(target_align)
		}
		
		if abs(target.align) > 25 { details.update(String(format: "%.0f",abs(target.align)), color:red) }
		else if abs(target.align) < 1 { details.update("ok", color:cyan) }
		else{ details.update(String(format: "%.0f",abs(target.align)), color:white) }
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
	
	override func onInstallationBegin()
	{
		ui.addWarning("Installing", duration: 3)
		player.lookAt(deg: -135)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}