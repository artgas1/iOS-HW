
import UIKit

class MovieSearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var searchBar: UISearchBar = UISearchBar()
    
    private let table = UITableView()
    private var movies: [Movie] = []
    
    private let presenter: MovieSearchPresenter
    
    init(presenter: MovieSearchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MovieCell.self, forCellReuseIdentifier: MovieCell.searchId)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: MovieCell.searchId, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.configure(movie: movies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256.0
    }
}

extension MovieSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == "") {
            return
        }
        presenter.searchMovies(query: searchText)
    }
}

extension MovieSearchVC: IMovieView {
    func setMovies(movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
}
