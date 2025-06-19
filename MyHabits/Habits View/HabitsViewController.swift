import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var habitsList: [habitListItem] = habitListItem.make()
    
    private lazy var habitsTableView: UITableView = {
        let view = UITableView.init(
            frame: .zero,
            style: .plain
        )
        view.separatorStyle = .none
        view.backgroundColor = .systemGray6
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
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(habitsTableView)
    }
    
    private func setupSubviews() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            habitsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
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
        150
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
