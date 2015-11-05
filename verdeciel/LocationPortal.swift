import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationPortal : Location
{
	let destination:CGPoint!
	let sector:sectors!
	
	init(name:String,at: CGPoint,destination:CGPoint,sector:sectors = sectors.normal,color:UIColor = white)
	{
		self.destination = destination
		self.sector = sector
		
		super.init(name:name, at:at)
		
		self.at = at
		self.size = 1
		self.note = ""
		self.color = color
		self.mesh = structures.portal()
		icon.replace(icons.placeholder())
	}
	
	// MARK: Icon -
	
	override func updateIcon()
	{
		if isSeen == false			{ icon.replace(icons.portal(grey)) }
		else if isKnown == false	{ icon.replace(icons.portal(white)) }
		else if isComplete == true	{ icon.replace(icons.portal(cyan)) }
		else						{ icon.replace(icons.portal(red)) }
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}