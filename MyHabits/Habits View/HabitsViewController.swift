import UIKit

class HabitsViewController: UIViewController, HabitTableViewBarUpdate {
    
    // Lits of all Habits
    private lazy var habitsList: [Habit] = HabitsStore.shared.habits
    
    // Button for adding new Habit
    private lazy var addHabitButton: UIButton = {
        let view = UIButton(type: .custom)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.setImage(UIImage(systemName: "plus"), for: .normal)
        view.tintColor = .mhPurple
        view.addTarget(self, action: #selector(didAddHabit), for: .touchUpInside)
        
        return view
    }()
    
    // Table view for Habits
    private lazy var habitsTableView: UITableView = {
        let view = UITableView.init(frame: .zero, style: .plain)
        
        view.separatorStyle = .none
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private enum CellReuseID: String {
        case habit = "HabitsTableViewCell_ReuseID"
        case progress = "ProgressTableViewCell_ReuseID"
    }
    
    private enum HeaderFooterReuseID: String {
        case base = "TableSectionFooterHeaderView_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        setupView()
        addSubviews()
        setupSubviews()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Adds Sample Habit if none habits in list. Also works at the very first launch of the app
        if HabitsStore.shared.habits.isEmpty {
            HabitsStore.shared.habits.append(sampleHabit)
        }
        
        habitsTableView.indexPathsForSelectedRows?.forEach{ indexPath in
            habitsTableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    func reloadTableViewData() {
        
        
        
        DispatchQueue.main.async {
            self.habitsTableView.reloadData()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
    }
    
    private func addSubviews() {
        view.addSubview(addHabitButton)
        view.addSubview(habitsTableView)
    }
    
    private func setupSubviews() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            addHabitButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            addHabitButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30),
            addHabitButton.heightAnchor.constraint(equalToConstant: 22),
            addHabitButton.widthAnchor.constraint(equalToConstant: 18),
            
            habitsTableView.topAnchor.constraint(equalTo: addHabitButton.bottomAnchor),
            habitsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            habitsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            habitsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        habitsTableView.rowHeight = UITableView.automaticDimension
        habitsTableView.estimatedRowHeight = 200
        if #available(iOS 15.0, *)  {
            habitsTableView.sectionHeaderTopPadding = 0
        }
        
        habitsTableView.register(
            HabitsTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.habit.rawValue
        )
        
        habitsTableView.register(
            ProgressTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.progress.rawValue
        )
        
        habitsTableView.register(
            HabitsTableSectionFooterHeaderView.self,
            forHeaderFooterViewReuseIdentifier: HeaderFooterReuseID.base.rawValue
        )

        habitsTableView.dataSource = self
        habitsTableView.delegate = self
    }
    
    // If button pressed open Create view controller
    @objc private func didAddHabit() {
        let habitItem = Habit(name: "", date: Date.now, color: .mhBlue)
        self.navigationController?.pushViewController(HabitCreateEditView(status: .create, habitItem: habitItem), animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension HabitsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? habitsList.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1
        {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.habit.rawValue,
                for: indexPath) as? HabitsTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.delegate = self
            cell.update(habitsList[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.progress.rawValue,
                for: indexPath
            ) as? ProgressTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            
            cell.update(habitsList[indexPath.row])
            return cell
        }
    }
}

extension HabitsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 5 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 1 ? 150 : UITableView.automaticDimension
    }
    
    // Open Details View controller when cell from Habit section is taped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            navigationController?.pushViewController(HabitDetailsViewController(habitsList[indexPath.row]), animated: true)
            navigationController?.navigationBar.isHidden = false
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerForSecondSection = UIView()
            headerForSecondSection.backgroundColor = .systemGray5
            return headerForSecondSection
        } else {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: HeaderFooterReuseID.base.rawValue
            ) as? HabitsTableSectionFooterHeaderView else {
                fatalError("could not dequeueReusableCell")
            }
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
