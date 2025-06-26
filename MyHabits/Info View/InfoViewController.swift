import UIKit

class InfoViewController: UIViewController {

    private let tempButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.setTitle("Print Habits", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.tintColor = .red
        view.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return view
    }()
    
    private let tempButton2: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.setTitle("Add habit", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.tintColor = .red
        view.addTarget(self, action: #selector(tap2), for: .touchUpInside)
        return view
    }()
    
    private let tempButton3: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.setTitle("Delete habit", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.tintColor = .red
        view.addTarget(self, action: #selector(tap3), for: .touchUpInside)
        return view
    }()
    
    private let infoTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
      
        view.text = infoText
        view.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        view.backgroundColor = .white
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Info"
        
        addSubviews()
        setupView()
    }
    
    private func addSubviews() {
        view.addSubview(tempButton)
        view.addSubview(tempButton2)
        view.addSubview(tempButton3)
        view.addSubview(infoTextView)
    }
    
    @objc func tap() {

        
        let store = HabitsStore.shared
        
        if store.habits.count != 0 {
            let habit = store.habits[0]
            print("Habit desc:")
            print("color", habit.color)
            print("date", habit.date)
            print("dateString", habit.dateString)
            print("isAlreadyTakenToday", habit.isAlreadyTakenToday)
            print("name", habit.name)
            print("trackDates", habit.trackDates)
        } else {
            print("Habits list is Empty")
        }
        print("-----------------------------------")
    }
    
    @objc func tap2() {
        
        let newHabit = Habit(name: "Sample Name", date: Date.now, color: .mhBlue)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
    }
    
    @objc func tap3() {
        
        let store = HabitsStore.shared
        store.habits = []
    }
    
    
    private func setupView() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tempButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            tempButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            tempButton.heightAnchor.constraint(equalToConstant: 20),
            tempButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            tempButton2.topAnchor.constraint(equalTo: tempButton.bottomAnchor, constant: 20),
            tempButton2.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            tempButton2.heightAnchor.constraint(equalToConstant: 20),
            tempButton2.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            tempButton3.topAnchor.constraint(equalTo: tempButton2.bottomAnchor, constant: 20),
            tempButton3.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            tempButton3.heightAnchor.constraint(equalToConstant: 20),
            tempButton3.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            //
            //infoTextView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            infoTextView.topAnchor.constraint(equalTo: tempButton3.bottomAnchor, constant: 20),
            //
            infoTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            infoTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            infoTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
    }
}
