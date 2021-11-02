import UIKit
import SnapKit

final class CollectionCellExtendedView: CollectionItemViewCell {
    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        label.textColor = UIColor(named: "HappyBlackPro")
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(subTitle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preparePlaceholder() {
        placeHolderLabel.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(170)
        }

        subTitle.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(placeHolderLabel.snp.bottom).offset(12)
        }
    }

    override func alignViews() {
        cellImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(170)
            $0.bottom.equalTo(subTitle.snp.top).inset(-12)
        }

        let height = subTitle.text?.calculatedHeight(with: 316, and: subTitle.font) ?? 0
        subTitle.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(height)
        }
    }

    override func updateCollectionCell(with contentOfItem: CategoryItem?) {
        let text = contentOfItem?.subTitle ?? ""
        subTitle.text = text
        subTitle.numberOfLines = .zero
        super.updateCollectionCell(with: contentOfItem)
    }
}
