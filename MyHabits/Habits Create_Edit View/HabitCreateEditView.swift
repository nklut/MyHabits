import UIKit

class HabitCreateEditView: UIViewController {
    
    private var habitItem: Habit
    private var status: Status
    private var chosenDate: Date
    private var chosenColor: UIColor
    private var newName: String
    
    init(status: Status, habitItem: Habit) {
        
        self.status = status
        self.habitItem = habitItem
        self.chosenDate = Date.now
        self.chosenColor = habitItem.color
        self.newName = habitItem.name
        
        if habitItem.name == sampleHabit.name {
            self.status = .create
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var saveButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.tintColor = .mhPurple
        view.backgroundColor = .systemGray6
        view.setTitle("Save", for: .normal)
        
        return view
    }()
    
    private var cancelButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.tintColor = .mhPurple
        view.backgroundColor = .systemGray6
        view.setTitle("Cancel", for: .normal)
        
        return view
    }()
    
    private lazy var deleteHabitButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Delete habit", for: .normal)
        view.tintColor = .red
        view.setTitleColor(.red, for: .normal)
        view.backgroundColor = .white
        
        view.addTarget(self, action: #selector(didPressDeleteButton), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var habitLabelView: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Habit name"
        view.backgroundColor = .white
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        
        return view
        
    }()
    
    private lazy var habitTextField: UITextField = {
        let view = UITextField()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Run 5 km, Sleep 8 hours, etc."
        view.backgroundColor = .white
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        view.addTarget(self, action: #selector(habitLabelTextChanged), for: .editingChanged)
        
        // Disable interactions with habit name if User is Editing Habit\
        if status == .edit {
            view.text = habitItem.name
            view.textColor = .mhBlue
            view.isUserInteractionEnabled = false
        }
        
        return view
    }()
    
    private lazy var habitColorLabelView: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Color"
        view.backgroundColor = .white
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        
        return view
    }()
    
    private lazy var habitColorPreviewImage: UIImageView = {
        let view = UIImageView()
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = chosenColor
        let tapRoot = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapColorSelector)
        )
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapRoot)
        
        return view
    }()
    
    private lazy var habitTimeLabel: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Time"
        view.backgroundColor = .white
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        
        return view
    }()
    
    private lazy var habitTimeSetLabel: UILabel = {
        let view  = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.text = "Every day at "
        
        return view
        
    }()
    
    private lazy var habitTimeSet: UIDatePicker = {
        let view = UIDatePicker()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.datePickerMode = .time
        view.locale = .current
        view.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var habitScrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.addTarget(self, action: #selector(didPressSaveButton), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: saveButton), animated: true)
       
        cancelButton.addTarget(self, action: #selector(didPressCancelButton), for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: cancelButton), animated: true)
        
        view.backgroundColor = .systemGray6
        title = status == .create ? "Create" : "Edit"
        
        addSubviews()
        setupSubview()
    }
    
    private func addSubviews() {
        view.addSubview(habitScrollView)
        habitScrollView.addSubview(contentView)
        
        contentView.addSubview(habitLabelView)
        contentView.addSubview(habitTextField)
        contentView.addSubview(habitColorLabelView)
        contentView.addSubview(habitColorPreviewImage)
        contentView.addSubview(habitTimeLabel)
        contentView.addSubview(habitTimeSetLabel)
        contentView.addSubview(habitTimeSet)
        
        if status == .edit {
            contentView.addSubview(deleteHabitButton)
        }
    }
    
    private func setupSubview() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            habitScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            habitScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            habitScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            habitScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: habitScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: habitScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: habitScrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: habitScrollView.heightAnchor),
            contentView.leadingAnchor.constraint(equalTo: habitScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: habitScrollView.trailingAnchor),
            
            habitLabelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            habitLabelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            habitLabelView.heightAnchor.constraint(equalToConstant: 20),
            
            habitTextField.topAnchor.constraint(equalTo: habitLabelView.bottomAnchor, constant: 10),
            habitTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            habitTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            habitTextField.heightAnchor.constraint(equalToConstant: 20),
            
            habitColorLabelView.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 30),
            habitColorLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            habitColorLabelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            habitColorLabelView.heightAnchor.constraint(equalToConstant: 20),
            
            habitColorPreviewImage.topAnchor.constraint(equalTo: habitColorLabelView.bottomAnchor, constant: 10),
            habitColorPreviewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            habitColorPreviewImage.heightAnchor.constraint(equalToConstant: 40),
            habitColorPreviewImage.widthAnchor.constraint(equalToConstant: 40),
            
            habitTimeLabel.topAnchor.constraint(equalTo: habitColorPreviewImage.bottomAnchor, constant: 30),
            habitTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            habitTimeLabel.heightAnchor.constraint(equalToConstant: 20),
            habitTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            habitTimeSetLabel.topAnchor.constraint(equalTo: habitTimeLabel.bottomAnchor, constant: 10),
            habitTimeSetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            habitTimeSetLabel.widthAnchor.constraint(equalToConstant: 100),
            habitTimeSetLabel.heightAnchor.constraint(equalToConstant: 20),
            
            habitTimeSet.heightAnchor.constraint(equalToConstant: 30),
            habitTimeSet.leadingAnchor.constraint(equalTo: habitTimeSetLabel.leadingAnchor),
            habitTimeSet.widthAnchor.constraint(equalToConstant: 70),
            habitTimeSet.topAnchor.constraint(equalTo: habitTimeSetLabel.bottomAnchor),
        ])
        
        if status == .edit {
            NSLayoutConstraint.activate([
                deleteHabitButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                deleteHabitButton.heightAnchor.constraint(equalToConstant: 30),
                deleteHabitButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                deleteHabitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
        }
    }
    
    // Delete button behaviour
    @objc func didPressDeleteButton() {
        // Alert object
        let alert = UIAlertController(
            title: "Delete",
            message: "You want to delete " + habitItem.name + "?",
            preferredStyle: .alert
        )
        
        // Nothing on Cancel
        func cancelHabitDeletion(action: UIAlertAction) {}
        
        // If delete is accepted
        func acceptHabitDeletion(action: UIAlertAction) {
            
            let ivc = HabitsViewController()
            let store = HabitsStore.shared
            var del_index: Int = -1
            
            // Find current Habit in overall habits list
            for i in 0...store.habits.count-1 {
                if habitItem.name == store.habits[i].name {
                    del_index = i
                }
            }
            
            // Delet habit
            if del_index != -1 {
                store.habits.remove(at: del_index)
            }
            
            // Debug function - Easy clean all habits
            // HabitsStore.shared.habits.removeAll()
            
            // Open Habits list view
            self.tabBarController?.tabBar.backgroundColor = .systemGray5
            self.navigationController?.pushViewController(ivc, animated: true)
            
        }
        
        // Alert actions
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: acceptHabitDeletion))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHabitDeletion))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Assign chosen date to habit date parameter
    @objc func dateChanged(sender: UIDatePicker) {
        chosenDate = habitTimeSet.date
        print("Habit item date: ", habitItem.date)
    }
    
    // Assign chosen color to Habit color parameter
    @objc func didTapColorSelector() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "Habit Color"
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        if #available(iOS 16.0, *) {
            colorPicker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
        }
        self.present(colorPicker, animated: true)
    }
    
    // Change habit name parameter from user input
    @objc func habitLabelTextChanged() {
        newName = habitTextField.text!
    }
    
    // Open Habits list if Cancel button pressed
    @objc func didPressCancelButton() {
        let ivc: UIViewController
        if status == .create {
            ivc = HabitsViewController()
        } else {
            ivc = HabitDetailsViewController(habitItem)
        }
        self.tabBarController?.tabBar.backgroundColor = .systemGray5
        self.navigationController?.pushViewController(ivc, animated: true)
    }
    
    // Save changes to habit or creates new habit
    // Also deletes Template Habit if it is in list
    @objc func didPressSaveButton() {
        
        let newHabit = Habit(name: newName, date: chosenDate, color: chosenColor)
        let store = HabitsStore.shared
        let ivc = HabitsViewController()
        var change_index = -1
        
        // If new habit is in habits list - change only parameters of existing Habit
        for i in 0...store.habits.count - 1 {
            if newHabit.name == store.habits[i].name {
                change_index = i
                store.habits[i].date = chosenDate
                store.habits[i].color = chosenColor
            }
        }
        // If new habit is not in habits list - append new Habit to Habits list
        if change_index == -1 {
            store.habits.append(newHabit)
        }
        
        // Delete sample habit(its always at position 0)
        if store.habits[0].name == sampleHabit.name {
            store.habits.remove(at: 0)
        }
        
        // Open Habits view on press
        self.tabBarController?.tabBar.backgroundColor = .systemGray5
        self.navigationController?.pushViewController(ivc, animated: true)
    }
}

// Assign selected color to Habit color parameter
extension HabitCreateEditView: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        habitColorPreviewImage.backgroundColor = viewController.selectedColor
        chosenColor = viewController.selectedColor
    }
}
