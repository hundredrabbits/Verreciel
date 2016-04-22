
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelConsole : MainPanel
{
	var lines:Array<ConsoleLine> = [ConsoleLine(),ConsoleLine(),ConsoleLine(),ConsoleLine(),ConsoleLine(),ConsoleLine()]

	override init()
	{
		super.init()
		
		name = "console"
		info = "[missing text]"
		
		lines[0].position = SCNVector3(x: templates.leftMargin, y: templates.lineSpacing * 2.5, z: 0)
		lines[1].position = SCNVector3(x: templates.leftMargin, y: templates.lineSpacing * 1.5, z: 0)
		lines[2].position = SCNVector3(x: templates.leftMargin, y: templates.lineSpacing * 0.5, z: 0)
		lines[3].position = SCNVector3(x: templates.leftMargin, y: -templates.lineSpacing * 0.5, z: 0)
		lines[4].position = SCNVector3(x: templates.leftMargin, y: -templates.lineSpacing * 1.5, z: 0)
		lines[5].position = SCNVector3(x: templates.leftMargin, y: -templates.lineSpacing * 2.5, z: 0)
		
		for line in lines {
			mainNode.addChildNode(line)
		}
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(-1,0,0),host:self))
	}
	
	override func onConnect()
	{
		label.update("\(port.origin.host.name!) > Port", color:cyan)
		inject(port.origin.event.payload())
	}
	
	override func onDisconnect()
	{
		label.update("Console", color:grey)
		inject(defaultPayload())
	}
	
	override func whenStart()
	{
		label.update(grey)
		inject(defaultPayload())
	}
	
	func inject(payload:ConsolePayload)
	{
		var id = 0
		for data in payload.data {
			lines[id].update(data)
			id += 1
		}
	}
	
	func defaultPayload() -> ConsolePayload
	{
		return ConsolePayload(data: [ConsoleData(text:"hey",details:"details"), ConsoleData(text:"hey 2",details:"wat",event:items.loiqePortalKey)])
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		player.lookAt(deg: -270)
	}
	
	override func onInstallationComplete()
	{
		super.onInstallationComplete()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class ConsoleLine : Empty
{
	var port:SCNPortRedirect!
	var textLabel:SCNLabel!
	var detailsLabel:SCNLabel!
	
	var data:ConsoleData!
	
	var head:Bool!
	
	init(data:ConsoleData! = nil)
	{
		super.init()
		
		port = SCNPortRedirect(host: self)
		port.position = SCNVector3(0, 0, 0)
		port.hide()
		addChildNode(port)
		
		textLabel = SCNLabel(scale: 0.1, align: alignment.left)
		textLabel.position = SCNVector3(0.3, 0, 0)
		addChildNode(textLabel)
		
		detailsLabel = SCNLabel(scale: 0.1, align: alignment.right, color:grey)
		detailsLabel.position = SCNVector3(3.2, 0, 0)
		addChildNode(detailsLabel)
	}
	
	func update(data:ConsoleData)
	{
		textLabel.update(data.text)
		detailsLabel.update(data.details)
		
		if data.event != nil {
			port.addEvent(data.event)
			port.enable()
			port.show()
		}
		else{
			port.disable()
			port.hide()
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class ConsoleData
{
	var text:String! = "text"
	var details:String! = "details"
	var event:Event! = nil
	var color:UIColor!
	
	init(text:String! = nil, details:String! = nil, event:Event! = nil)
	{
		self.text = text
		self.details = details
		self.event = event
	}
}

class ConsolePayload
{
	var data:Array<ConsoleData>! = [ConsoleData(),ConsoleData(),ConsoleData(),ConsoleData(),ConsoleData(),ConsoleData()]
	
	init(data:Array<ConsoleData>)
	{
		self.data = data
	}
}

