
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class QuestLibrary
{
	var tutorial:Array<Quest> = []
	var tutorialProgress:Int = 0
	var falvet:Array<Quest> = []
	var falvetProgress:Int = 0
	var senni:Array<Quest> = []
	var senniProgress:Int = 0
	var usul:Array<Quest> = []
	var usulProgress:Int = 0
	
	var updateTimer:NSTimer!
	
	var questlog:Dictionary<Chapters,Dictionary<String,Array<Quest>>>!
	
	
	init()
	{
		questlog[Chapters.tutorial]! = ["Flight" :
			[
				Quest(name:"Route cell to thruster", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { thruster.install() }),
				Quest(name:"Undock with thruster", predicate:{ capsule.dock == nil }, result: { mission.install() }),
				Quest(name:"Wait for arrival", predicate:{ universe.loiqe_landing.isKnown == true }, result: { cargo.install() }),
				Quest(name:"Route materia to cargo", predicate:{ cargo.contains(items.materia) }, result: { console.install() }),
				Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }),
				Quest(name:"Undock from Landing", predicate:{ capsule.dock == nil }, result: { radar.install() }),
				Quest(name:"Dock at city", predicate:{ universe.loiqe_city.isKnown }, result: {  })
			]
		]
		questlog[Chapters.tutorial]! = ["A Portal Key" :
			[
				Quest(name:"Trade materia for fragment", predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { }),
				Quest(name:"Select horadric", predicate:{ radar.port.event != nil && radar.port.event == universe.loiqe_horadric }, result: { pilot.install() }),
				Quest(name:"Route radar to pilot", predicate:{ radar.port.connection != nil && radar.port.connection == pilot.port }, result: {  }),
				Quest(name:"Reach Horadric", predicate:{ universe.loiqe_horadric.isKnown }, result: {  }),
				Quest(name:"Reach satellite", predicate:{ universe.loiqe_satellite.isKnown }, result: { }),
				Quest(name:"Collect second fragment", predicate:{ cargo.contains(items.valenPortalFragment2) == true }, result: { }),
				Quest(name:"Combine fragments at Horadric", predicate:{ cargo.contains(items.valenPortalKey) }, result: { })
			]
		]
		questlog[Chapters.tutorial]! = ["Reach Valen" :
			[
				Quest(name:"Unlock portal", predicate:{ universe.loiqe_portal.rightKeyPort.isReceiving(items.valenPortalKey) == true }, result: {  }),
				Quest(name:"Align to portal", predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }),
				Quest(name:"Power Thruster", predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: {  }),
				Quest(name:"Warp to valen sector", predicate:{ capsule.isWarping == true }, result: { }),
				Quest(name:"Reach Valen system", predicate:{ universe.valen_portal.isKnown == true }, result: { universe.unlock(.valen) })
			]
		]
		questlog[Chapters.tutorial]! = ["Valen" :
			[
				Quest(name:"Visit the bank", predicate:{ universe.valen_bank.isKnown == true }, result: { }),
				Quest(name:"Collect Loiqe Key", predicate:{ cargo.contains(items.loiqePortalKey) }, result: { }),
				Quest(name:"Collect Waste", predicate:{ cargo.contains(items.waste) }, result: { hatch.install() }),
				Quest(name:"Route Waste to hatch", predicate:{ hatch.port.isReceiving(items.waste) }, result: { }),
				Quest(name:"Jetison Waste", predicate:{ cargo.contains(items.waste) == false }, result: { }),
				Quest(name:"Reach satellite", predicate:{ universe.valen_satellite.isKnown == true }, result: { }),
				Quest(name:"Collect record", predicate:{ cargo.contains(items.record1) }, result: { radio.install() }),
				Quest(name:"Route record to radio", predicate:{ radio.port.isReceiving(items.record1) }, result: { }),
				Quest(name:"Collect cell at bank", predicate:{ cargo.contains(items.cell2) }, result: { }),
				Quest(name:"Route cell to battery", predicate:{ battery.hasCell(items.cell2) }, result: { })
			]
		]
		questlog[Chapters.tutorial]! = ["Extinguish the sun" :
			[
				Quest(name:"Reach station", predicate:{ universe.valen_station.isKnown == true }, result: { }),
				Quest(name:"Find credits", predicate:{ cargo.contains(items.credits.name!,type: items.credits.type) == true }, result: { }),
				Quest(name:"Install shield", predicate:{ universe.valen_station.isComplete == true }, result: { }),
				Quest(name:"Route cell to shield", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { }),
				Quest(name:"Reach Valen star", predicate:{ universe.valen.isKnown == true }, result: { }),
				Quest(name:"Extinguish the sun", predicate:{ universe.valen.isComplete == true }, result: { journey.install() ; exploration.install() ; progress.install() ; complete.install() ; universe.unlock(.cyanine) })
			]
		]
		questlog[Chapters.tutorial]! = ["Venic" :
			[
				Quest(name:"Reach venic II", predicate:{ universe.cyanine_venic.isKnown == true }, result: { universe.unlock(.venic) }),
				Quest(name:"Cross to venic", predicate:{ universe.venic.isKnown == true }, result: {  }),
				Quest(name:"Reach satellite", predicate:{ universe.venic_satellite.isKnown == true }, result: {  }),
				Quest(name:"Find array", predicate:{ universe.venic_satellite.isComplete == true }, result: {  }),
				Quest(name:"Combine cells at Horadric", predicate:{ cargo.contains(items.array2) == true }, result: {  })
			]
		]
		questlog[Chapters.tutorial]! = ["Create Venic Key" :
			[
				Quest(name:"Get fragment at", predicate:{ universe.cyanine_venic.isKnown == true }, result: { universe.unlock(.venic) })
			]
		]
		
		
		
		
		
		_tutorial()
		_falvet()
		_senni()
		_usul()
		
		ui.addMessage(tutorial.first!.name)
		universe.unlock(.loiqe)
	}
	
	// MARK: Tutorial -
	
	func _tutorial()
	{
		
		
		
		
		// Start Loiqe
		
		// Create Portal Key
		// Reach Valen
		
		
		// Start Valen(18)
		
		// Valen Shut Off The Sun
		
		// Start Venic(35)
		
		
		// Create Venic Key
		
		
		
		// Exit
		tutorial.append( Quest(name:"END QUEST", predicate:{ universe.usul_city.isKnown == true }, result: { }) )
	}
	
	func _falvet()
	{
		falvet.append( Quest(name:"Locked", predicate:{ universe.valen.isComplete == true }, result: { }) )
		falvet.append( Quest(name:"Reach falvet system", predicate:{ universe.falvet.isSeen == true }, result: { }) )
		
		falvet.append( Quest(name:"END QUEST", predicate:{ universe.usul_city.isKnown == true }, result: { }) )
	}
	
	func _senni()
	{
		senni.append( Quest(name:"Locked", predicate:{ capsule.dock != nil }, result: { }) )
		senni.append( Quest(name:"Begin falvet", predicate:{ battery.thrusterPort.origin != nil }, result: { }) )
		
		senni.append( Quest(name:"END QUEST", predicate:{ universe.usul_city.isKnown == true }, result: { }) )
	}
	
	func _usul()
	{
		usul.append( Quest(name:"Locked", predicate:{ capsule.dock != nil }, result: { }) )
		usul.append( Quest(name:"Begin falvet", predicate:{ battery.thrusterPort.origin != nil }, result: { }) )
		
		usul.append( Quest(name:"END QUEST", predicate:{ universe.usul_city.isKnown == true }, result: { }) )
	}
	
	func refresh()
	{
		let latestTutorial = tutorial[tutorialProgress]
		latestTutorial.validate()
		
		if latestTutorial.isCompleted == true {
			tutorialProgress += 1
			ui.addMessage(tutorial[tutorialProgress].name)
		}
		
		let latestFalvet = falvet[falvetProgress]
		latestFalvet.validate()
		
		if latestFalvet.isCompleted == true {
			falvetProgress += 1
		}
	}
	
	func skipTo(id:Int)
	{
		tutorialProgress = 0
		while tutorialProgress < id {
			tutorial[tutorialProgress].complete()
			tutorialProgress += 1
		}
		print(tutorialProgress)
		ui.addMessage(tutorial[tutorialProgress].name)
		refresh()
	}
}