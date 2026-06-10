import SwiftUI

struct NewsDetailView: View {
    let article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(article.title ?? "Sin título")
                    .font(.title)
                    .bold()

                if let author = article.creator {
                    Text("Por \(author)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let description = article.description {
                    Text(description)
                        .font(.body)
                }

                Text(article.content)
                    .font(.body)

                Spacer()
            }
            .padding()
        }
        .navigationTitle(article.sourceName ?? "Artículo")
        .navigationBarTitleDisplayMode(.inline)
    }
}
