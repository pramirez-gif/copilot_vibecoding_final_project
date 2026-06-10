import Foundation

protocol NewsRepository {
    /// Devuelve los artículos desde la fuente (remote/local).
    func fetchArticles() async throws -> [Article]
}
