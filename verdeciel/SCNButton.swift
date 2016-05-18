
//  Created by Devine Lu Linvega on 2015-12-17.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNButton : Empty
{
	var host:Empty!
	var text:String!
	var trigger:SCNTrigger!
	var label:SCNLabel!
	var operation:Int!
	
	init(host:Empty,text:String,operation:Int,width:Float = 0.65)
	{
		self.text = text
		self.host = host
		self.operation = operation
		
		super.init()
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 0.5), operation: 2)
		trigger.addChildNode(SCNLine(vertices: [SCNVector3(-width,-0.25,0), SCNVector3(width,-0.25,0), SCNVector3(-width,0.25,0), SCNVector3(width,0.25,0), SCNVector3(-width,0.25,0), SCNVector3(-width - 0.25,0,0), SCNVector3(-width,-0.25,0), SCNVector3(-width - 0.25,0,0), SCNVector3(width,0.25,0), SCNVector3(width + 0.25,0,0), SCNVector3(width,-0.25,0), SCNVector3(width + 0.25,0,0)], color: red))
		addChildNode(trigger)
		
		label = SCNLabel(text:self.text, align:.center)
		addChildNode(label)
	}

	func enable(newText:String, outline:UIColor = cyan)
	{
		self.text = newText
		label.update(self.text, color:white)
		trigger.enable()
		trigger.updateChildrenColors(outline)
	}
	
	func disable(newText:String, outline:UIColor = red)
	{
		self.text = newText
		label.update(self.text, color:grey)
		trigger.updateChildrenColors(outline)
		trigger.disable()
	}
	
	override func touch(id:Int = 0)
	{
		host.touch(self.operation)
		audio.playSound("click3")
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
