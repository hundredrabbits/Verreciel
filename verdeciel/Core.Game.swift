
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
		NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.whenSecond), userInfo: nil, repeats: true)
	}
	
	func start()
	{
		universe.whenStart()
		capsule.whenStart()
		player.whenStart()
		space.whenStart()
		helmet.whenStart()
		items.whenStart()
		
		unlockedState(universe.valen_portal, newItems:[items.map2, items.shield, items.endKey])
//		startingState()
	}
	
	func startingState()
	{
		battery.install()
		capsule.beginAtLocation(universe.loiqe_spawn)
		battery.cellPort1.addEvent(items.battery1)
	}
	
	func unlockedState(location:Location = universe.senni_station, newItems:Array<Item> = [])
	{
		battery.onInstallationComplete()
		pilot.onInstallationComplete()
		radar.onInstallationComplete()
		cargo.onInstallationComplete()
		hatch.onInstallationComplete()
		intercom.onInstallationComplete()
		console.onInstallationComplete()
		thruster.onInstallationComplete()
		
		radio.onInstallationComplete()
		enigma.onInstallationComplete()
		map.onInstallationComplete()
		shield.onInstallationComplete()
		
		exploration.onInstallationComplete()
		journey.onInstallationComplete()
		progress.onInstallationComplete()
		completion.onInstallationComplete()
		
		capsule.beginAtLocation(location)
		
		universe.valen_portal.isKnown = true
		universe.loiqe_portal.isKnown = true
		universe.senni_portal.isKnown = true
		
		cargo.addItems(newItems)
		
		battery.cellPort1.enable()
		battery.cellPort2.enable()
		battery.cellPort3.enable()
		
		battery.installMap()
		battery.installShield()
		
		battery.cellPort1.addEvent(items.battery1)
		battery.cellPort1.connect(battery.thrusterPort)
		battery.cellPort2.addEvent(items.battery2)
		battery.cellPort2.connect(battery.mapPort)
		battery.cellPort3.addEvent(items.battery3)
		battery.cellPort3.connect(battery.shieldPort)
		
		radar.port.connect(pilot.port)
		shield.port.addEvent(items.shield)
	}
	
	func erase()
	{
		print("Game erased!")
	}
	
	@objc func whenSecond()
	{
		capsule.whenSecond()
		missions.refresh()
	}
	
	@objc func onTic()
	{
		time += 1
		space.whenTime()
	}
}