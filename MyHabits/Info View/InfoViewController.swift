import UIKit

class InfoViewController: UIViewController {
    
    // Info View Text Label
    private lazy var infoLabel: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Привычка за 21 день"
        view.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        view.backgroundColor = .white
        
        return view
    }()

    // Info View Text 
    private lazy var infoTextView: UITextView = {
        let view = UITextView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
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
        view.addSubview(infoTextView)
        view.addSubview(infoLabel)
    }
    
    private func setupView() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            infoTextView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            infoTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            infoTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            infoTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
    }
}
