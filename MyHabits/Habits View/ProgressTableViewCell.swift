import UIKit

class ProgressTableViewCell: UITableViewCell {
    
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
        
        lazy var progressLabelView: UILabel = {
            let view = UILabel()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.text = "You got this!"
            view.textColor = .systemGray2
            view.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            
            return view
        }()
        
        lazy var progressPercentView: UILabel = {
            let view = UILabel()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.text = String(Int(round(HabitsStore.shared.todayProgress * 100)))
            view.textColor = .systemGray2
            view.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            
            return view
        }()
        lazy var progressBarView: UIProgressView = {
            let view = UIProgressView()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.progressTintColor = .mhPurple
            view.progressViewStyle = .default
            view.trackTintColor = .systemGray5
            view.progress = HabitsStore.shared.todayProgress
            
            return view
        }()
        
        lazy var progressViewContainer: UIView = {
            let view = UIView()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.layer.cornerRadius = 10

            return view
        }()
        
        func addSubviews() {
            contentView.addSubview(progressViewContainer)
            progressViewContainer.addSubview(progressLabelView)
            progressViewContainer.addSubview(progressPercentView)
            progressViewContainer.addSubview(progressBarView)
 
        }
        
        // Setup positions of views inside content view
        func setupConstraints() {
            
            let safeArea = contentView.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                
                progressViewContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 25),
                progressViewContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                progressViewContainer.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
                progressViewContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                
                progressLabelView.topAnchor.constraint(equalTo: progressViewContainer.topAnchor, constant: 10),
                progressLabelView.leadingAnchor.constraint(equalTo: progressViewContainer.leadingAnchor, constant: 10),
                progressLabelView.trailingAnchor.constraint(equalTo: progressViewContainer.trailingAnchor, constant: -150),
                
                progressPercentView.topAnchor.constraint(equalTo: progressLabelView.topAnchor),
                progressPercentView.trailingAnchor.constraint(equalTo: progressViewContainer.trailingAnchor, constant: -10),
                
                progressBarView.topAnchor.constraint(equalTo: progressLabelView.bottomAnchor, constant: 10),
                progressBarView.leadingAnchor.constraint(equalTo: progressLabelView.leadingAnchor),
                progressBarView.heightAnchor.constraint(equalToConstant: 10),
                progressBarView.bottomAnchor.constraint(equalTo: progressViewContainer.bottomAnchor, constant: -10),
                progressBarView.trailingAnchor.constraint(equalTo: progressPercentView.trailingAnchor),
            ])
        }
        
        contentView.backgroundColor = .mhGray
        addSubviews()
        setupConstraints()
        
    }
    
}
