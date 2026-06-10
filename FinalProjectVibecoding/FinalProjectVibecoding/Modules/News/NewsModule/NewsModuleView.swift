import SwiftUI

/// Módulo/ensamblador que construye el grafo de dependencias para la pantalla de Noticias
/// y expone una vista lista para usar desde la app.
struct NewsModuleView: View {
    @StateObject private var viewModel: NewsViewModel
    @StateObject private var coordinator: NewsCoordinator

    init() {
        // Endpoint con API key proporcionada
        let endpoint = "https://newsdata.io/api/1/archive?apikey=pub_fe4a320188104e76a0c9b1bac1e7dc0a&q=example&language=en&from_date=2026-06-03&to_date=2026-06-10"

        // Construcción del grafo de dependencias
        let coordinator = NewsCoordinator()
        let repository = NewsRepositoryImpl(endpoint: endpoint)
        let useCase = FetchArticlesUseCase(repository: repository)
        let vm = NewsViewModel(useCase: useCase, coordinator: coordinator)

        _coordinator = StateObject(wrappedValue: coordinator)
        _viewModel = StateObject(wrappedValue: vm)
    }

    var body: some View {
        NewsView(viewModel: viewModel, coordinator: coordinator)
    }
}

struct NewsModuleView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a preview with a mock repository to avoid network calls in canvas
        class MockRepo: NewsRepository {
            func fetchArticles() async throws -> [Article] {
                return [
                    Article(
                        articleID: "mock-1",
                        link: "https://example.com/article",
                        title: "Preview: Apple announces new AI features",
                        description: "Descripción de ejemplo",
                        content: "Contenido de ejemplo",
                        keywords: ["apple", "ai"],
                        creator: ["John Smith"],
                        language: .english,
                        country: ["us"],
                        category: ["technology"],
                        datatype: .news,
                        pubDate: "2026-06-10T15:30:00Z",
                        pubDateTZ: .utc,
                        fetchedAt: "2026-06-10T16:00:00Z",
                        imageURL: nil,
                        videoURL: nil,
                        sourceID: "bbc-news",
                        sourceName: "BBC News",
                        sourcePriority: 1,
                        sourceURL: "https://www.bbc.com",
                        sourceIcon: nil,
                        sentiment: .neutral,
                        sentimentStats: SentimentStats(negative: 0, neutral: 1, positive: 0),
                        aiTag: [],
                        aiRegion: nil,
                        aiOrg: nil,
                        aiSummary: nil,
                        duplicate: false
                    )
                ]
            }
        }

        let coordinator = NewsCoordinator()
        let useCase = FetchArticlesUseCase(repository: MockRepo())
        let vm = NewsViewModel(useCase: useCase, coordinator: coordinator)
        return NewsView(viewModel: vm, coordinator: coordinator)
    }
}
