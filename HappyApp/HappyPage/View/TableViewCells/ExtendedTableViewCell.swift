import UIKit

final class ExtendedTableViewCell: CustomTableViewCell {
    override func setupCollectionItemViewCell(collectionView: UICollectionView, with indexPath: IndexPath) -> CollectionItemViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellExtendedView", for: indexPath) as? CollectionCellExtendedView

        guard let cell = itemCell else {
            return super.setupCollectionItemViewCell(collectionView: collectionView, with: indexPath)
        }

        return cell
    }
}
