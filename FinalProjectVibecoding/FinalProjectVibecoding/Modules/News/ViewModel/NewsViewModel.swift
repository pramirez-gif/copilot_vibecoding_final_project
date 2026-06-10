//
//  NewsViewModel.swift
//  FinalProjectVibecoding
//
//  Created by Pablo Ramirez on 10/06/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class NewsViewModel: ObservableObject {
    @Published private(set) var articles: [Article] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let fetchArticlesUseCase: FetchArticlesUseCase
    private let coordinator: NewsCoordinator

    init(useCase: FetchArticlesUseCase, coordinator: NewsCoordinator) {
        self.fetchArticlesUseCase = useCase
        self.coordinator = coordinator
    }

    func loadArticles() {
        Task {
            await load()
        }
    }

    private func load() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await fetchArticlesUseCase.execute()
            articles = result
        } catch {
            errorMessage = error.localizedDescription
            articles = []
        }
        isLoading = false
    }

    func didSelect(_ article: Article) {
        coordinator.navigateToArticle(article)
    }
}
