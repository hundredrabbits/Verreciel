//  Created by Devine Lu Linvega on 2015-08-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNHandle : SCNNode
{
	var destination:SCNVector3!
	var selectionLine:SCNLine!
	var trigger:SCNTrigger!
	
	var isEnabled:Bool = true
	
	init(destination:SCNVector3 = SCNVector3())
	{
		self.destination = destination
		
		super.init()
		
		setup()
	}
	
	func setup()
	{
		let width:Float = 0.4
		let spacing:Float = 0.15
		let height:Float = 0.2
		position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		addChildNode(SCNLine(nodeA: SCNVector3(x: -width, y: 0, z: height),nodeB: SCNVector3(x: -width + spacing, y: 0, z: height),color:grey) )
		addChildNode(SCNLine(nodeA: SCNVector3(x: width, y: 0, z: height),nodeB: SCNVector3(x: width - spacing, y: 0, z: height),color:grey) )
		addChildNode(SCNLine(nodeA: SCNVector3(x: -width, y: 0, z: 0),nodeB: SCNVector3(x: -width, y: 0, z: height),color:grey) )
		addChildNode(SCNLine(nodeA: SCNVector3(x: width, y: 0, z: 0),nodeB: SCNVector3(x: width, y: 0, z: height),color:grey) )
		
		selectionLine = SCNLine(nodeA: SCNVector3(x: -width + spacing, y: 0, z: height),nodeB: SCNVector3(x: width - spacing, y: 0, z: height),color:cyan)
		addChildNode(selectionLine)
		
		let label = SCNLabel(text: "handle", scale: 0.03, align: alignment.center, color: grey)
		label.position = SCNVector3(0,-0.2,0)
		addChildNode(label)
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 0.5), operation: 0)
		trigger.updateChildrenColors(red)
		addChildNode(trigger)
	}
	
	func enable()
	{
		isEnabled = true
		selectionLine.updateColor(cyan)
	}
	
	func disable()
	{
		isEnabled = false
		selectionLine.updateColor(grey)
	}
	
	override func touch(id:Int = 0)
	{
		if player.handle != nil { player.handle.enable() }
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		player.position = destination
		ui.position = destination
		SCNTransaction.commit()
		
		player.handle = self
		player.handle.disable()
		
		player.handleTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: player, selector: Selector("center"), userInfo: nil, repeats: false)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}