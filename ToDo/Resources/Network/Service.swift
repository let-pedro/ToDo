import Foundation


final class Service: NSObject {
    
    static let shared = Service()
    private let urlApi = URL(string: "http://127.0.0.1:8000/Task/")!
    
    
    func getAll(completion: @escaping (Result<[Task], Error>) -> Void){
        guard (URL(string: "\(urlApi)") != nil) else {
            print("Not found url")
            return
        }
        
        URLSession.shared.dataTask(with: urlApi) { (data, response, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let ListData = try JSONDecoder().decode([Task].self, from: data)
                completion(.success(ListData))
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func post(params: [String: Any], completion: @escaping (Error?) -> ()) {
        guard URL(string: "\(urlApi)") != nil else {
            print ("not found url")
            return
        }
        
        var urlRequest = URLRequest(url: self.urlApi)
        urlRequest.httpMethod = "POST"
        
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if error != nil {
                    print("error", error?.localizedDescription ?? "")
                    return
                }
                
                guard data != nil else { return }
                completion(nil)
            }.resume()
                
        } catch {
            completion(error)
        }
    }
    
    func put(params: [String: Any], completion: @escaping (Error?) -> ()) {
        let updateURL = URL(string: "\(urlApi)\(String(describing: params["id"]!))/")
        
        guard  updateURL != nil else {
            print ("not found url")
            return
        }

        var urlRequest = URLRequest(url: updateURL!)
        urlRequest.httpMethod = "PUT"
        
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if error != nil {
                    print("error", error?.localizedDescription ?? "")
                    return
                }
                
                guard data != nil else { return }
                completion(nil)
            }.resume()
                
        } catch {
            completion(error)
        }
    }
    
    func delete(id: Int, completion: @escaping (Error?) -> ()){
        guard let url = URL(string: "\(urlApi)\(id)") else {
            print ("Not found url")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
       
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("error", error?.localizedDescription ?? "")
                    return
                }
                    
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    let errorString = String(data: data ?? Data(), encoding: .utf8) ?? ""
                    completion(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorString]))
                    return
                }
        
                completion(nil)
            }
        }.resume()
    }
}
