import UIKit
class TabBar: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let service = MoviesService()
        
        let moviesPresenter = MoviesPresenter(service: service)
        let moviesVC = MoviesVC(presenter: moviesPresenter)
        moviesPresenter.set(view: moviesVC)
        let moviesNavVC = UINavigationController(rootViewController: moviesVC)
        
        moviesNavVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        
        let movieSearchPresenter = MovieSearchPresenter(service: service)
        let movieSearchVC = MovieSearchVC(presenter: movieSearchPresenter)
        movieSearchPresenter.set(view: movieSearchVC)
        let movieSearchNavVC = UINavigationController(rootViewController: movieSearchVC)
        
        movieSearchNavVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        
        self.viewControllers = [moviesNavVC, movieSearchNavVC]
    }
}
