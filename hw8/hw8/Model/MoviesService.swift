import Foundation

class MoviesService {
    
    private var sessions: [URLSessionDataTask] = []
    
    func search(query: String, completion: @escaping ([Movie]) -> Void) {
        sessions.forEach { $0.cancel() }
        sessions = []
        guard let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return assertionFailure ("some problems with path")
        }
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Constants.key)&language=ruRu&query=\(escapedQuery)") else
        { return  assertionFailure ("some problems with url") }
        loadMovies(url: url, completion: completion)
    }
    
    func loadAll(page: Int, completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.key)&language=ruRu&page=\(page)") else
        { return  assertionFailure ("some problems with url") }
        loadMovies(url: url, completion: completion)
    }
    
    func loadMovies(url: URL, completion: @escaping ([Movie]) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let session = URLSession.shared.dataTask(with: URLRequest (url: url), completionHandler: { [weak self] data, _, _
                                                        in
                                                        guard
                                                            let data = data,
                                                            let dict = try? JSONSerialization.jsonObject (with: data, options:
                                                                                                            .allowFragments) as? [String: Any],
                                                            let results = dict["results"] as? [[String: Any]]
                                                        else { return }
                                                        let movies: [Movie] = results.map { params in
                                                            let title = params["title"] as! String
                                                            let imagePath = params["poster_path"] as? String
                                                            return Movie (
                                                                title: title,
                                                                posterPath: imagePath)
                                                        }
                                                        self?.loadImagesForMovies (movies) { movies in
                                                           completion(movies)
                                                        }})
            self?.sessions.append(session)
            session.resume()
        }
    }
    
    private func loadImagesForMovies (_ movies: [Movie], completion: @escaping ( [Movie]) ->
                                        Void) {
        let group = DispatchGroup()
        for movie in movies {
            group.enter()
            DispatchQueue.global(qos: .background).async {
                movie.loadPoster {
                    _ in
                    group.leave()
                }
            }
        }
        group.notify (queue: .main) {
            completion (movies)
        }
    }
}
