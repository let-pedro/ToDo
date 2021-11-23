import Foundation


class HomeVM {
    
    private let service = Service()

    
    //MARK: - Methods
    
    func getAllTasks(completion: @escaping (([Task]) -> Void )) {
        service.getAll{ (response) in
            switch response {
            case .failure(let error):
                print("Failed to fetch Tasks: ", error)
            case . success(let Task):
                completion(Task)
            }
        }
    }
    
    
    func createTask(datas: Task, completion: @escaping ((Bool) -> Void )){
        let jsonObject: [String : Any] = [
            "emoji": datas.emoji,
            "title": datas.title,
            "description": datas.description,
            "date": datas.date,
            "terminated": datas.terminated
        ]
        
        Service.shared.post(params: jsonObject) { (error) in
            if let error = error {
                print("failed to create new Task \(error)")
                completion(false)
                return
            }
            completion(true)
        }
    }
}
