
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class ItemCollection
{
	// Misc
	let waste = Item(name: "waste", type: .waste, note:"useless", code:"waste")
	let kelp = Item(name: "space kelp", type: .waste, note:"useless",code:"kelp")
	
	// Keys
	let loiqePortalKey = Item(name: "loiqe key", type: .key, note:"complete key", isQuest:true,code:"loiqe-key")
	
	let valenPortalKey = Item(name: "valen key", type: .key, note:"complete key", isQuest:true,code:"valen-key")
	let valenPortalFragment1 = Item(name: "valen part I", type: .fragment, note:"half Portal key", isQuest:true,code:"valen-key-1")
	let valenPortalFragment2 = Item(name: "valen part II", type: .fragment, note:"half Portal key", isQuest:true,code:"valen-key-2")
	
	let senniPortalKey = Item(name: "senni key", type: .key, note:"complete key", isQuest:true,code:"senni-key")
	
	let usulPortalKey = Item(name: "usul key", type: .key, note:"complete key", isQuest:true,code:"usul-key")
	let usulPortalFragment1 = Item(name: "usul Part I", type: .fragment, note:"half Portal key", isQuest:true,code:"usul-key-1")
	let usulPortalFragment2 = Item(name: "usul Part II", type: .fragment, note:"half Portal key", isQuest:true,code:"usul-key-2")
	
	let endPortalKey = Item(name: "End Key", type: .key, note: "[missing]", isQuest: true,code:"end-key")
	let endPortalKeyFragment1 = Item(name: "end Part I", type: .key, note: "half Portal key", isQuest: true,code:"end-key-1")
	let endPortalKeyFragment2 = Item(name: "end Part II", type: .key, note: "half Portal key", isQuest: true,code:"end-key-2")
	
	// Etc..
	
	let warpDrive = Item(name: "warpdrive", type: .drive, note:"local warpdrive", isQuest:true,code:"warp")
	
	// Records
	let record1 = Item(name: "record", type: .record, note:"audio format", isQuest:true,code:"record-1")
	let record2 = Item(name: "disk", type: .record, note:"audio format", isQuest:true,code:"record-2")
	let record3 = Item(name: "cassette", type: .record, note:"audio format", isQuest:true,code:"record-3")
	let record4 = Item(name: "drive", type: .record, note:"audio format", isQuest:true,code:"record-4")
	
	let record_oquonie = Item(name: "record", type: .record, note:"wet", isQuest:true,code:"record-5")
	
	// Maps
	let map1 = Item(name: "Fog Map", type: .map, note: "map expension", isQuest: true,code:"map-1")
	let map2 = Item(name: "Blind Map", type: .map, note: "map expension", isQuest: true,code:"map-2")
	
	// Shields(fields)
	let shield = Item(name: "glass", type: .shield, note:"star sand", isQuest:true,code:"shield-1")
	
	// Harvest
	let currency1 = Item(name: "alta", type: .currency, note:"trading currency",code:"currency-1")
	let currency2 = Item(name: "materia", type: .currency, note:"trading currency",code:"currency-2")
	let currency3 = Item(name: "natal", type: .currency, note:"trading currency",code:"currency-3")
	let currency4 = Item(name: "alteria", type: .currency, note:"From 1 & 2",code:"currency-4")
	let currency5 = Item(name: "nateria", type: .currency, note:"From 2 & 3",code:"currency-5")
	let currency6 = Item(name: "echo", type: .currency, note:"From 4 & 5",code:"currency-6")
	
	// Batteries
	let battery1  = Item(name: "cell", type: .battery, note:"power source", isQuest:true,code:"battery-1")
	let battery2  = Item(name: "cell", type: .battery, note:"power source", isQuest:true,code:"battery-2")
	let battery3  = Item(name: "cell", type: .battery, note:"power source", isQuest:true,code:"battery-3")
	
	// Echoes
	let teapot     = Item(name: "a teapot", type: .unknown, note:"unknown", isQuest:true,code:"echoes-1")
	let nestorine  = Item(name: "a pillar", type: .unknown, note:"unknown", isQuest:true,code:"echoes-2")
	
	func whenStart()
	{
		loiqePortalKey.location = universe.loiqe_portal
		valenPortalKey.location = universe.valen_portal
		senniPortalKey.location = universe.senni_portal
		usulPortalKey.location = universe.usul_portal
	}
}