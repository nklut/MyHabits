import UIKit

class HabitDetailsViewController: UIViewController {
    
    private var habitItem: Habit
    private var habitDates: [Date]
    
    init(_ habitItem: Habit) {
        self.habitItem = habitItem
        self.habitDates = HabitsStore.shared.dates
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var backButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.tintColor = .mhPurple
        view.backgroundColor = .systemGray6
        view.setTitle("Today", for: .normal)
        
        return view
    }()
    
    private var editButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.tintColor = .mhPurple
        view.backgroundColor = .systemGray6
        view.setTitle("Edit", for: .normal)
        
        return view
    }()
    
    // Main table for current habit trcked dates
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

        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: backButton), animated: true)
        
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: editButton), animated: true)
        
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
        view.backgroundColor = .systemGray6
        title = habitItem.name
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
    
    // Open edit view on button tap
    @objc func didTapEditButton() {
        navigationController?.pushViewController(HabitCreateEditView(status: .edit, habitItem: habitItem), animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func didTapBackButton() {
        navigationController?.pushViewController(HabitsViewController(), animated: true)
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        habitDates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.date.rawValue,
            for: indexPath
        ) as? HabitDetailsTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        cell.update(habitDates[indexPath.row], habitItem)
        return cell
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: HeaderFooterReuseID.base.rawValue
        ) as? HabitDetailsTableSectionFooterHeaderView else {
            fatalError("could not dequeueReusableCell")
        }
        return headerView
    
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
