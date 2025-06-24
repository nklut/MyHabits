import UIKit

class HabitDetailsViewController: UIViewController {
    
    private lazy var habitDetailsTableView: UITableView = {
        let view = UITableView.init(
            frame: .zero,
            style: .plain
        )
        view.separatorStyle = .none
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private enum CellReuseID: String {
        case date = "HabitDetailsTableViewCell_ReuseID"
    }
    
    private enum HeaderFooterReuseID: String {
        case base = "HabitDetailsTableSectionFooterHeaderView_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupSubviews()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        habitDetailsTableView.indexPathsForSelectedRows?.forEach{ indexPath in
            habitDetailsTableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray5
    }
    
    private func addSubviews() {
        view.addSubview(habitDetailsTableView)
    }
    
    private func setupSubviews() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            habitDetailsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            habitDetailsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            habitDetailsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            habitDetailsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        
        habitDetailsTableView.rowHeight = UITableView.automaticDimension
        habitDetailsTableView.estimatedRowHeight = 50
        if #available(iOS 15.0, *)  {
            habitDetailsTableView.sectionHeaderTopPadding = 0
        }
        
        habitDetailsTableView.register(
            HabitDetailsTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.date.rawValue
        )
        
        habitDetailsTableView.register(
            HabitDetailsTableSectionFooterHeaderView.self,
            forHeaderFooterViewReuseIdentifier: HeaderFooterReuseID.base.rawValue
        )
        
        // Init behaviour
        habitDetailsTableView.dataSource = self
        habitDetailsTableView.delegate = self
    }
    
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    // Define Number of Sections
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        1
    }
    
    // Define Number of cells in 1 section equal to the Amount of posts in postList
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        habitsAllDates.count
    }

    // Add post to cell according to index(Path)
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.date.rawValue,
            for: indexPath
        ) as? HabitDetailsTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        cell.update(habitsAllDates[indexPath.row])
        return cell
        
    }
}

// Table delegate setup
extension HabitDetailsViewController: UITableViewDelegate {
    
    // Define header height
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        0
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(HabitCreateEditView(status: .edit), animated: true)
        navigationController?.navigationBar.isHidden = false

    }

    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: HeaderFooterReuseID.base.rawValue
        ) as? HabitDetailsTableSectionFooterHeaderView else {
            fatalError("could not dequeueReusableCell")
        }
        return headerView
    
    }
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        return UIView()
    }
}

