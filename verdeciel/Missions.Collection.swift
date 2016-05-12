
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MissionCollection
{
	var story:Array<Mission> = Array<Mission>()
	
	init()
	{
		story = []
		build()
	}
	
	func build()
	{
		var m:Mission!
		
		// Loiqe
		
		// MARK: Part 0
		
		m = Mission(id:(story.count), name: "")
		m.state = {
			capsule.beginAtLocation(universe.loiqe_city)
			battery.cellPort1.addEvent(items.battery1)
			self.setToKnown([universe.loiqe_spawn])
		}
		m.quests = [
			Quest(name:"Route cell to thruster", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { thruster.install() }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_spawn && universe.loiqe_spawn.isKnown == true }, result: { }),
			Quest(name:"Accelerate with Thruster", predicate:{ capsule.dock == nil && thruster.speed > 0 || capsule.dock != nil }, result: { intercom.install() ; thruster.lock() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_harvest.isKnown == true }, result: { cargo.install() ; thruster.lock() }),
			Quest(name:"Route \(items.currency1.name!) to cargo", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.currency1) }, result: { console.install() ; thruster.unlock() }),
			Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_harvest }, result: { radar.install() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_city.isKnown == true }, result: {  }),
		]
		story.append(m)
		
		// MARK: Part 1
		
		m = Mission(id:(story.count), name: "Aquire Fragment")
		m.state = {
			capsule.beginAtLocation(universe.loiqe_city)
			battery.cellPort1.addEvent(items.battery1)
			cargo.addItems([Item(like:items.currency1)])
			self.setToInstalled([battery,thruster,radar])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city])
		}
		m.predicate = { cargo.contains(items.valenPortalFragment1) == true }
		m.quests = [
			Quest(name:"Route \(items.currency1.name!) to cargo", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.currency1) || capsule.isDockedAtLocation(universe.loiqe_city) }, result: { }),
			Quest(name:"Route \(items.currency1.name!) to trade table", location: universe.loiqe_city, predicate:{ universe.loiqe_city.isTradeAccepted == true }, result: { }),
			Quest(name:"Route \(items.valenPortalFragment1.name!) to cargo", predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { progress.install() }),
		]
		story.append(m)
		
		// MARK: Part 2
		
		m = Mission(id:(story.count), name: "Use radar")
		m.state = {
			capsule.beginAtLocation(universe.loiqe_city)
			battery.cellPort1.addEvent(items.battery1)
			cargo.addItems([items.valenPortalFragment1])
			self.setToInstalled([battery,thruster,radar,progress])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city])
			self.setToCompleted([universe.loiqe_city])
		}
		m.quests = [
			Quest(name:"Select satellite on radar", location:universe.loiqe_city, predicate:{ radar.port.event != nil && radar.port.event == universe.loiqe_satellite }, result: { pilot.install() ; thruster.unlock() }),
			Quest(name:"Route Radar to Pilot", predicate:{ pilot.port.origin != nil && pilot.port.origin == radar.port }, result: { })
		]
		story.append(m)
		
		// MARK: Part 3
		
		m = Mission(id:(story.count), name: "Create portal key")
		m.state = {
			capsule.beginAtLocation(universe.loiqe_city)
			battery.cellPort1.addEvent(items.battery1)
			cargo.addItems([items.valenPortalFragment1])
			self.setToInstalled([battery,thruster,radar,progress,pilot])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city])
			self.setToCompleted([universe.loiqe_city])
		}
		m.predicate = { cargo.contains(items.valenPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire \(items.valenPortalFragment1.name!)", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true || capsule.isDockedAtLocation(universe.loiqe_horadric) == true }, result: { }),
			Quest(name:"Aquire \(items.valenPortalFragment2.name!)", location: universe.loiqe_satellite, predicate:{ cargo.contains(items.valenPortalFragment2) == true || capsule.isDockedAtLocation(universe.loiqe_horadric) == true }, result: {  }),
			Quest(name:"Combine fragments", location: universe.loiqe_horadric, predicate:{ cargo.contains(items.valenPortalKey) == true }, result: { exploration.install() })
		]
		story.append(m)
		
		// MARK: Part 4
		
		m = Mission(id:(story.count), name: "The Portal transit")
		m.state = {
			capsule.beginAtLocation(universe.loiqe_horadric)
			battery.cellPort1.addEvent(items.battery1)
			cargo.addItems([items.valenPortalKey])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite])
		}
		m.predicate = { universe.valen_portal.isKnown == true }
		m.quests = [
			Quest(name:"Route \(items.valenPortalKey.name!) to Portal", location: universe.loiqe_portal, predicate:{ capsule.isDockedAtLocation(universe.loiqe_portal) && intercom.port.isReceiving(items.valenPortalKey) == true }, result: { }),
			Quest(name:"Align pilot to portal", location: universe.loiqe_portal, predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }),
			Quest(name:"Power Thruster with portal", location: universe.loiqe_portal, predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: { }),
		]
		story.append(m)
		
		// MARK: Part 5
		
		m = Mission(id:(story.count), name: "Install Radio")
		m.state = {
			capsule.beginAtLocation(universe.valen_portal)
			battery.cellPort1.addEvent(items.battery1)
			cargo.addItems([items.valenPortalKey])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite])
		}
		m.predicate = { radio.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect second cell", location: universe.valen_cargo, predicate:{ battery.hasCell(items.battery2) || cargo.contains(items.battery2) }, result: { battery.cellPort2.enable("empty",color:grey) }),
			Quest(name:"Collect \(items.currency2.name!)", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.currency2) }, result: { }),
			Quest(name:"Install radio", location: universe.valen_station, predicate:{ radio.isInstalled == true }, result: { journey.install() })
		]
		story.append(m)
		
		// MARK: Part 6
		
		m = Mission(id:(story.count), name: "Radio Lesson")
		m.state = {
			capsule.beginAtLocation(universe.valen_station)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			cargo.addItems([items.valenPortalKey,items.record1])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo])
		}
		m.quests = [
			Quest(name:"Install cell in battery", predicate:{ battery.hasCell(items.battery2) }, result: {  }),
			Quest(name:"Power radio", predicate:{ battery.isRadioPowered() == true }, result: {  }),
			Quest(name:"Route record to radio", predicate:{ radio.port.hasItemOfType(.record) }, result: {  })
		]
		story.append(m)
		
		// MARK: Part 7
		
		m = Mission(id:(story.count), name: "Hatch Lesson")
		m.state = {
			capsule.beginAtLocation(universe.valen_station)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			cargo.addItems([items.valenPortalKey,items.record1])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo])
		}
		m.predicate = { hatch.count > 0 }
		m.quests = [
			Quest(name:"Collect Waste", location: universe.valen_bank, predicate:{ cargo.containsLike(items.waste) }, result: { hatch.install() }),
			Quest(name:"Route waste to hatch", predicate:{ hatch.port.isReceivingItemLike(items.waste) }, result: {  }),
			Quest(name:"Jetison Waste", predicate:{ hatch.count > 0 }, result: { completion.install() })
		]
		story.append(m)
		
		// MARK: Part 8
		
		m = Mission(id:(story.count), name: "Loiqe Key")
		
		m.state = {
			capsule.beginAtLocation(universe.valen_bank)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			cargo.addItems([items.valenPortalKey,items.record1])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey,hatch,completion])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo])
		}
		m.predicate = { cargo.containsLike(items.loiqePortalKey) }
		m.quests = [
			Quest(name:"Collect \(items.loiqePortalKey.name!)", location: universe.valen_bank, predicate:{ cargo.containsLike(items.loiqePortalKey) }, result: { })
		]
		story.append(m)
		
		// MARK: Part 9
		
		m = Mission(id:(story.count), name: "Craft \(items.currency4.name!)")
		m.state = {
			capsule.beginAtLocation(universe.valen_station)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			cargo.addItems([items.valenPortalKey,items.record1,items.loiqePortalKey])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo])
		}
		m.predicate = { cargo.containsLike(items.currency4) }
		m.quests = [
			Quest(name:"Aquire \(items.currency2.name!)", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.currency2) }, result: { }),
			Quest(name:"Aquire \(items.currency1.name!)", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.currency1) }, result: { }),
			Quest(name:"Combine currencies", location: universe.loiqe_horadric, predicate:{ cargo.containsLike(items.currency4) }, result: { })
		]
		story.append(m)
		
		// MARK: Part 10
		
		m = Mission(id:(story.count), name: "Senni Portal Key")
		m.state = {
			capsule.beginAtLocation(universe.loiqe_horadric)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			cargo.addItems([items.valenPortalKey,items.record1,Item(like:items.currency4)])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo])
		}
		m.predicate = { cargo.contains(items.senniPortalKey) }
		m.quests = [
			Quest(name:"Aquire \(items.currency4.name!)", predicate:{ cargo.containsLike(items.currency4) }, result: { }),
			Quest(name:"Trade \(items.currency4.name!) for \(items.senniPortalKey.name!)", location: universe.loiqe_port, predicate:{ cargo.contains(items.senniPortalKey) }, result: { })
		]
		story.append(m)
		
		// MARK: Part 11
		
		m = Mission(id:(story.count), name: "Install Map")
		m.state = {
			capsule.beginAtLocation(universe.loiqe_port)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			cargo.addItems([items.valenPortalKey,items.record1,items.senniPortalKey])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo,universe.loiqe_port])
		}
		m.predicate = { map.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.map1.name!)", location: universe.senni_cargo, predicate:{ cargo.contains(items.map1) }, result: {  }),
			Quest(name:"Collect \(items.currency3.name!)", location: universe.senni_harvest, predicate:{ cargo.containsLike(items.currency3) }, result: { }),
			Quest(name:"Install map", location: universe.senni_station, predicate:{ map.isInstalled == true }, result: { })
		]
		story.append(m)
		
		// MARK: Part 12
		
		m = Mission(id:(story.count), name: "Map Lesson")
		m.state = {
			capsule.beginAtLocation(universe.senni_station)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			cargo.addItems([items.valenPortalKey,items.record1,items.senniPortalKey,items.map1])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey,map])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank,universe.senni_harvest])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo,universe.loiqe_port,universe.senni_cargo])
		}
		m.quests = [
			Quest(name:"Power Map in battery", predicate:{ battery.isMapPowered() == true }, result: {  }),
			Quest(name:"Route fog to map", predicate:{ map.port.hasItemOfType(.map) }, result: {  }),
			Quest(name:"Collect third cell", location: universe.senni_fog, predicate:{ battery.hasCell(items.battery3) || cargo.contains(items.battery3) }, result: {  battery.cellPort3.enable("empty",color:grey) }),
			Quest(name:"Install cell in battery", predicate:{ battery.hasCell(items.battery3) }, result: {  }),
		]
		story.append(m)
		
		// MARK: Part 13
		
		m = Mission(id:(story.count), name: "Helmet Lesson")
		m.state = {
			capsule.beginAtLocation(universe.senni_station)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			battery.cellPort3.addEvent(items.battery3)
			cargo.addItems([items.valenPortalKey,items.record1,items.senniPortalKey,items.map1])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey,map])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank,universe.senni_harvest])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo,universe.loiqe_port,universe.senni_cargo])
		}
		m.quests = [
			Quest(name:"Route map to helmet", predicate:{ player.port.isReceivingFromPanel(map) == true }, result: {  })
		]
		story.append(m)
		
		// MARK: Part 14
		
		m = Mission(id:(story.count), name: "Create \(items.usulPortalKey)")
		m.state = story[(story.count-1)].state
		m.predicate = { cargo.contains(items.usulPortalKey) }
		m.quests = [
			Quest(name:"Collect \(items.usulPortalFragment1.name!)", location: universe.valen_fog, predicate:{ cargo.containsLike(items.currency3) }, result: {  }),
			Quest(name:"Collect \(items.usulPortalFragment2.name!)", location: universe.loiqe_fog, predicate:{ cargo.containsLike(items.currency2) }, result: {  }),
			Quest(name:"Combine fragments", predicate:{ cargo.containsLike(items.usulPortalKey) }, result: { }),
		]
		story.append(m)
		
		// MARK: Part 15
		
		m = Mission(id:(story.count), name: "Install Shield")
		m.state = {
			capsule.beginAtLocation(universe.senni_station)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			battery.cellPort3.addEvent(items.battery3)
			cargo.addItems([items.valenPortalKey,items.record1,items.senniPortalKey,items.map1,items.usulPortalKey])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey,map])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank,universe.senni_harvest])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo,universe.loiqe_port,universe.senni_cargo,universe.valen_fog,universe.loiqe_fog])
		}
		m.predicate = { map.isInstalled == true }
		m.quests = [
			Quest(name:"Install shield", location: universe.usul_station, predicate:{ shield.isInstalled == true }, result: {  }),
		]
		story.append(m)
		
		// MARK: Part 16
		
		m = Mission(id:(story.count), name: "Create \(items.endPortalKey.name)")
		m.state = {
			capsule.beginAtLocation(universe.senni_station)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			battery.cellPort3.addEvent(items.battery3)
			cargo.addItems([items.valenPortalKey,items.record1,items.senniPortalKey,items.map1,items.usulPortalKey])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey,map,shield])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank,universe.senni_harvest])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo,universe.loiqe_port,universe.senni_cargo,universe.valen_fog,universe.loiqe_fog,universe.usul_station])
		}
		m.predicate = { cargo.contains(items.endPortalKey) }
		m.quests = [
			Quest(name:"Collect \(items.endPortalKeyFragment1.name!)", predicate:{ cargo.contains(items.endPortalKeyFragment1) }, result: {  }),
			Quest(name:"Collect \(items.endPortalKeyFragment2.name!)", predicate:{ cargo.contains(items.endPortalKeyFragment2) }, result: {  }),
			Quest(name:"Combine fragments", predicate:{ cargo.containsLike(items.endPortalKey) }, result: { }),
		]
		story.append(m)

		m = Mission(id:(story.count), name: "Last Quest")
		m.state = {
			capsule.beginAtLocation(universe.senni_station)
			battery.cellPort1.addEvent(items.battery1)
			battery.cellPort2.addEvent(items.battery2)
			battery.cellPort3.addEvent(items.battery3)
			cargo.addItems([items.endPortalKey,items.record1,items.map1])
			self.setToInstalled([battery,thruster,radar,progress,pilot,exploration,radio,journey,map,shield])
			self.setToKnown([universe.loiqe_spawn,universe.loiqe_harvest,universe.loiqe_city,universe.loiqe_satellite,universe.loiqe_horadric,universe.loiqe_portal,universe.valen_station,universe.valen_cargo,universe.valen_bank,universe.senni_harvest])
			self.setToCompleted([universe.loiqe_city,universe.loiqe_satellite,universe.valen_station,universe.valen_cargo,universe.loiqe_port,universe.senni_cargo,universe.valen_fog,universe.loiqe_fog,universe.usul_station])
		}
		m.quests = [
			Quest(name:"Unlock portal", location: universe.usul, predicate:{ universe.usul.isKnown == true }, result: { })
		]
		story.append(m)
	}
	
	// MARK: Tools -
	
	func setToInstalled(panels:Array<Panel>)
	{
		for panel in panels {
			panel.onInstallationComplete()
		}
	}
	
	func setToKnown(locations:Array<Location>)
	{
		for location in locations {
			location.isKnown = true
		}
	}
	
	func setToCompleted(locations:Array<Location>)
	{
		for location in locations {
			location.isComplete = true
			location.isKnown = true
		}
	}
	
	var currentMission:Mission = Mission(id:0, name: "--")
	
	func refresh()
	{
		currentMission.validate()
		if currentMission.isCompleted == true {
			updateCurrentMission()
			helmet.addWarning(currentMission.name, color:cyan, duration:3, flag:"mission")
		}
	}
	
	func updateCurrentMission()
	{
		for mission in story {
			if mission.isCompleted == false {
				currentMission = mission
				print("# ---------------------------")
				print("# MISSION  | Reached to: \(currentMission.id)")
				print("# ---------------------------")
				game.save(currentMission.id)
				return
			}
		}
	}
}