import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStation : Location
{
	init(name:String = "",at: CGPoint = CGPoint(), size: Float = 1)
	{
		super.init(name:name, at:at)
		
		self.at = at
		self.size = size
		self.note = ""
		self.mesh = structures.station
		icon.replace(icons.unseen())
	}
	
	override func panel() -> Panel
	{
		let newPanel = Panel()
		
		let test = SCNLabel(text: "test", scale: 0.1, align: alignment.left)
		newPanel.addChildNode(test)
		
		return newPanel
	}
	
	// MARK: Triggers -
	
	override func onSight()
	{
		icon.replace(icons.placeholder())
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}