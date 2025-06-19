import UIKit

class InfoViewController: UIViewController {

    
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
        view.addSubview(infoTextView)
    }
    
    private func setupView() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            infoTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            infoTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            infoTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
        
    }
}
