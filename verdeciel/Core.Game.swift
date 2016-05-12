
//  Created by Devine Lu Linvega on 2015-12-18.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreGame
{
	var time:Float = 0
	let memory = NSUserDefaults.standardUserDefaults()
	
	init()
	{
		NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(self.onTic), userInfo: nil, repeats: true)
		NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.whenSecond), userInfo: nil, repeats: true)
	}
	
	func start()
	{
		erase()
		
		save(15)
		
		universe.whenStart()
		capsule.whenStart()
		player.whenStart()
		space.whenStart()
		helmet.whenStart()
		items.whenStart()
		
		load(memory.integerForKey("state"))
	}
	
	func save(id:Int)
	{
		print("@ GAME     | Saved State to \(id)")
		memory.setValue(id, forKey: "state")
	}
	
	func load(id:Int)
	{
		print("@ GAME     | Loaded State to \(id)")
		
		for mission in missions.story {
			if mission.id < id {
				mission.complete()
			}
		}
		missions.story[id].state()
	}
	
	func debug(location:Location = universe.loiqe_spawn, newItems:Array<Item> = [items.loiqePortalKey])
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
		print("$ GAME     | Erase")
		
		let appDomain = NSBundle.mainBundle().bundleIdentifier!
		NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
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