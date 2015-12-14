//  Created by Devine Lu Linvega on 2015-08-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNPortRedirect : SCNPort
{
	override func removeEvent()
	{
		let redirectedHost = console.port.origin.host as! PanelCargo
		redirectedHost.removeEvent(event)
		redirectedHost.bang()
		disable()
	}
	
	override func disable()
	{
		isEnabled = false
		disconnect()
		trigger.disable()
	}
	
	override func disconnect()
	{
		if self.connection != nil { self.connection.origin = nil }
		self.connection = nil
		wire.disable()
	}
}
