import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStar : Location
{
	init(name:String,at: CGPoint = CGPoint(), color:UIColor = red)
	{
		super.init(name:name, at:at)
		
		self.at = at
		self.size = 1
		self.note = ""
		self.color = color
		self.mesh = structures.star()
		self.details = itemTypes.star
		icon.replace(icons.star_unseen(red))
		label.update(name)
	}
	
	// MARK: Icon -
	
	override func updateIcon()
	{
		if isSeen == true			{ icon.replace(icons.star(red)) }
		else if isComplete == true	{ icon.replace(icons.star(cyan)) }
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}