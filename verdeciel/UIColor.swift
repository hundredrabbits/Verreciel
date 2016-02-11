
//  Created by Devine Lu Linvega on 2016-02-10.
//  Copyright © 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

extension UIColor
{
	func rgb() -> (red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat)?
	{
		var fRed : CGFloat = 0
		var fGreen : CGFloat = 0
		var fBlue : CGFloat = 0
		var fAlpha: CGFloat = 0
		if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
			return (red:fRed, green:fGreen, blue:fBlue, alpha:fAlpha)
		} else {
			return nil
		}
	}
}