
import UIKit

class MovieCell: UITableViewCell {
    static let id = "MC ID"
    static let searchId = "MSC ID"
    
    private let poster = UIImageView()
    private let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title.textAlignment = .center
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.heightAnchor.constraint(equalToConstant: 164).isActive = true
        poster.contentMode = .scaleAspectFit
        
        let stack = UIStackView(arrangedSubviews: [poster, title])
        stack.axis = .vertical
        stack.spacing = 8.0
        stack.distribution = .equalSpacing
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    
    func configure(movie: Movie) {
        title.text = movie.title
        poster.image = movie.poster
    }
    
    
}
