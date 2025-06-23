import UIKit

class HabitsViewController: UIViewController {
    
    // private lazy var habitsList: [habitListItem] = habitListItem.make()
    
    private lazy var addHabitButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemGray5
        view.setImage(UIImage(systemName: "plus"), for: .normal)
        view.tintColor = .mhPurple
        
        view.addTarget(self, action: #selector(didAddHabit), for: .touchUpInside)
        
        return view
        
    }()
    
    private lazy var habitsTableView: UITableView = {
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
        case habit = "HabitsTableViewCell_ReuseID"
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
        
        habitsTableView.indexPathsForSelectedRows?.forEach{ indexPath in
            habitsTableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray5
    }
    
    private func addSubviews() {
        view.addSubview(addHabitButton)
        view.addSubview(habitsTableView)
    }
    
    private func setupSubviews() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            addHabitButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            addHabitButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
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
            TableSectionFooterHeaderView.self,
            forHeaderFooterViewReuseIdentifier: HeaderFooterReuseID.base.rawValue
        )
        
        // Init behaviour
        habitsTableView.dataSource = self
        habitsTableView.delegate = self
    }
    
    @objc private func didAddHabit() {
        self.navigationController?.pushViewController(HabitCreateEditView(status: .create), animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension HabitsViewController: UITableViewDataSource {
    
    // Define Number of Sections
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        // MARK: CHANGE to 2 when PROGRESS BAR ADDED
        1
        // MARK: ----------------------------------------------------------------
    }
    
    // Define Number of cells in 1 section equal to the Amount of posts in postList
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        
        habitsList.count
        
        // MARK: ACTIVATE when PROGRESS BAR ADDED
//        if section == 1 {
//            return habitsList.count
//        } else {
//            return 1
//        }
        // MARK: ----------------------------------------------------------------
    }

    // Add post to cell according to index(Path)
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.habit.rawValue,
            for: indexPath
        ) as? HabitsTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
    
        cell.update(habitsList[indexPath.row])
        return cell
        
// MARK: ACTIVATE when PROGRESS BAR ADDED
//        if indexPath.section == 1
//        {
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: CellReuseID.post.rawValue,
//                for: indexPath
//            ) as? PostTableViewCell else {
//                fatalError("could not dequeueReusableCell")
//            }
//        
//            cell.update(postList[indexPath.row])
//            return cell
//        } else {
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: CellReuseID.photo.rawValue,
//                for: indexPath
//            ) as? PhotosTableViewCell else {
//                fatalError("could not dequeueReusableCell")
//            }
//            cell.update()
//            return cell
//        }
// MARK: ----------------------------------------------------------------        
        
    }
}

// Table delegate setup
extension HabitsViewController: UITableViewDelegate {
    
    // Define header height
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return UITableView.automaticDimension
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
        200
        //return UITableView.automaticDimension
        
//        if indexPath.section == 0 {
//            return UITableView.automaticDimension
//        }
//        else {
//            return UITableView.automaticDimension
//        }
    }
    
    
// MARK: ACTIVATE WHEN SETUP HABIT VIEW ADDED
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            navigationController?.pushViewController(PhotosViewController(), animated: true)
//        }
//    }
// MARK: ----------------------------------------------------------------

    
    // Set header as Profile Header View
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: HeaderFooterReuseID.base.rawValue
        ) as? TableSectionFooterHeaderView else {
            fatalError("could not dequeueReusableCell")
        }
        return headerView
    
// MARK: ACTIVATE when PROGRESS BAR ADDED
//        if section == 0 {
//            guard let headerView = tableView.dequeueReusableHeaderFooterView(
//                withIdentifier: HeaderFooterReuseID.base.rawValue
//            ) as? TableSectionFooterHeaderView else {
//                fatalError("could not dequeueReusableCell")
//            }
//
//            return headerView
//        
//        } else {
//            return UIView()
//        }
// MARK: ----------------------------------------------------------------
    
    }
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        //let footerView = UIView()
        //footerView.tintColor = .mhOrange
        //return footerView
        return UIView()
    }
}
