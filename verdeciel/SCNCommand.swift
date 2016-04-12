//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNCommand : SCNNode
{
	var text:String!
	var details:String!
	var color:UIColor!
	
	var head:Bool!
	
	var label:SCNLabel!
	var port:SCNPortRedirect!
	var detailsLabel:SCNLabel
	
	var headLineTop:SCNLine!
	var headLineDown:SCNLine!
	
	init(text:String = "", details:String! = "", color:UIColor = white,event:Event! = nil, head:Bool = false, host:SCNNode! = nil)
	{
		self.text = text
		self.details = details
		self.color = color
		self.head = head

		label = SCNLabel(text: self.text, scale: 0.1, align: alignment.left)
		label.position = SCNVector3(0.3, 0, 0)
		
		detailsLabel = SCNLabel(text: details, scale: 0.1, align: alignment.right)
		detailsLabel.position = SCNVector3(3.2, 0, 0)
		detailsLabel.updateColor(grey)
		
		super.init()
		
		port = SCNPortRedirect(host: self)
		port.position = SCNVector3(0, 0, 0)
		port.opacity = 0
		port.event = event

		headLineTop = SCNLine(nodeA: SCNVector3(0.125, 0, 0), nodeB: SCNVector3(0, 0.125, 0), color: cyan)
		headLineDown = SCNLine(nodeA: SCNVector3(0.125, 0, 0), nodeB: SCNVector3(0, -0.125, 0), color: cyan)
		
		self.addChildNode(label)
		self.addChildNode(detailsLabel)
		self.addChildNode(port)
		self.addChildNode(headLineTop)
		self.addChildNode(headLineDown)
		
		if head == true {
			headLineTop.opacity = 1
			headLineDown.opacity = 1
		}
		else{
			headLineTop.opacity = 0
			headLineDown.opacity = 0
		}
	}
	
	func inject(command:SCNCommand)
	{
		self.text = command.text
		self.details = command.details
		self.color = command.color
		self.head = command.head
		
		port.event = command.port.event
		
		label.update(command.text, color: self.color)
		detailsLabel.update(details)
		
		if port.event != nil {
			port.opacity = 1
			port.enable()
		}
		else{
			port.opacity = 0
		}
		
		if command.head == true {
			headLineTop.opacity = 1
			headLineDown.opacity = 1
		}
		else{
			headLineTop.opacity = 0
			headLineDown.opacity = 0
		}
	}
	
	/*
	override func bang()
	{
		if port.connection == nil { return }
		if port.event == nil { return }
		
		port.connection.host.listen(port.event)
	}
	*/
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		if console.port.origin == nil {
			port.disable()
		}
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}