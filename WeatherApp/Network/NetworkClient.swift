import Foundation

public protocol NetworkClientable {
    func request<T: Decodable>(for route: Routable) async throws -> T
}

public class NetworkClient: NetworkClientable {
    public func request<T: Decodable>(for route: Routable) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            startUrlSession(for: route) { responseResults in
                switch responseResults {
                case let .success(data):
                    do {
                        let decodedSuccessData = try self.decode(
                            data,
                            as: T.self
                        )
                        continuation.resume(returning: decodedSuccessData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

private extension NetworkClient {
    func startUrlSession(for route: Routable, completion: @escaping (Result<Data, Error>) -> Void) {
        var urlRequest = URLRequest(url: route.url)
        urlRequest.httpMethod = route.httpMethod.rawValue

        route.headers.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }

            guard let data else {
                let error = NSError(domain: "No data error", code: 1001, userInfo: nil)
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(
                    domain: "HTTPError",
                    code: statusCode,
                    userInfo: [NSLocalizedDescriptionKey: "Bad HTTP status code: \(statusCode)"]
                )
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }

        task.resume()
    }

    func decode<T: Decodable>(_ data: Data, as type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
