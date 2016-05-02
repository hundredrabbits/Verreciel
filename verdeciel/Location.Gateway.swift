import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationTransit : Location
{
	init(name:String, system:Systems, at: CGPoint, mapRequirement:Item! = nil)
	{
		super.init(name:name,system:system, at:at, icon:IconTransit(), structure:Structure())
	}
	
	// MARK: Panel -
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()

		return newPanel
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconTransit : Icon
{
	override init()
	{
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}