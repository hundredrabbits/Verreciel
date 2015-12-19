import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStar : Location
{
	init(name:String,at: CGPoint = CGPoint(), system:Systems, color:UIColor = red)
	{
		super.init(name:name,system:system, at:at)
		
		self.name = name
		self.type = .star
		self.system = system
		self.at = at
		self.note = ""
		self.color = color
		self.mesh = structures.star()
		self.type = LocationTypes.star
		icon.replace(icons.star_unseen(red))
		label.update(name)
	}
	
	// MARK: Icon -
	
	override func updateIcon()
	{
		if isSeen == true			{ icon.replace(icons.star(red)) }
		else if isComplete == true	{ icon.replace(icons.star(cyan)) }
	}
	
	override func onApproach()
	{
		print("* EVENT    | Approached \(self.name!)")
		space.startInstance(self)
		update()
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}