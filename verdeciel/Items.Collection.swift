
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class ItemCollection
{
	// Capsule
	let nataniev = Item(name: "nataniev", type: .cypher, note:"v0.3", isQuest:true)
	let starmap = Item(name: "starmap", type: .map, note:"route to helmet", isQuest:true)
	
	// Misc
	let waste = Item(name: "waste", type: .waste, note:"useless junk")
	
	// Keys
	
	let loiqePortalKey = Item(name: "loiqe key", type: .key, note:"complete key", isQuest:true)
	
	let valenPortalKey = Item(name: "valen key", type: .key, note:"complete key", isQuest:true)
	let valenPortalFragment1 = Item(name: "key part I", type: .fragment, note:"half a Portal key", isQuest:true)
	let valenPortalFragment2 = Item(name: "key part II", type: .fragment, note:"half a Portal key", isQuest:true)
	
	let senniPortalKey = Item(name: "senni key", type: .key, note:"complete key", isQuest:true)
	
	let usulPortalKey = Item(name: "usul key", type: .key, note:"complete key", isQuest:true)
	let usulPortalFragment1 = Item(name: "Key Part I", type: .fragment, note:"half a Portal key", isQuest:true)
	let usulPortalFragment2 = Item(name: "Key Part II", type: .fragment, note:"half a Portal key", isQuest:true)
	
	let endKeyFragment1 = Item(name: "Key Part I", type: .key, note: "half a Portal key", isQuest: true)
	let endKeyFragment2 = Item(name: "Key Part II", type: .key, note: "half a Portal key", isQuest: true)
	let endKey = Item(name: "End Key", type: .key, note: "[missing]", isQuest: true)
	
	// Etc..
	
	let warpDrive = Item(name: "warpdrive", type: .drive, note:"local warpdrive", isQuest:true)
	
	// Records
	let record1 = Item(name: "record", type: .record, note:"an old audio tape", isQuest:true)
	let record2 = Item(name: "record", type: .record, note:"an old audio tape", isQuest:true)
	let record3 = Item(name: "record", type: .record, note:"an old audio tape", isQuest:true)
	let record4 = Item(name: "record", type: .record, note:"an old audio tape", isQuest:true)
	let record5 = Item(name: "record", type: .record, note:"an old audio tape", isQuest:true)
	
	// Maps
	let map1 = Item(name: "Fog Map", type: .map, note: "[missing]", isQuest: true)
	let map2 = Item(name: "Ghost Map", type: .map, note: "[missing]", isQuest: true)
	let map3 = Item(name: "Blind Map", type: .map, note: "[missing]", isQuest: true)
	
	// Enigma
	let cypher1 = Item(name: "cypher 1", type: .cypher, note:"[missing]", isQuest:true)
	let cypher2 = Item(name: "cypher 2", type: .cypher, note:"[missing]", isQuest:true)
	
	// Shields(fields)
	let shield1 = Item(name: "shield 1", type: .shield, note:"[missing]", isQuest:true)
	let shield2 = Item(name: "shield 2", type: .shield, note:"[missing]", isQuest:true)
	
	// Harvest
	let currency1 = Item(name: "alta", type: .currency, note:"trading currency")
	let currency2 = Item(name: "materia", type: .currency, note:"trading currency")
	let currency3 = Item(name: "natal", type: .currency, note:"trading currency")
	let currency4 = Item(name: "alteria", type: .currency, note:"From 1 & 2")
	let currency5 = Item(name: "nateria", type: .currency, note:"From 2 & 3")
	let currency6 = Item(name: "ecco", type: .currency, note:"From 4 & 5")
	
	// Batteries
	let battery1  = Item(name: "cell", type: .battery, note:"gives little power", isQuest:true)
	let battery2  = Item(name: "cell", type: .battery, note:"gives little power", isQuest:true)
	let battery3  = Item(name: "cell", type: .battery, note:"gives little power", isQuest:true)
	
	func whenStart()
	{
		loiqePortalKey.location = universe.loiqe_portal
		valenPortalKey.location = universe.valen_portal
		senniPortalKey.location = universe.senni_portal
		usulPortalKey.location = universe.usul_portal
	}
}