
//  Created by Devine Lu Linvega on 2015-12-17.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNButton : SCNNode
{
	var host:SCNNode!
	var text:String!
	var trigger:SCNTrigger!
	var label:SCNLabel!
	
	init(host:SCNNode,text:String,operation:Int)
	{
		self.text = text
		self.host = host
		super.init()
		
		setup()
	}
	
	func setup()
	{
		let buttonWidth = 0.65
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 0.5), operation: 2)
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,-0.25,0), nodeB: SCNVector3(buttonWidth,-0.25,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,0.25,0), nodeB: SCNVector3(buttonWidth,0.25,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,0.25,0), nodeB: SCNVector3(-buttonWidth - 0.25,0,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,-0.25,0), nodeB: SCNVector3(-buttonWidth - 0.25,0,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(buttonWidth,0.25,0), nodeB: SCNVector3(buttonWidth + 0.25,0,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(buttonWidth,-0.25,0), nodeB: SCNVector3(buttonWidth + 0.25,0,0), color: red))
		addChildNode(trigger)
		
		label = SCNLabel(text:self.text, align:.center)
		addChildNode(label)
	}
	
	func enable(newText:String)
	{
		self.text = newText
		label.update(self.text, color:white)
		trigger.updateChildrenColors(red)
		trigger.enable()
	}
	
	func disable(newText:String)
	{
		self.text = newText
		label.update(self.text, color:grey)
		trigger.updateChildrenColors(grey)
		trigger.disable()
	}
	
	override func touch(id:Int = 0)
	{
		host.touch(id)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}