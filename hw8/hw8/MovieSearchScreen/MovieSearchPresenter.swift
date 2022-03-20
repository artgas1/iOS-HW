
import Foundation

class MovieSearchPresenter {
    
    private let service: MoviesService
    
    init(service: MoviesService) {
        self.service = service
    }
    
    weak var view: IMovieView?
    
    func set(view: IMovieView) {
        self.view = view
    }
    
    func searchMovies(query: String) {
        service.search(query: query) { [weak self] movies in
            print(movies)
            self?.view?.setMovies(movies: movies)
        }
    }
}
