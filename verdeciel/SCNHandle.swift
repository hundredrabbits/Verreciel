//  Created by Devine Lu Linvega on 2015-08-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNHandle : Empty
{
	var destination:SCNVector3!
	var selectionLine:SCNLine!
	var trigger:SCNTrigger!
	var host:MainPanel!
	
	var isEnabled:Bool = true
	
	init(destination:SCNVector3 = SCNVector3(), host:MainPanel)
	{
		self.destination = destination
		self.host = host
		
		super.init()
		
		setup()
	}
	
	func setup()
	{
		let width:Float = 0.4
		let spacing:Float = 0.15
		let height:Float = 0.2
		position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		addChildNode(SCNLine(vertices: [SCNVector3(x: -width, y: 0, z: height),  SCNVector3(x: -width + spacing, y: 0, z: height), SCNVector3(x: width, y: 0, z: height),  SCNVector3(x: width - spacing, y: 0, z: height), SCNVector3(x: -width, y: 0, z: 0),  SCNVector3(x: -width, y: 0, z: height), SCNVector3(x: width, y: 0, z: 0),  SCNVector3(x: width, y: 0, z: height)],color:grey) )
		
		selectionLine = SCNLine(vertices: [SCNVector3(x: -width + spacing, y: 0, z: height),  SCNVector3(x: width - spacing, y: 0, z: height)],color:cyan)
		addChildNode(selectionLine)
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 0.5), operation: 0)
		trigger.updateChildrenColors(red)
		addChildNode(trigger)
	}
	
	func enable()
	{
		isEnabled = true
		selectionLine.update(cyan)
	}
	
	func disable()
	{
		isEnabled = false
		selectionLine.update(grey)
	}
	
	override func touch(id:Int = 0)
	{
		player.holdHandle(self)
		audio.playSound("click4")
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}