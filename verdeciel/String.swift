
import Foundation

extension String
{
	func subString(var start: Int, var length: Int) -> String
	{
		if start+length > self.characters.count { length = self.characters.count - start }
		if start > self.characters.count { start = self.characters.count ; length = 0 }
		let range = Range<String.Index>(start: startIndex.advancedBy(start), end: startIndex.advancedBy(start + length))
		return self.substringWithRange(range)
	}
}