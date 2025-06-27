import UIKit

class HabitDetailsTableSectionFooterHeaderView: UITableViewHeaderFooterView {
        
    private lazy var headerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.text = "Dates of Activity"
        
        view.backgroundColor = .systemGray5
        view.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        view.textColor = .systemGray3
        
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray5
        addSubviews()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(headerTitle)
    }
    private func setupView(){
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([            
            headerTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            headerTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            headerTitle.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            headerTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
        ])
    }
}
