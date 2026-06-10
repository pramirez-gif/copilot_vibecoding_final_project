//
//  NewsView.swift
//  FinalProjectVibecoding
//
//  Created by automated assistant on 05/06/26.
//

import SwiftUI
import Combine

struct NewsView: View {
    @StateObject private var viewModel: NewsViewModel
    @ObservedObject private var coordinator: NewsCoordinator

    init(viewModel: NewsViewModel, coordinator: NewsCoordinator) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            Group {
                if viewModel.isLoading {
                    ProgressView("Cargando…")
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 8) {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                        Button("Reintentar") { viewModel.loadArticles() }
                    }
                } else {
                    List(viewModel.articles) { article in
                        Button(action: { viewModel.didSelect(article) }) {
                            Text(article.title ?? "Titular de la noticia")
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Noticias")
            .onAppear(perform: viewModel.loadArticles)
            .navigationDestination(for: Article.self) { article in
                NewsDetailView(article: article)
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock repository for previews
        class MockRepo: NewsRepository {
            func fetchArticles() async throws -> [Article] {
                return [
                    Article(
                        articleID: "mock-1",
                        link: "https://example.com/mock-article",
                        title: "Preview: Apple anuncia nuevas funciones de IA",
                        description: "Descripción de ejemplo",
                        content: "Contenido de ejemplo",
                        keywords: ["apple", "ia"],
                        creator: ["John"],
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

        let repo = MockRepo()
        let useCase = FetchArticlesUseCase(repository: repo)
        let coordinator = NewsCoordinator()
        let vm = NewsViewModel(useCase: useCase, coordinator: coordinator)
        return NewsView(viewModel: vm, coordinator: coordinator)
    }
}

