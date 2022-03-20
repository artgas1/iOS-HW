
import Foundation

protocol IMovieView: AnyObject {
    func setMovies(movies: [Movie])
}

class MoviesPresenter {
    
    private let service: MoviesService
    
    init(service: MoviesService) {
        self.service = service
    }
    
    weak var view: IMovieView?
    
    func set(view: IMovieView) {
        self.view = view
    }
    
    func loadMovies(page: Int) {
        service.loadAll(page: page) { [weak self] movies in
            print(movies)
            self?.view?.setMovies(movies: movies)
        }
    }
}
