import UIKit
import SnapKit

protocol CustomCollectionCellDelegate: AnyObject {
    func collectionView(collectionCell: CollectionItemViewCell?, didTap tableCell: CustomTableViewCell)
}

class CollectionItemViewCell: UICollectionViewCell {
    let cellImageView = UIImageView()
    let placeHolderLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupMainView()
        setupPlaceholder()
        cellImageView.layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCollectionCell(with contentOfItem: CategoryItem?) {
        guard let name = contentOfItem?.imageName else {
            return
        }

        cellImageView.image = UIImage(named: name)
        alignViews()

        guard let _ = cellImageView.image else {
            preparePlaceholder()
            return
        }

        placeHolderLabel.removeFromSuperview()
    }

    func preparePlaceholder() {
        
    }

    func alignViews() {
        cellImageView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}

private extension CollectionItemViewCell {
    func setupMainView() {
        contentView.addSubview(cellImageView)
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.layer.cornerRadius = 16
    }
    
    func setupPlaceholder() {
        contentView.addSubview(placeHolderLabel)
        placeHolderLabel.layer.cornerRadius = 16
        placeHolderLabel.clipsToBounds = true

        placeHolderLabel.text = "Under construction"
        placeHolderLabel.numberOfLines = .zero
        placeHolderLabel.textAlignment = .center
        placeHolderLabel.backgroundColor = .orange

        placeHolderLabel.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
        }
    }
}
