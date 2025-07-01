import UIKit

class HabitsTableViewCell: UITableViewCell {
    
    weak var delegate: HabitTableViewBarUpdate?
        
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: not implemented")
    }

    func update(_ habitItem: Habit) {
        
        // Main Habit item view
        lazy var mainView: UIView = {
            let view = HabitView(frame: CGRect(x: 50, y: 50, width: 100, height: 100), habitItem: habitItem)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        // Container for subviews
        lazy var habitViewContainer: UIView = {
            let view = UIView()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.layer.cornerRadius = 10

            return view
        }()

        func addSubviews() {
            contentView.addSubview(habitViewContainer)
            habitViewContainer.addSubview(mainView)
        }
        
        func setupConstraints() {
            let safeArea = contentView.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                habitViewContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
                habitViewContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                habitViewContainer.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
                habitViewContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                
                mainView.topAnchor.constraint(equalTo: habitViewContainer.topAnchor, constant: 20),
                mainView.leadingAnchor.constraint(equalTo: habitViewContainer.leadingAnchor, constant: 10),
                mainView.bottomAnchor.constraint(equalTo: habitViewContainer.bottomAnchor, constant: -20),
                mainView.trailingAnchor.constraint(equalTo: habitViewContainer.trailingAnchor, constant: -10),
            ])
        }
        
        contentView.backgroundColor = .systemGray5
        addSubviews()
        setupConstraints()
    }

}

