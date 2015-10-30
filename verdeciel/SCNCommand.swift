//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNCommand : SCNNode
{
	var text:String!
	var details:itemTypes!
	var color:UIColor!
	
	var head:Bool!
	
	var label:SCNLabel!
	var port:SCNPort!
	var detailsLabel:SCNLabel
	
	var headLineTop:SCNLine!
	var headLineDown:SCNLine!
	
	init(text:String = "",details:itemTypes = itemTypes.unknown,color:UIColor = white,event:Event! = nil, head:Bool = false, host:SCNNode! = nil)
	{
		self.text = text
		self.details = details
		self.color = color
		self.head = head

		label = SCNLabel(text: self.text, scale: 0.1, align: alignment.left)
		detailsLabel = SCNLabel(text: "", scale: 0.1, align: alignment.right)
		detailsLabel.position = SCNVector3((templates.rightMargin * 2) - 0.2, 0, 0)
		detailsLabel.updateColor(grey)
		
		super.init()
		
		if host != nil {
			port = SCNPort(host: host)
		}
		else{
			port = SCNPort(host: self)
		}
		port.position = SCNVector3((templates.rightMargin * 2), 0, 0)
		port.opacity = 0
		port.event = event

		headLineTop = SCNLine(nodeA: SCNVector3(-0.1, 0, 0), nodeB: SCNVector3(-0.2, 0.1, 0), color: cyan)
		headLineDown = SCNLine(nodeA: SCNVector3(-0.1, 0, 0), nodeB: SCNVector3(-0.2, -0.1, 0), color: cyan)
		
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
		detailsLabel.update("")
		
		if port.event != nil {
			port.opacity = 1
			port.enable()
		}
		else{
			port.opacity = 0
		}
		
		if command.details != itemTypes.unknown {
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
	
	override func update()
	{
		if port.event == nil {
			port.disable()
		}
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}