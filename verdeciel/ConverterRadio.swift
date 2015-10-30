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
	}
	
	func modeUnpowered()
	{
		label.updateColor(grey)
	}
	
	override func onInstallationComplete()
	{
		battery.radioLabel.update("radio",color:white)
		battery.radioPort.enable()
		port.origin.disconnect()
		
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