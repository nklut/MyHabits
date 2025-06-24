import UIKit

class HabitDetailsTableViewCell: UITableViewCell {

    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        //tuneView()
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
    
    func update(_ currentDate: Date) {
        lazy var dateView: UILabel = {
            let view = UILabel()
            
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            view.text = formatter.string(from: currentDate)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textColor = .black
            view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            
            return view
        }()
        
        func addSubviews() {
            contentView.addSubview(dateView)
        }

        func setupConstraints() {
            
            let safeArea = contentView.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                dateView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
                dateView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                dateView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
                dateView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            ])
        }
        
        contentView.backgroundColor = .mhGray
        addSubviews()
        setupConstraints()
        
    }
    
}
