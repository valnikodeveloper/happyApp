import UIKit

final class CollectionCellUsualView: CollectionItemViewCell {
    override func alignViews() {
        cellImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
