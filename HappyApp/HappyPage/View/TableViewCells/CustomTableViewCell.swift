import UIKit

class CustomTableViewCell: BaseTableViewCell {
    let header = CellHeaderView()

    override func setupChildViews() {
        contentView.addSubview(header)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        header.titleRight.addGestureRecognizer(tap)
    }

    override func setupTableCell(with category: CategoryDataSource, and itemSize: CGSize) {
        header.titleLeft.text = category.name
        super.setupTableCell(with: category, and: itemSize)
    }

    override func collectionViewAlign() {
        header.snp.makeConstraints {
            $0.top.right.left.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.top.equalTo(header.snp.bottom).offset(15)
            $0.height.equalTo(itemSize.height)
        }
    }

    override func setupCollectionItemViewCell(collectionView: UICollectionView, with indexPath: IndexPath) -> CollectionItemViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellUsualView", for: indexPath) as? CollectionCellUsualView

        guard let cell = itemCell else {
            return super.setupCollectionItemViewCell(collectionView: collectionView, with: indexPath)
        }

        return cell
    }
}

private extension CustomTableViewCell {
    @objc func didTap() {
        let viewTapped = CollectionViewTap(collectionCell: nil, tableCell: self)

        viewTap.onNext(viewTapped)
    }
}
