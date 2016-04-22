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
		port.hide()
		port.event = event

		headLineTop = SCNLine(vertices: [SCNVector3(0.125, 0, 0), SCNVector3(0, 0.125, 0)], color: cyan)
		headLineDown = SCNLine(vertices: [SCNVector3(0.125, 0, 0), SCNVector3(0, -0.125, 0)], color: cyan)
		
		self.addChildNode(label)
		self.addChildNode(detailsLabel)
		self.addChildNode(port)
		self.addChildNode(headLineTop)
		self.addChildNode(headLineDown)
		
		if head == true {
			headLineTop.show()
			headLineDown.show()
		}
		else{
			headLineTop.hide()
			headLineDown.hide()
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
			port.show()
			port.enable()
		}
		else{
			port.hide()
		}
		
		if command.head == true {
			headLineTop.show()
			headLineDown.show()
		}
		else{
			headLineTop.hide()
			headLineDown.hide()
		}
	}
	
	override func whenRenderer()
	{
		super.whenRenderer()
		
		if console.port.origin == nil {
			port.disable()
		}
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}