import UIKit

extension String {
    func calculatedHeight(with width: CGFloat,and font: UIFont) -> CGFloat {
        let rect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let box = self.boundingRect(with: rect, options: .usesLineFragmentOrigin,
                                    attributes: [NSAttributedStringKey.font: font],
                                    context: nil)
        return ceil(box.height)
    }
}
