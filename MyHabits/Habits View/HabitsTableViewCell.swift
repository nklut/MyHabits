import UIKit

class HabitsTableViewCell: UITableViewCell {
        
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

        lazy var taskLabel: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.lineBreakMode = .byWordWrapping
            view.numberOfLines = 2
            
            view.text = habitItem.name
            view.textColor = habitItem.color
            view.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
            
            return view
        }()
        
        lazy var taskDescription: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.text = habitItem.dateString
            view.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
            view.textColor = .systemGray2
            
            return view
        }()
        
        lazy var taskCounter: UILabel = {
            let view = UILabel()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.text = "Count: " + String(habitItem.trackDates.count)
            view.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.semibold)
            view.textColor = .systemGray2
            
            return view
        }()
        
        lazy var taskCheckBox: UIButton = {
            let view = UIButton(type: .custom)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBackground
            view.clipsToBounds = true
            
            let uncheckedImage = UIImage(systemName: "circle")?.withTintColor(habitItem.color, renderingMode: .alwaysOriginal)
            let checkedImage = UIImage(systemName: "checkmark.circle")?.withTintColor(habitItem.color, renderingMode: .alwaysOriginal)

            view.setImage(uncheckedImage, for: .normal)
            
            if isSelected {
                view.setImage(uncheckedImage, for: .selected)
            } else {
                view.setImage(checkedImage, for: .selected)
            }
            
            view.addTarget(self, action: #selector(isBoxChecked), for: .touchUpInside)
            
            return view
        }()

        lazy var habitViewContainer: UIView = {
            let view = UIView()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.layer.cornerRadius = 10

            return view
        }()
        
        // Add post subviews to Cell content view
        func addSubviews() {
            contentView.addSubview(habitViewContainer)
            habitViewContainer.addSubview(taskLabel)
            habitViewContainer.addSubview(taskDescription)
            habitViewContainer.addSubview(taskCounter)
            habitViewContainer.addSubview(taskCheckBox)
        }
        
        // Setup positions of views inside content view
        func setupConstraints() {
            
            let safeArea = contentView.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                
                habitViewContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
                habitViewContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                habitViewContainer.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
                habitViewContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                
                taskLabel.topAnchor.constraint(equalTo: habitViewContainer.topAnchor, constant: 20),
                taskLabel.leadingAnchor.constraint(equalTo: habitViewContainer.leadingAnchor, constant: 10),
                taskLabel.trailingAnchor.constraint(equalTo: habitViewContainer.trailingAnchor, constant: -90),
                
                taskDescription.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 5),
                taskDescription.leadingAnchor.constraint(equalTo: taskLabel.leadingAnchor),
                taskDescription.trailingAnchor.constraint(equalTo: taskLabel.trailingAnchor),
                
                taskCounter.bottomAnchor.constraint(equalTo: habitViewContainer.bottomAnchor, constant: -20),
                taskCounter.leadingAnchor.constraint(equalTo: taskLabel.leadingAnchor),
                taskCounter.trailingAnchor.constraint(equalTo: taskDescription.trailingAnchor),
                
                taskCheckBox.centerYAnchor.constraint(equalTo: habitViewContainer.centerYAnchor),
                taskCheckBox.widthAnchor.constraint(equalToConstant: 50),
                taskCheckBox.heightAnchor.constraint(equalToConstant: 50),
                taskCheckBox.trailingAnchor.constraint(equalTo: habitViewContainer.trailingAnchor, constant: -20),
            ])
        }
        
        contentView.backgroundColor = .mhGray
        addSubviews()
        setupConstraints()
    }
    
    @objc func isBoxChecked(sender: UIButton) {
        if sender.isSelected {

            sender.isSelected.toggle()
        } else {
            sender.isSelected.toggle()

        }
    }
}


//if !HabitsStore.shared.habit(habitItem, isTrackedIn: habitItem.date) {
//    HabitsStore.shared.track(habitItem)
//}
