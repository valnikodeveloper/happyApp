import UIKit
import RxSwift

typealias CollectionViewTap = (collectionCell: CollectionItemViewCell?, tableCell: BaseTableViewCell)

class BaseTableViewCell: UITableViewCell {
    private(set) var viewTap = PublishSubject<CollectionViewTap>()

    var viewTapBinder: Observable<CollectionViewTap> {
        return viewTap.asObservable()
    }

    private (set) var itemSize: CGSize = .zero
    private(set) var collectionView = UICollectionView(frame: CGRect(origin: .zero, size: CGSize(width: 375, height: 88)), collectionViewLayout: UICollectionViewFlowLayout())
    private var category: CategoryDataSource?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupChildViews()
        setupCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTableCell(with category: CategoryDataSource, and itemSize: CGSize) {
        self.category = category
        self.itemSize = itemSize
        collectionViewAlign()
        collectionView.reloadData()
    }

    func collectionViewAlign() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupChildViews() {
        // method for override
    }

    func setupCollectionItemViewCell(collectionView: UICollectionView, with indexPath: IndexPath) -> CollectionItemViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionItemViewCell", for: indexPath) as? CollectionItemViewCell else {
            fatalError("couldn't dequeueReusableCell")
        }
        return cell
    }
}

extension BaseTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionItemViewCell
        let colletionViewTap = CollectionViewTap(collectionCell: cell, tableCell: self)

        viewTap.onNext(colletionViewTap)
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

        collectionCell = setupCollectionItemViewCell(collectionView: collectionView, with: indexPath)

        collectionCell.updateCollectionCell(with: contentOfItem)
        return collectionCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 20, bottom: 0, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         10
    }

    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
        itemSize
        }
}

private extension BaseTableViewCell {
    func setupCollectionView() {
        contentView.addSubview(collectionView)

        contentView.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(CollectionItemViewCell.self, forCellWithReuseIdentifier: "collectionItemViewCell")
        collectionView.register(CollectionCellExtendedView.self, forCellWithReuseIdentifier: "collectionCellExtendedView")
        collectionView.register(CollectionCellUsualView.self, forCellWithReuseIdentifier: "collectionCellUsualView")

        updateCollectionItem()
    }

    func updateCollectionItem() {
        let collectionViewlayout = UICollectionViewFlowLayout()
        collectionViewlayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewlayout
        collectionView.showsHorizontalScrollIndicator = false
    }
}
