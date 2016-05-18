
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2016 XXIIVV. All rights reserved.

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
		details = "inspects events"
		
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
		super.onDisconnect()
		
		nameLabel.update("\(port.origin.host.name!) > Port", color:cyan)
		
		if port.origin.event != nil {
			inject(port.origin.event.payload())
		}
		else if port.origin.host != nil {
			inject(port.origin.host.payload())
		}
	}
	
	override func onDisconnect()
	{
		super.onDisconnect()
		
		nameLabel.update("Console", color:grey)
		inject(defaultPayload())
	}
	
	override func whenStart()
	{
		super.whenStart()
		
		nameLabel.update(grey)
		inject(defaultPayload())
	}
	
	override func whenTime()
	{
		super.whenTime()
		
		
	}
	
	func clear()
	{
		for line in lines{
			line.update(ConsoleData())
		}
	}
	
	func inject(payload:ConsolePayload)
	{
		clear()
		
		var id = 0
		for data in payload.data {
			lines[id].update(data)
			id += 1
		}
		
		// Animate
		
		var count = 0
		for line in lines {
			line.position.z = Float(count) * -0.1
			line.opacity = 0
			count += 1
		}
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for line in lines {
			line.position.z = 0
			line.opacity = 1
		}
		
		SCNTransaction.commit()
	}
	
	func defaultPayload() -> ConsolePayload
	{
		return ConsolePayload(data: [
			ConsoleData(text:"nataniev os",details:"OK", color:white),
			ConsoleData(text:"systems",details:"\(capsule.systemsInstalledCount())/\(capsule.systemsCount())",color:grey),
			ConsoleData(text:"",details:"",color:grey),
			ConsoleData(text:"",color:grey),
			ConsoleData(text:"",color:grey),
			ConsoleData(text:"",color:grey),
		])
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		player.lookAt(deg: -270)
	}
	
	override func onInstallationComplete()
	{
		super.onInstallationComplete()
		
		inject(defaultPayload())
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
		
		detailsLabel = SCNLabel(scale: 0.075, align: alignment.right, color:grey)
		detailsLabel.position = SCNVector3(3.2, 0, 0)
		addChildNode(detailsLabel)
	}
	
	func update(data:ConsoleData)
	{
		detailsLabel.update(data.details)
		
		if data.event != nil {
			textLabel.update("\(data.text)", color:data.color)
			port.addEvent(data.event)
			port.enable()
			port.show()
			textLabel.position = SCNVector3(0.3, 0, 0)
		}
		else{
			textLabel.update("> \(data.text)", color:data.color)
			port.disable()
			port.hide()
			textLabel.position = SCNVector3(0, 0, 0)
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class ConsoleData
{
	var text:String = "text"
	var details:String = "details"
	var event:Event! = nil
	var color:UIColor!
	
	init(text:String = "", details:String = "", event:Event! = nil, color:UIColor = white)
	{
		self.text = text
		self.details = details
		self.event = event
		self.color = color
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

