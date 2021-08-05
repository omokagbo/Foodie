//
//  NetworkService.swift
//  Foodie
//
//  Created by omokagbo on 04/08/2021.
//

import Foundation

struct NetworkService {
    
    static let shared  = NetworkService()
    
    private init() {}
    
    /// Function to fetch all dishes from the backend
    /// - Parameter completion: completion to show when the fetch has been completed
    func fetchAllCategories(completion: @escaping (Result<AllDishes, Error>) -> Void) {
        request(route: .fetchAllCategories, method: .get, completion: completion)
    }
    
    /// Function to make orders
    /// - Parameter completion: completion to show when the order has been made
    func placeOrder(dishId: String, name: String, completion: @escaping (Result<Order, Error>) -> Void) {
        let params = [ "name": name ]
        request(route: .placeOrder(dishId), method: .post, parameters: params, completion: completion)
    }
    
    /// Function to get categories of dishes from the backend
    /// - Parameters:
    ///   - categoryId: the id of each food category
    ///   - completion: completion to show when a request has been made to fetch the dish categories
    func fetchDishCategories(categoryId: String, completion: @escaping (Result<[Dish], Error>) -> Void) {
        request(route: .fetchDishCategories(categoryId), method: .get, completion: completion)
    }
    
    func fetchAllOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        request(route: .fetchAllOrders, method: .get, completion: completion)
    }
    
    /// Function that makes the actual request to the backend
    /// - Parameters:
    ///   - route: Path to the resource in the backend
    ///   - method: Type of request to be made
    ///   - parameters: Any extra information that needs to be passed to the backend
    ///   - completion: Completion when the request has been made
    private func request<T: Codable>(route: Route,
                                     method: Method,
                                     parameters: [String: Any]? = nil,
                                     completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
            } else if let error = error {
                result = .failure(error)
                print(error.localizedDescription)
            }
            self.handleResponse(result: result, completion: completion)
            DispatchQueue.main.async {
                
            }
        }.resume()
    }
    
    /// Function that handles the response from the JSONDecoder
    /// - Parameters:
    ///   - result: result gotten from the URL Request
    ///   - completion: completion when the URL Request has been made
    private func handleResponse<T: Codable>(result: Result<Data, Error>?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        switch result {
        case .success(let data):
            do {
                let response = try JSONDecoder().decode(ApiResponse<T>.self, from: data)
                if let error = response.error {
                    completion(.failure(AppError.serverError(error)))
                    return
                }
                if let decodedData = response.data {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(AppError.unknownError))
                }
            } catch let error {
                print(error.localizedDescription)
            }
        case .failure(_):
            completion(.failure(AppError.errorDecoding))
            return
        }
    }
    
    /// This function helps to generate a urlRequest
    /// - Parameters:
    ///   - route: Path to the resource in the backend
    ///   - method: Type of request to be made
    ///   - parameters: Any extra information that needs to be passed to the backend
    /// - Returns: Returns a urlRequest
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asURL else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = parameters.map {
                    URLQueryItem(name: $0, value: "\($1)")
                }
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
    
}
