import Foundation
import UIKit

final class CustomTableViewCell: UITableViewCell {
    weak var cellDelegate: CustomCollectionCellDelegate?
    private var collectionView = UICollectionView(frame: CGRect(origin: .zero, size: CGSize(width: 375, height: 88)), collectionViewLayout: UICollectionViewFlowLayout())
    private var category: CategoryDataSource?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateTableCell(with category: CategoryDataSource) {
        self.category = category
        updateCollectionItem(with: category.size)
        collectionView.reloadData()
    }
}

extension CustomTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionItemViewCell
        cellDelegate?.collectionView(collectionCell: cell, didTap: self)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        category?.categoryItems.count ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionCell = CollectionItemViewCell()
        let contentOfItem = category?.categoryItems[indexPath.item]
        
        if contentOfItem?.subTitle == nil {
            collectionCell = setupCollectionItemViewCell(collectionView: collectionView, with: indexPath)
        } else {
            collectionCell = setupExtendedCollectionCell(collectionView: collectionView, with: indexPath)
        }

        collectionCell.updateCollectionCell(with: contentOfItem)
        return collectionCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         10
    }
}

extension CustomTableViewCell: UICollectionViewDelegateFlowLayout {
    private func updateCollectionItem(with size: CGSize?) {
        guard let itemSize = size else {
            return
        }

        let collectionViewlayout = UICollectionViewFlowLayout()
        collectionViewlayout.scrollDirection = .horizontal
        collectionViewlayout.itemSize = CGSize(width: itemSize.width, height: itemSize.height)
        collectionView.collectionViewLayout = collectionViewlayout
        collectionView.showsHorizontalScrollIndicator = false
    }
}

private extension CustomTableViewCell {
    func setupCollectionView() {
        contentView.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(CollectionItemViewCell.self, forCellWithReuseIdentifier: "collectionItemViewCell")
        collectionView.register(CollectionCellExtendedView.self, forCellWithReuseIdentifier: "collectionCellExtendedView")
    }

    private func setupExtendedCollectionCell(collectionView: UICollectionView, with indexPath: IndexPath) -> CollectionCellExtendedView {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellExtendedView", for: indexPath) as? CollectionCellExtendedView else {
            fatalError("couldn't dequeueReusableCell")
        }
        return cell
    }

    private func setupCollectionItemViewCell(collectionView: UICollectionView, with indexPath: IndexPath) -> CollectionItemViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionItemViewCell", for: indexPath) as? CollectionItemViewCell else {
            fatalError("couldn't dequeueReusableCell")
        }
        return cell
    }
}
