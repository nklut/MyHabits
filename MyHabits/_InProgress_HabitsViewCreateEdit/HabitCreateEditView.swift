import UIKit

class HabitCreateEditView: UIViewController {
    
    var status: Status
    var habitLabel: String = "Unknown Habit"
    var habitColor: UIColor = .mhOrange
    
    init(status: Status) {
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var saveButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.tintColor = .mhPurple
        view.backgroundColor = .systemGray5
        view.setTitle("Save", for: .normal)
        
        return view
    }()
    
    private var cancelButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.tintColor = .mhPurple
        view.backgroundColor = .systemGray5
        view.setTitle("Cancel", for: .normal)
        
        return view
    }()
    
    private lazy var habitLabelView: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Habit"
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
        view.backgroundColor = .mhOrange
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
        view.text = "Every day at"
        
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
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private lazy var habitScrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.addTarget(self, action: #selector(didPressSaveButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didPressCancelButton), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: saveButton), animated: true)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: cancelButton), animated: true)
        
        if status == .create {
            title = "Create"
        } else {
            title = "Edit"
        }
        
        view.backgroundColor = .systemGray5        
        addSubviews()
        setupView()
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
    }
    
    private func setupView() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            habitScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            habitScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            habitScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            habitScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: habitScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: habitScrollView.bottomAnchor),
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
          //  habitTimeSetLabel.heightAnchor.constraint(equalToConstant: 40),
            habitTimeSetLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            habitTimeSet.heightAnchor.constraint(equalToConstant: 30),
            habitTimeSet.leadingAnchor.constraint(equalTo: habitTimeSetLabel.trailingAnchor, constant: -10),
            habitTimeSet.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            habitTimeSet.bottomAnchor.constraint(equalTo: habitTimeSetLabel.bottomAnchor),
        ])
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
        
        print("Hour: ", components.hour ?? "unk_hours")
        print("Minutes: ", components.minute ?? "unk_minutes")
    }
    
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
    
    @objc func habitLabelTextChanged() {
        habitLabel = habitTextField.text!
    }
    
    @objc func didPressCancelButton() {
        let ivc = HabitsViewController()
        self.tabBarController?.tabBar.backgroundColor = .systemGray5
        self.navigationController?.pushViewController(ivc, animated: true)
    }
    
    @objc func didPressSaveButton() {
        let ivc = HabitsViewController()
        self.tabBarController?.tabBar.backgroundColor = .systemGray5
        
        lazy var updatedList: [habitListItem] = habitListItem.addHabit(
            item: habitListItem(
                habitLabel: habitLabel,
                habitDescription: "Habit 6 description",
                habitCounter: "Habit 6: 3",
                HabitColor: habitColor),
            list: habitsList)
        habitsList = updatedList
        
        self.navigationController?.pushViewController(ivc, animated: true)
        
    }
}


extension HabitCreateEditView: UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        habitColorPreviewImage.backgroundColor = viewController.selectedColor
        habitColor = viewController.selectedColor
    }
    
}
