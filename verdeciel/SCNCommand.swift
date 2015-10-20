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

class SCNCommand : SCNNode
{
	var text:String!
	var details:eventDetails!
	var color:UIColor!
	var event:Event!
	
	var head:Bool!
	
	var label:SCNLabel!
	var port:SCNPort!
	var detailsLabel:SCNLabel
	
	var headLineTop:SCNLine!
	var headLineDown:SCNLine!
	
	init(text:String = "",details:eventDetails = eventDetails.unknown,color:UIColor = white,event:Event! = nil, head:Bool = false)
	{
		self.text = text
		self.details = details
		self.color = color
		self.event = event
		self.head = head

		label = SCNLabel(text: self.text, scale: 0.1, align: alignment.left)
		detailsLabel = SCNLabel(text: "", scale: 0.1, align: alignment.right)
		detailsLabel.position = SCNVector3((templates.rightMargin * 2) - 0.4, 0, 0)
		detailsLabel.updateColor(grey)
		
		super.init()
		
		port = SCNPort(host: self)
		port.position = SCNVector3((templates.rightMargin * 2), 0, 0)
		port.opacity = 0

		headLineTop = SCNLine(nodeA: SCNVector3(-0.1, 0, 0), nodeB: SCNVector3(-0.2, 0.1, 0), color: red)
		headLineDown = SCNLine(nodeA: SCNVector3(-0.1, 0, 0), nodeB: SCNVector3(-0.2, -0.1, 0), color: red)
		
		self.addChildNode(label)
		self.addChildNode(detailsLabel)
		self.addChildNode(port)
		self.addChildNode(headLineTop)
		self.addChildNode(headLineDown)
	}
	
	func update(command:SCNCommand)
	{
		label.updateWithColor(command.text, color: self.color)
		detailsLabel.update("")
		
		if command.event != nil {
			self.event = command.event!
			port.opacity = 1
			port.addEvent(event)
		}
		else{
			port.opacity = 0
		}
		
		if command.details != eventDetails.unknown {
			self.details = command.details
			detailsLabel.update("\(details)")
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
	
	override func bang()
	{
		port.connection.host.listen(self.event)
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}