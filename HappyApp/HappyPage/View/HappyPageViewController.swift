import UIKit
import RxSwift
import RxCocoa

final class HappyPageViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let viewModel: HappyPageViewModel
    private let bag = DisposeBag()
    private var categories = [CategoryDataSource]()

    init(viewModel: HappyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        bind()
        setupTable()

        viewModel.readyToRecieve()
    }
}

extension HappyPageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 204
        default:
            return 280
        }
    }
}

private extension HappyPageViewController {
    @objc func seeAllTapped() {
        viewModel.makeStubCall()
    }

    func setupTable() {
        prepareTable()

        viewModel.categories.bind(to: tableView.rx.items) { [weak self] tableViewLocal, row, item -> UITableViewCell in
            var baseCell: BaseTableViewCell?
            var collectionCellsize: CGSize
            switch row {
                case 0:
                baseCell = tableViewLocal.dequeueReusableCell(withIdentifier: "customTableViewCellId") as? CustomTableViewCell
                collectionCellsize = .init(width: 158, height: 158)
                case 1:
                baseCell = tableViewLocal.dequeueReusableCell(withIdentifier: "baseTableViewCellId") as? BaseTableViewCell
                collectionCellsize = .init(width: 365, height: 180)
                default:
                baseCell = tableViewLocal.dequeueReusableCell(withIdentifier: "extendedTableViewCellId") as? ExtendedTableViewCell
                collectionCellsize = .init(width: 328, height: 234)
            }
            guard let cell = baseCell else {
                fatalError("baseTableViewCellId")
            }
            cell.setupTableCell(with: item, and: collectionCellsize)
            self?.bind(cell: cell)

            return cell
        }.disposed(by: bag)
    }

    func prepareTable() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        tableView.rx.setDelegate(self).disposed(by: bag)

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customTableViewCellId")
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: "baseTableViewCellId")
        tableView.register(ExtendedTableViewCell.self, forCellReuseIdentifier: "extendedTableViewCellId")

        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func showAlert(description: String) {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        present(alert, animated: true)
    }

    //MARK: data flow we are receiving here
    private func bind() {
        viewModel
            .happyPageViewBinder
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                self?.categories = $0
                self?.tableView.reloadData()
            })
            .disposed(by: bag)

        viewModel
            .happyPageErrorBinder
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                self?.showAlert(description: $0)
            })
            .disposed(by: bag)
    }

    private func bind(cell: BaseTableViewCell) {
        cell.viewTapBinder
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak viewModel] _ in
                viewModel?.makeStubCall()
            })
            .disposed(by: bag)
    }
}
