
// MARK: - TODO
// CLIP TO BOUNDS
// IMAGE corner radius


import UIKit

class LaunchScreen: UIViewController {
    
    private lazy var logo: UIImageView = {
        let view = UIImageView(image: UIImage(named: "AppIcon-167px-83.5pt@2x.png"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var appName: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupView()
    }
        
    private func addSubviews() {
        view.addSubview(logo)
        view.addSubview(appName)
    }
    
    private func setupView() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.widthAnchor.constraint(equalToConstant: 100),
            
            appName.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            appName.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            appName.heightAnchor.constraint(equalToConstant: 30),
            appName.widthAnchor.constraint(equalTo: safeArea.widthAnchor)
            
        ])
        
    }
    
    
}
