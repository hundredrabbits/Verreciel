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
		if isInstalled == false {
			if event == items.radio {
				install()
				port.syphon()
				cargo.bang()
			}
		}
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}