
//  Created by Devine Lu Linvega on 2015-12-18.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreGame
{
	init()
	{
		
	}
	
	func start()
	{
		universe.start()
		capsule.start()
		player.start()
		space.start()
		helmet.start()
		time.start()
	}
	
	func update()
	{
		missions.refresh()
	}
	
	func onSeconds()
	{
		update()
	}
}