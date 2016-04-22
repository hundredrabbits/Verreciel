
//  Created by Devine Lu Linvega on 2015-12-15.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class WidgetEnigma : Widget
{
	var isActive:Bool = false
	
	override init()
	{
		super.init()
		
		name = "enigma"
		details = "[missing text]"
		requirement = ItemTypes.cypher
		isPowered = { battery.isEnigmaPowered() }
		
		label.update(name!)
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		battery.installEnigma()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}