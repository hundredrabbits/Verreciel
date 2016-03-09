
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelHatch : MainPanel
{
	let outline = SCNNode()
	
	override init()
	{
		super.init()
		
		name = "hatch"
		info = "[missing text]"
		
		mainNode.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.7, z: 0),nodeB: SCNVector3(x: 0.7, y: 0, z: 0),color:grey))
		mainNode.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.7, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.7, z: 0),color:grey))
		mainNode.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.7, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: 0.7, z: 0),color:grey))
		mainNode.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.7, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.7, z: 0),color:grey))
		
		let outline1 = SCNLine(nodeA: SCNVector3(x: 0, y: 0.5, z: 0), nodeB:SCNVector3(x: 0.5, y: 0, z: 0),color:red)
		outline.addChildNode(outline1)
		let outline2 = SCNLine(nodeA: SCNVector3(x: 0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.5, z: 0),color:red)
		outline.addChildNode(outline2)
		let outline3 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: 0.5, z: 0),color:red)
		outline.addChildNode(outline3)
		let outline4 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.5, z: 0),color:red)
		outline.addChildNode(outline4)
		
		mainNode.addChildNode(outline)
		
		// Trigger
		
		mainNode.addChildNode(SCNTrigger(host: self, size: CGSize(width: 2, height: 2)))
		
		port.input = Item.self
		port.output = Event.self
		
		decalsNode.empty()
		
		details.update("empty", color: grey)
	}

	override func touch(id:Int = 0)
	{
		print("touch")
		bang()
	}
	
	override func bang()
	{
		if port.origin == nil || port.origin.event == nil { print("Nothing to jetison") ; return }
		if port.origin.event.isQuest == true { return }
		
		port.origin.removeEvent()
		
		update()
	}
	
	override func update()
	{
		var load:Event!
		
		load = (port.origin == nil) ? nil : port.origin.event
			
		if load != nil {
			if load.isQuest == true && port.origin.IO(port.origin.input) == "item" {
				details.update("error", color: red)
				outline.updateChildrenColors(red)
			}
			else{
				details.update("jetison", color: cyan)
				outline.updateChildrenColors(cyan)
			}
		}
		else{
			details.update("empty", color: grey)
			outline.updateChildrenColors(grey)
		}
	}
	
	override func onDisconnect()
	{
		update()
	}
	
	override func listen(event:Event)
	{
		self.update()
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		if debug.isActive == false { player.lookAt(deg: -315) }
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}