import UIKit

class TableSectionFooterHeaderView: UITableViewHeaderFooterView {
    
    private lazy var addHabitButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.setImage(UIImage(systemName: "plus"), for: .normal)
        view.tintColor = .mhPurple
        
        view.addTarget(self, action: #selector(didAddHabit), for: .touchUpInside)
        
        return view
        
    }()
    
    private lazy var headerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: ADD Actual date choice
        view.text = "Today"
        // MARK: ---------------------
        
        view.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        view.textColor = .systemGray2
        
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray6
        addSubviews()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(headerTitle)
        contentView.addSubview(addHabitButton)
    }
    private func setupView(){
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            addHabitButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            addHabitButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            addHabitButton.heightAnchor.constraint(equalToConstant: 22),
            addHabitButton.widthAnchor.constraint(equalToConstant: 18),
            
            headerTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            headerTitle.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            headerTitle.topAnchor.constraint(equalTo: addHabitButton.topAnchor, constant: 20),
            headerTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func didAddHabit() {
        print("Habit added")
    }
}
