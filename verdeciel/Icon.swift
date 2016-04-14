//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Icon : SCNNode
{
	var host:Location!
	
	var color:UIColor = UIColor.purpleColor()
	var size:Float = 0.1
	
	var label = SCNLabel()
	var trigger = SCNNode()
	var mesh = SCNNode()
	var wire:SCNLine!
	
	override init()
	{
		super.init()
		
		label = SCNLabel(text: "", scale: 0.06, align: alignment.center, color: grey)
		label.position = SCNVector3(0,-0.3,-0.35)
		self.addChildNode(label)
		
		wire = SCNLine(positions: [],color:white)
		wire.position = SCNVector3(0,0,-0.01)
		wire.opacity = 0
		self.addChildNode(wire)
		
		addChildNode(mesh)
		addChildNode(label)
		addChildNode(trigger)
		addChildNode(wire)
	}
	
	func addHost(host:Location)
	{
		self.host = host
		
		label.update(host.name!)
	}
	
	override func whenStart()
	{
		super.whenStart()
		if host.mapRequirement != nil { label.update(cyan) }
	}
	
	func onUpdate()
	{
		if host.isComplete == nil { color = white }
		else if host.isComplete == false { color = red }
		else if host.isComplete == true { color = cyan }
		
		mesh.updateChildrenColors(color)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}