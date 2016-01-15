
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Quest
{
	var name:String!
	var location:Location!
	var predicate:() -> Bool
	var result:() -> Void
	var isCompleted:Bool = false
	
	init(name:String, location:Location! = nil, predicate:() -> Bool, result: () -> Void )
	{
		self.name = name
		self.location = location
		self.predicate = predicate
		self.result = result
	}
	
	func validate()
	{
		if predicate() {
			complete()
		}
		else{
			isCompleted = false
		}
	}
	
	func complete()
	{
		if isCompleted == true { return }
		print("+ QUEST    | Complete: \(name!)")
		isCompleted = true
		self.result()
	}
}