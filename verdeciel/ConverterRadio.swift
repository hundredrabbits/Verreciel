//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class ConverterRadio : Converter
{
	override init()
	{
		super.init()
		name = "radio"
		port.input = eventTypes.panel
	}
	
	override func listen(event: Event)
	{
		print("heard")
		if isInstalled == false && event == items.radio {
			install()
		}
	}
	
	override func installedFixedUpdate()
	{
		if battery.isRadioPowered() == true {
			modePowered()
		}
		else{
			modeUnpowered()
		}
	}
	
	func modePowered()
	{
		label.updateColor(white)
		port.event = nil
		for location in universe.childNodes {
			let NewLocation = location as! Location
			if NewLocation.isRadioQuest == false { continue }
			if NewLocation.distance > 1.1 { continue }
			port.event = NewLocation
			print("scanning:\(NewLocation.name!)")
			break
		}
	}
	
	override func bang()
	{
		if port.connection == nil { return }
		if port.event == nil { return }
		port.connection.host.listen(port.event)
	}
	
	func modeUnpowered()
	{
		label.updateColor(grey)
	}
	
	override func onInstallationComplete()
	{
		battery.radioLabel.update("radio",color:white)
		battery.radioPort.enable()
		if port.origin != nil {
			port.origin.disconnect()
		}
		
		port.input = eventTypes.item
		port.output = eventTypes.location
		port.requirement = nil
		portInputLabel.update("\(port.input)")
		portOutputLabel.update("\(port.output)")
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}