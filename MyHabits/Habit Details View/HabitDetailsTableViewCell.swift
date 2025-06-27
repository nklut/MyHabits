import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: not implemented")
    }
    
    func update(_ date: Date, _ habitItem: Habit) {
        
        // MArker if Habit was tracked in specific date
        lazy var trackedMark: UIImageView = {
            let view = UIImageView()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            if HabitsStore.shared.habit(habitItem, isTrackedIn: date) {
                view.image = UIImage(systemName: "checkmark")?.withTintColor(habitItem.color, renderingMode: .alwaysOriginal)
            }
            
            return view
        }()
        
        // Date representation for table cell
        lazy var dateView: UILabel = {
            let view = UILabel()
            let formatter = DateFormatter()
            
            formatter.dateStyle = .short
            view.text = formatter.string(from: habitItem.date)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textColor = .black
            view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            view.backgroundColor = .white
            
            return view
        }()
        
        func addSubviews() {
            contentView.addSubview(dateView)
            contentView.addSubview(trackedMark)
        }

        func setupConstraints() {
            let safeArea = contentView.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                dateView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
                dateView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                dateView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
                dateView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -60),
                
                trackedMark.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
                trackedMark.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                trackedMark.heightAnchor.constraint(equalToConstant: 20),
                trackedMark.widthAnchor.constraint(equalToConstant: 20)
            ])
        }
        
        contentView.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
}
