import UIKit

final class CellHeaderView: UIView {
    private(set) lazy var titleLeft: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.bold)
        label.textColor = UIColor(named: "HappyBlack")
        return label
    }()

    private(set) lazy var titleRight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        label.textColor = UIColor(named: "HappyPurple")
        label.text = "See all"
        label.isUserInteractionEnabled = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLeft)
        addSubview(titleRight)

        backgroundColor = .white

        titleLeft.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(5)
        }

        titleRight.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.left.greaterThanOrEqualTo(titleLeft.snp.right).offset(20)
            $0.right.equalToSuperview().inset(20)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
