import Foundation
import SwiftUI
import Combine

@MainActor
final class NewsCoordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()

    func navigateToArticle(_ article: Article) {
        path.append(article)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func reset() {
        path = NavigationPath()
    }
}
