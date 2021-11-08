import UIKit
import SnapKit

final class CollectionCellExtendedView: CollectionItemViewCell {
    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        label.textColor = UIColor(named: "HappyBlackPro")
        return label
    }()

    override func setupChildViews() {
        contentView.addSubview(subTitle)
    }

    override func alignPlaceholder() {
        cellImageView.snp.remakeConstraints {
            $0.left.right.top.equalToSuperview()
            let spaceExceptImage = 64 as CGFloat
            $0.height.equalTo(frame.height - spaceExceptImage)
        }

        subTitle.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(cellImageView.snp.bottom).offset(12)
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }

    override func alignViews() {
        cellImageView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(subTitle.snp.top).inset(-12)
        }

        subTitle.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }
    }

    override func updateCollectionCell(with contentOfItem: CategoryItem?) {
        let text = contentOfItem?.subTitle ?? ""
        subTitle.text = text
        subTitle.numberOfLines = .zero
        super.updateCollectionCell(with: contentOfItem)
    }
}
