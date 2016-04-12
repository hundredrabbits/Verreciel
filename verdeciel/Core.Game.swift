
//  Created by Devine Lu Linvega on 2015-12-18.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreGame
{
	var time:Float = 0
	
	init()
	{
		NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(self.onTic), userInfo: nil, repeats: true)
		NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.onSeconds), userInfo: nil, repeats: true)
	}
	
	func start()
	{
		universe.whenStart()
		capsule.whenStart()
		player.whenStart()
		space.whenStart()
		helmet.whenStart()
		
		unlockedState(universe.loiqe_portal, newItems:[Item(like: items.currency1), items.map1])
//		 startingState()
	}
	
	func startingState()
	{
		capsule.beginAtLocation(universe.loiqe_spawn)
		battery.cellPort1.addEvent(items.battery1)
	}
	
	func unlockedState(location:Location = universe.senni_station, newItems:Array<Item> = [])
	{
		universe.unlock(.loiqe)
		universe.unlock(.valen)
		universe.unlock(.senni)
		universe.unlock(.usul)
		
		pilot.install()
		radar.install()
		cargo.install()
		hatch.install()
		intercom.install()
		console.install()
		thruster.install()
		
		radio.install()
		enigma.install()
		map.install()
		shield.install()
		
		exploration.install()
		journey.install()
		progress.install()
		completion.install()
		
		capsule.beginAtLocation(location)
		
		universe.valen_portal.isKnown = true
		universe.loiqe_portal.isKnown = true
		universe.senni_portal.isKnown = true
		
		cargo.addItems(newItems)
		
		battery.cellPort1.addEvent(items.battery1)
		battery.cellPort1.connect(battery.thrusterPort)
		//		battery.cellPort2.addEvent(items.battery3)
	}
	
	@objc func onSeconds()
	{
		capsule.onSeconds()
		missions.refresh()
	}
	
	@objc func onTic()
	{
		time += 1
		space.whenStart()
	}
}