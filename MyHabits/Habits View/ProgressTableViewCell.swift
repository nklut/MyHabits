import UIKit

class ProgressTableViewCell: UITableViewCell {
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        tuneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: not implemented")
    }
    
    // Cell design setup
    private func tuneView() {
        backgroundColor = .tertiarySystemBackground
        contentView.backgroundColor = .tertiarySystemBackground
        textLabel?.backgroundColor = .clear
        detailTextLabel?.backgroundColor = .clear
        imageView?.backgroundColor = .clear
        contentMode = .scaleAspectFit
        accessoryType = .none
    }
    
    func update(_ habitItem: habitListItem) {
        
        lazy var progressLabelView: UILabel = {
            let view = UILabel()
            
            view.text = "You got this!"
            view.textColor = .systemGray2
            view.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            
            return view
        }()
        
        lazy var progressPercentView: UILabel = {
            let view = UILabel()
            
            view.text = "You got this!"
            // view.text = habit_done_count_today / habit_total_count_today * 100 + "%"
            view.textColor = .systemGray2
            view.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            
            return view
        }()
        lazy var progressBarView: UIProgressView = {
            let view = UIProgressView()
            
            view.progressTintColor = .mhViolet
            view.progressViewStyle = .bar
            view.trackTintColor = .systemGray5
            
            return view
        }()
        
        lazy var habitViewContainer: UIView = {
            let view = UIView()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.layer.cornerRadius = 20

            return view
        }()
        
        func addSubviews() {
            contentView.addSubview(habitViewContainer)
            habitViewContainer.addSubview(progressLabelView)
            habitViewContainer.addSubview(progressPercentView)
            habitViewContainer.addSubview(progressBarView)
 
        }
        
        // Setup positions of views inside content view
        func setupConstraints() {
            
            let safeArea = contentView.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                
                habitViewContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
                habitViewContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                habitViewContainer.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
                habitViewContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                
                progressLabelView.topAnchor.constraint(equalTo: habitViewContainer.topAnchor, constant: 10),
                progressLabelView.leadingAnchor.constraint(equalTo: habitViewContainer.leadingAnchor, constant: 10),
                progressLabelView.heightAnchor.constraint(equalToConstant: 20),
                progressLabelView.trailingAnchor.constraint(equalTo: habitViewContainer.trailingAnchor, constant: -150),
                
                progressPercentView.topAnchor.constraint(equalTo: progressLabelView.topAnchor),
                progressPercentView.widthAnchor.constraint(equalToConstant: 100),
                progressPercentView.heightAnchor.constraint(equalToConstant: 20),
                progressPercentView.trailingAnchor.constraint(equalTo: habitViewContainer.trailingAnchor, constant: -10),
                
                progressBarView.topAnchor.constraint(equalTo: progressLabelView.bottomAnchor, constant: 10),
                progressBarView.leadingAnchor.constraint(equalTo: progressLabelView.leadingAnchor),
                progressBarView.heightAnchor.constraint(equalToConstant: 10),
                progressBarView.trailingAnchor.constraint(equalTo: progressPercentView.trailingAnchor),
            ])
        }
        
        contentView.backgroundColor = .red
        addSubviews()
        setupConstraints()
        
    }
    
}
