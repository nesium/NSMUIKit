import Flex
import UIKit

public class Label: UILabel {
  public init(text: String? = nil) {
    super.init(frame: .zero)
    self.text = text
  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override var text: String? {
    didSet {
      if self.text != oldValue {
        self.flex.setIsDirty()
      }
    }
  }

  public override var alignmentRectInsets: UIEdgeInsets {
    UIEdgeInsets(
      top: self.font.nsm_topPadding,
      left: 0,
      bottom: self.font.nsm_bottomPadding,
      right: 0
    )
  }

  public override func sizeThatFits(_ size: CGSize) -> CGSize {
    let requiredSize: CGSize = super.sizeThatFits(size)
    return CGSize(
      width: requiredSize.width,
      height: max(UIScreen.nsm_ceil(self.font.lineHeight), requiredSize.height)
    )
  }
}
