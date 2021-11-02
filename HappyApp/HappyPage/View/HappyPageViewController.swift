import UIKit
import RxSwift

final class HappyPageViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let viewModel: HappyPageViewModel
    private var categories = [CategoryDataSource]()
    private let disposeBag = DisposeBag()

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

        setupTable()
        bind()

        viewModel.readyToRecieve()
    }
}

extension HappyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        categories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = .zero
        if categories.count > indexPath.section {
            height = categories[indexPath.section].size?.height ?? 0
        }
        return height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell") as? CustomTableViewCell else {
            fatalError("fatalError: couldn't dequeueReusableCell CustomTableViewCell")
        }
        let aCategory = categories[indexPath.section]

        cell.updateTableCell(with: aCategory)
        cell.cellDelegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 1 ? 0 : 30
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CellHeaderView()
        let aCategory = self.categories[section]
        headerView.titleLeft.text = aCategory.name
        headerView.titleRight.isHidden = aCategory.name == nil

        headerView.titleRight.text = "See all"
        let gesture = UITapGestureRecognizer(target: self, action: #selector(seeAllTapped))
        headerView.addGestureRecognizer(gesture)
        return headerView
    }
}

extension HappyPageViewController: CustomCollectionCellDelegate {
    func collectionView(collectionCell collectioncell:
                        CollectionItemViewCell?,
                        didTap tableCell: CustomTableViewCell) {

        viewModel.makeStubCall()
    }
}

private extension HappyPageViewController {
    @objc func seeAllTapped() {
        viewModel.makeStubCall()
    }

    func setupTable() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customTableViewCell")
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        tableView.dataSource = self
        tableView.delegate = self
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
            .subscribe(onNext: { [weak self] in
                self?.categories = $0
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        viewModel
            .happyPageErrorBinder
            .subscribe(onNext: { [weak self] in
                self?.showAlert(description: $0)
            })
            .disposed(by: disposeBag)
    }
}
