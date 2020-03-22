import UIKit

public extension UIFont {
  var nsm_topPadding: CGFloat {
    UIScreen.nsm_ceil(self.ascender - self.capHeight)
  }

  var nsm_bottomPadding: CGFloat {
    UIScreen.nsm_ceil(-self.descender)
  }
}
