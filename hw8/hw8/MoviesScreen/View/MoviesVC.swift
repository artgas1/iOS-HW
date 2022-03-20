
import UIKit

class MoviesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let table = UITableView()
    private var movies: [Movie] = []
    private var page = 1
    
    private let presenter: MoviesPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadMovies(page: page)
        setupUI()
    }
    
    init(presenter: MoviesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MovieCell.self, forCellReuseIdentifier: MovieCell.id)
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
        guard let cell = table.dequeueReusableCell(withIdentifier: MovieCell.id, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        print(movies[indexPath.row])
        cell.configure(movie: movies[indexPath.row])
        
        if indexPath.row == movies.count - 1 {
            page += 1
            presenter.loadMovies(page: page)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256.0
    }
}

extension MoviesVC: IMovieView {
    func setMovies(movies: [Movie]) {
        self.movies += movies
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
}
