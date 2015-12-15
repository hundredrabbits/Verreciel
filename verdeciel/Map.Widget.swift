
//  Created by Devine Lu Linvega on 2015-12-15.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class WidgetMap : SCNNode
{
	var port:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "map"
		
		port = SCNPort(host: self, input: eventTypes.map, output: eventTypes.map)
		port.position = SCNVector3(0,-0.6,templates.radius)
		port.disable()
		
		let inputLabel = SCNLabel(text: "\(port.input)", scale: 0.03, color:grey, align: alignment.right)
		let outputLabel = SCNLabel(text: "\(port.input)", scale: 0.03, color:grey, align: alignment.left)
		inputLabel.position = SCNVector3(-templates.margin * 0.5,0,0)
		outputLabel.position = SCNVector3(templates.margin * 0.5,0,0)
		port.addChildNode(inputLabel)
		port.addChildNode(outputLabel)
		
		addChildNode(port)
	}
	
	func install()
	{
		port.enable()
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}