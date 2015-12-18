//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MonitorComplete : Monitor
{
	var distance:Float = 0
	
	override init()
	{
		super.init()
		
		name = "complete"
		self.eulerAngles.x = Float(degToRad(templates.monitorsAngle))
	}
	
	func setup()
	{
		
	}
	
	override func refresh()
	{
		let questProgress:Float = Float(quests.tutorialProgress + quests.falvetProgress + quests.senniProgress + quests.usulProgress)
		let questSum:Float = Float(quests.tutorial.count + quests.falvet.count + quests.senni.count + quests.usul.count)
		let explorationProgress:Float = Float(exploration.knownLocations)
		let explorationSum:Float = Float(universe.childNodes.count)
		
		let percentage:Float = (questProgress + explorationProgress)/(questSum + explorationSum)
		
		label.update("\(Float(Int((percentage * 1000))/10))%")
	}
	
	override func onInstallationBegin()
	{
//		player.lookAt(deg: 90)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}