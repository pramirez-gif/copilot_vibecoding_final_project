import Foundation

final class NewsRepositoryImpl: NewsRepository {
    private let service: NewsService
    private let endpoint: String

    init(service: NewsService = NewsService(), endpoint: String) {
        self.service = service
        self.endpoint = endpoint
    }

    func fetchArticles() async throws -> [Article] {
        return try await service.fetchArticles(from: endpoint)
    }
}
