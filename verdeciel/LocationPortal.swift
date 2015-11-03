import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationPortal : Location
{
	let destination:CGPoint!
	let sector:sectors!
	
	init(name:String,at: CGPoint,destination: CGPoint,sector:sectors = sectors.normal,color:UIColor = white)
	{
		self.destination = destination
		self.sector = sector
		
		super.init(name:name, at:at)
		
		self.at = at
		self.size = 1
		self.note = ""
		self.color = color
		self.mesh = structures.portal
		self.icon = icons.placeholder
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}