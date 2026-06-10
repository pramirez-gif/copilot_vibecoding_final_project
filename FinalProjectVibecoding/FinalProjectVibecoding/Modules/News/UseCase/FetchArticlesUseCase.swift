import Foundation

struct FetchArticlesUseCase {
    private let repository: NewsRepository

    init(repository: NewsRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Article] {
        return try await repository.fetchArticles()
    }
}
