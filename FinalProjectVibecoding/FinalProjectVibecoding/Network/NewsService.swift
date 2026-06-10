//
//  NewsService.swift
//  FinalProjectVibecoding
//
//  Created by Pablo Ramirez on 10/06/26.
//


import Foundation

/// Servicio responsable de realizar peticiones a una API REST que devuelve noticias.
/// Utiliza async/await y devuelve un array de `Article` (modelo en `Models/Article.swift`).
struct NewsService {
    enum NewsServiceError: Error, LocalizedError {
        case invalidURL
        case requestFailed(underlying: Error)
        case invalidResponse(statusCode: Int)
        case decodingFailed(underlying: Error)

        var errorDescription: String? {
            switch self {
            case .invalidURL: return "URL inválida"
            case .requestFailed(let underlying): return "La petición falló: \(underlying.localizedDescription)"
            case .invalidResponse(let status): return "Respuesta HTTP inválida: \(status)"
            case .decodingFailed(let underlying): return "Error al decodificar JSON: \(underlying.localizedDescription)"
            }
        }
    }

    /// Realiza la petición al `url` indicado y decodifica la respuesta como `NewsResponse`, devolviendo los artículos.
    /// - Parameter url: URL del endpoint que devuelve el JSON esperado.
    /// - Returns: Array de `Article`.
    func fetchArticles(from url: URL) async throws -> [Article] {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Si necesitas cabeceras (API key, Accept, etc.) añádelas aquí.
        // request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let http = response as? HTTPURLResponse, 200...299 ~= http.statusCode else {
                let status = (response as? HTTPURLResponse)?.statusCode ?? -1
                throw NewsServiceError.invalidResponse(statusCode: status)
            }

            let decoder = JSONDecoder()
            // Si decides cambiar `publishedAt` a Date, habilita:
            // decoder.dateDecodingStrategy = .iso8601

            do {
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                return newsResponse.results
            } catch {
                throw NewsServiceError.decodingFailed(underlying: error)
            }
        } catch let error as NewsServiceError {
            throw error
        } catch {
            throw NewsServiceError.requestFailed(underlying: error)
        }
    }

    /// Conveniencia: recibe una cadena y crea la URL internamente.
    func fetchArticles(from urlString: String) async throws -> [Article] {
        guard let url = URL(string: urlString) else { throw NewsServiceError.invalidURL }
        return try await fetchArticles(from: url)
    }
}
