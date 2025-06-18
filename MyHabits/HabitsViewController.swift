import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var addHabitButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.setImage(UIImage(systemName: "plus"), for: .normal)
        view.tintColor = .mhPurple
        
        view.addTarget(self, action: #selector(didAddHabit), for: .touchUpInside)
        
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .mhGrey
        
        addSubviews()
        setupSubviews()
        
    }
    
    private func addSubviews() {
        view.addSubview(addHabitButton)
    }
    
    private func setupSubviews() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            addHabitButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            addHabitButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            addHabitButton.heightAnchor.constraint(equalToConstant: 20),
            addHabitButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc private func didAddHabit() {
        print("Habit added")
    }
    
}
