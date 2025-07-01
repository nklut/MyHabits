import UIKit

class HabitView: UIView {
    // Main view for single habit element
    // Takes Habit instance shared data as information source for subviews
    
    weak var delegateBarUpdate: HabitTableViewBarUpdate?
    var habitItem: Habit
    let uncheckedImage: UIImage
    let checkedImage: UIImage
    
    init(frame: CGRect, habitItem: Habit) {
        self.habitItem = habitItem
        self.uncheckedImage = (UIImage(systemName: "circle")?.withTintColor(habitItem.color, renderingMode: .alwaysOriginal))!
        self.checkedImage = (UIImage(systemName: "checkmark.circle.fill")?.withTintColor(habitItem.color, renderingMode: .alwaysOriginal))!
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Habit name
    lazy var habitLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 2
        
        view.text = habitItem.name
        view.textColor = habitItem.color
        view.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
        
        return view
    }()
    
    // Habit description including "Do before time ??:??"
    lazy var habitDescription: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.text = habitItem.dateString
        view.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        view.textColor = .systemGray2
        
        return view
    }()
    
    // Habit done counter. +1 for each marked habit. Once per day
    lazy var habitCounter: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Count: " + String(habitItem.trackDates.count)
        view.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.semibold)
        view.textColor = .systemGray2
        
        return view
    }()
    
    // Habit tracker button.
    lazy var habitCheckBox: UIButton = {
        let view = UIButton(type: .custom)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.setImage(checkedImage, for: .selected)
        
        // If habit is not tracked - circle. Marked circle otherwise
        habitItem.isAlreadyTakenToday ? view.setImage(checkedImage, for: .normal) : view.setImage(uncheckedImage, for: .normal)
        
        // On button press, if habit not tracked, adds Date to habitTrackDates
        view.addTarget(self, action: #selector(isBoxChecked), for: .touchUpInside)
        
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
        addSubview(habitLabel)
        addSubview(habitDescription)
        addSubview(habitCounter)
        addSubview(habitCheckBox)
    }
    
    // Setup positions of views inside content view
    func setupConstraints() {
        
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            habitLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            habitLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            habitLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            habitDescription.topAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 5),
            habitDescription.leadingAnchor.constraint(equalTo: habitLabel.leadingAnchor),
            habitDescription.trailingAnchor.constraint(equalTo: habitLabel.trailingAnchor),
            
            habitCounter.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            habitCounter.leadingAnchor.constraint(equalTo: habitLabel.leadingAnchor),
            habitCounter.trailingAnchor.constraint(equalTo: habitDescription.trailingAnchor),
            
            habitCheckBox.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            habitCheckBox.widthAnchor.constraint(equalToConstant: 50),
            habitCheckBox.heightAnchor.constraint(equalToConstant: 50),
            habitCheckBox.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
    
    // Main behaviour for the Check Box
    func habitCheckBoxTapped(_ button: UIButton) {
        
        let store = HabitsStore.shared
        var habit_index = -1
        let checkedImage = UIImage(systemName: "checkmark.circle")?.withTintColor(habitItem.color, renderingMode: .alwaysOriginal)
        
        // Find index of current habbit, if it is in the overall habits list
        for i in 0...store.habits.count-1 {
            if habitItem.name == store.habits[i].name {
                habit_index = i
            }
        }
        
        // If habbit found
        if habit_index != -1 {
            if !store.habits[habit_index].isAlreadyTakenToday {
                // If habbit not yet tracked: Track habbit
                store.track(habitItem)
                
                // Update Today's Habit completition Bar
                delegateBarUpdate?.reloadTableViewData()
            } else {
                // If habbit tracked: fixate the checkbox marked
                button.setImage(checkedImage, for: .normal)
            }
        }
        
        // Update counter view
        habitCounter.text = "Count: " + String(habitItem.trackDates.count)
    }
    
    // Toggles the checkbox
    @objc func isBoxChecked(sender: UIButton) {
        
        sender.isSelected ? sender.setImage(checkedImage, for: .normal) : habitCheckBoxTapped(sender)
        sender.isSelected.toggle()
    }
}
