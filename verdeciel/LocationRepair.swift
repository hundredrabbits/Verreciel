import UIKit
import QuartzCore
import SceneKit
import Foundation

class eventRepair : Location
{
	init(name:String = "",at: CGPoint = CGPoint())
	{
		super.init(name: name, at: at)
		
		self.at = at
		self.size = size
		self.note = ""
		
		self.interface = panel()
	}
	
	override func panel() -> Panel
	{
		let newPanel = Panel()
		return newPanel
	}
	
	override func listen(event: Event)
	{
		
	}
	
	override func sight()
	{
		updateSprite()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}