
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
		erase()
		
		universe.whenStart()
		capsule.whenStart()
		player.whenStart()
		space.whenStart()
		helmet.whenStart()
		items.whenStart()
		
		if loadWithKey("version") != nil {
			load()
		}
		else{
			new()
		}
	}
	
	func new()
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
		print("$ GAME     | Erase")
		
		let appDomain = NSBundle.mainBundle().bundleIdentifier!
		NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
	}
	
	// MARK: Memory -
	
	let memory = NSUserDefaults.standardUserDefaults()
	
	func save()
	{
		print("$ GAME     | Saving.. version: \(version)")
		
		// Generic
		
		memory.setValue(version, forKey: "version")
		
		// Inventory
		var count = 0
		for cargoItem in cargo.cargohold.content {
			print("$ GAME     | Saving Cargo Item: \(cargoItem.code) in <cargo-\(count)>")
			memory.setValue(cargoItem.code, forKey: "cargo-\(count)")
			count += 1
		}
		
		// Bank
		if universe.valen_bank.port1.hasItem() == true { memory.setValue((universe.valen_bank.port1.event as! Item).code, forKey: "bank-1") }
		if universe.valen_bank.port2.hasItem() == true { memory.setValue((universe.valen_bank.port2.event as! Item).code, forKey: "bank-2") }
		if universe.valen_bank.port3.hasItem() == true { memory.setValue((universe.valen_bank.port3.event as! Item).code, forKey: "bank-3") }
		if universe.valen_bank.port4.hasItem() == true { memory.setValue((universe.valen_bank.port4.event as! Item).code, forKey: "bank-4") }
		if universe.valen_bank.port5.hasItem() == true { memory.setValue((universe.valen_bank.port5.event as! Item).code, forKey: "bank-5") }
		if universe.valen_bank.port6.hasItem() == true { memory.setValue((universe.valen_bank.port6.event as! Item).code, forKey: "bank-6") }
		
		// Capsule
		memory.setValue(capsule.lastLocation.code, forKey: "capsule-location")
		
		memory.setValue(journey.isInstalled, forKey: "capsule-panel-journey")
		memory.setValue(exploration.isInstalled, forKey: "capsule-panel-exploration")
		memory.setValue(progress.isInstalled, forKey: "capsule-panel-progress")
		memory.setValue(completion.isInstalled, forKey: "capsule-panel-completion")
		
		memory.setValue(battery.isInstalled, forKey: "capsule-panel-battery")
		memory.setValue(hatch.isInstalled, forKey: "capsule-panel-hatch")
		memory.setValue(console.isInstalled, forKey: "capsule-panel-console")
		memory.setValue(cargo.isInstalled, forKey: "capsule-panel-cargo")
		memory.setValue(intercom.isInstalled, forKey: "capsule-panel-intercom")
		memory.setValue(radar.isInstalled, forKey: "capsule-panel-radar")
		memory.setValue(thruster.isInstalled, forKey: "capsule-panel-thruster")
		
		memory.synchronize()
		
		print("!!!!!!!SAVE \(battery.isInstalled) ")
		
		print("$ GAME     | Saving..done!")
	}
	
	func load()
	{
		print("$ GAME     | Loading..")
		
		if let str = loadWithKey("version") { print("$ GAME     | Loading.. version: \(str)") }
		
		if let code = loadWithKey("cargo-1") { if let item = loadItemWithCode(code) { cargo.addItem(item) } }
		if let code = loadWithKey("cargo-2") { if let item = loadItemWithCode(code) { cargo.addItem(item) } }
		if let code = loadWithKey("cargo-3") { if let item = loadItemWithCode(code) { cargo.addItem(item) } }
		if let code = loadWithKey("cargo-4") { if let item = loadItemWithCode(code) { cargo.addItem(item) } }
		if let code = loadWithKey("cargo-5") { if let item = loadItemWithCode(code) { cargo.addItem(item) } }
		if let code = loadWithKey("cargo-6") { if let item = loadItemWithCode(code) { cargo.addItem(item) } }
		
		if let code = loadWithKey("bank-1") { if let item = loadItemWithCode(code) { universe.valen_bank.port1.addEvent(item) } }
		if let code = loadWithKey("bank-2") { if let item = loadItemWithCode(code) { universe.valen_bank.port2.addEvent(item) } }
		if let code = loadWithKey("bank-3") { if let item = loadItemWithCode(code) { universe.valen_bank.port3.addEvent(item) } }
		if let code = loadWithKey("bank-4") { if let item = loadItemWithCode(code) { universe.valen_bank.port4.addEvent(item) } }
		if let code = loadWithKey("bank-5") { if let item = loadItemWithCode(code) { universe.valen_bank.port5.addEvent(item) } }
		if let code = loadWithKey("bank-6") { if let item = loadItemWithCode(code) { universe.valen_bank.port6.addEvent(item) } }
		
		if let code = loadWithKey("capsule-location") { capsule.beginAtLocation(universe.locationWithCode(code)) }
		if let int = loadIntWithKey("capsule-quest-id") { missions.skipTo(int) }
		
		if loadBoolWithKey("capsule-panel-journey") == true { journey.onInstallationComplete() }
		if loadBoolWithKey("capsule-panel-exploration") == true { exploration.onInstallationComplete() }
		if loadBoolWithKey("capsule-panel-progress") == true { progress.onInstallationComplete() }
		if loadBoolWithKey("capsule-panel-completion") == true { completion.onInstallationComplete() }
		
		if loadBoolWithKey("capsule-panel-battery") == true { battery.onInstallationComplete() }
		if loadBoolWithKey("capsule-panel-hatch") == true { hatch.onInstallationComplete() }
		if loadBoolWithKey("capsule-panel-console") == true { console.onInstallationComplete() }
		if loadBoolWithKey("capsule-panel-cargo") == true { cargo.onInstallationComplete() }
		if loadBoolWithKey("capsule-panel-intercom") == true { intercom.onInstallationComplete() }
		if loadBoolWithKey("capsule-panel-radar") == true { radar.onInstallationComplete() }
		if loadBoolWithKey("capsule-panel-thruster") == true { thruster.onInstallationComplete() }
		
		print("!!!!!!!LOAD \(loadBoolWithKey("capsule-panel-battery")) ")
		
		print("$ GAME     | Loading..done!")
	}
	
	// MARK: Tools -
	
	func loadWithKey(key:String) -> String!
	{
		if let result = memory.stringForKey(key) {
			return result
		}
		return nil
	}
	
	func loadBoolWithKey(key:String) -> Bool
	{
		return memory.boolForKey(key)
	}
	
	func loadIntWithKey(key:String) -> Int!
	{
		return memory.integerForKey(key)
	}
	
	func loadItemWithCode(code:String) -> Item!
	{
		if code == items.waste.code { return items.waste }
		if code == items.kelp.code { return items.kelp }
		
		if code == items.loiqePortalKey.code { return items.waste }
		
		if code == items.valenPortalKey.code { return items.waste }
		if code == items.valenPortalFragment1.code { return items.waste }
		if code == items.valenPortalFragment2.code { return items.waste }
		
		if code == items.senniPortalKey.code { return items.waste }
		
		if code == items.usulPortalKey.code { return items.waste }
		if code == items.usulPortalFragment1.code { return items.waste }
		if code == items.usulPortalFragment2.code { return items.waste }
		
		if code == items.endKey.code { return items.waste }
		if code == items.endKeyFragment1.code { return items.waste }
		if code == items.endKeyFragment2.code { return items.waste }
		
		if code == items.warpDrive.code { return items.waste }
		if code == items.record1.code { return items.waste }
		if code == items.record2.code { return items.waste }
		if code == items.record3.code { return items.waste }
		if code == items.record4.code { return items.waste }
		if code == items.record_oquonie.code { return items.waste }
		
		if code == items.map1.code { return items.waste }
		if code == items.map2.code { return items.waste }
		
		if code == items.shield.code { return items.waste }
		
		if code == items.currency1.code { return items.waste }
		if code == items.currency2.code { return items.waste }
		if code == items.currency3.code { return items.waste }
		if code == items.currency4.code { return items.waste }
		if code == items.currency5.code { return items.waste }
		if code == items.currency6.code { return items.waste }
		
		if code == items.battery1.code { return items.waste }
		if code == items.battery2.code { return items.waste }
		if code == items.battery3.code { return items.waste }
		
		if code == items.teapot.code { return items.waste }
		if code == items.nestorine.code { return items.waste }
	
		return nil
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