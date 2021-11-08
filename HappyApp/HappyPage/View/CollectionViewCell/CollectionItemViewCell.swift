import UIKit
import SnapKit

class CollectionItemViewCell: UICollectionViewCell {
    let cellImageView = UIImageView()
    let placeHolderLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupMainView()
        setupChildViews()
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
            placeHolderLabel.isHidden = false
            alignPlaceholder()
            return
        }
    }

    func alignPlaceholder() {
        // method for override
    }

    func setupChildViews() {
        // method for override
    }

    func alignViews() {
        cellImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        cellImageView.addSubview(placeHolderLabel)
        placeHolderLabel.layer.cornerRadius = 16
        placeHolderLabel.clipsToBounds = true

        placeHolderLabel.text = "Under construction"
        placeHolderLabel.numberOfLines = .zero
        placeHolderLabel.textAlignment = .center
        placeHolderLabel.backgroundColor = .orange
        placeHolderLabel.isHidden = true

        placeHolderLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
