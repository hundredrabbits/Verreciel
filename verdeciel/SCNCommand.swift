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
	var details:String!
	var color:UIColor!
	var event:SCNEvent!
	
	var output:SCNPort!
	var label:SCNLabel
	var detailsLabel:SCNLabel
	
	init(text:String = "",details:String = "",color:UIColor = white,event:SCNEvent! = nil)
	{
		self.text = text
		self.details = details
		self.color = color
		self.event = event

		label = SCNLabel(text: self.text, scale: 0.1, align: alignment.left)
		detailsLabel = SCNLabel(text: "", scale: 0.1, align: alignment.right)
		detailsLabel.position = SCNVector3((highNode[0].x * 0.8 * 2) - 0.3, 0, 0)
		detailsLabel.updateColor(grey)
		
		super.init()
		
		output = SCNPort(host: self, polarity: true)
		output.position = SCNVector3((highNode[0].x * 0.8 * 2) - 0.15, 0, 0)
		
		self.addChildNode(label)
		self.addChildNode(detailsLabel)
		self.addChildNode(output)
		
		if details != "" { detailsLabel.update("hey") }
	}
	
	func update(command:SCNCommand)
	{
		label.updateWithColor(command.text, color: self.color)
		detailsLabel.update("")
		
		if command.event != nil {
			self.event = command.event!
			output.opacity = 1
		}
		else{
			output.opacity = 0
		}
		
		if command.details != "" {
			self.details = command.details
			detailsLabel.update(self.details)
		}
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}