import Foundation


final class DetailsVM {
    
    private let service = Service()
    var idTask: Int
    
    
    init(IDTask: Int) {
        self.idTask = IDTask
    }
    
    //MARK: - Methods
    
    func updateTask(datas: Task,completion: @escaping ((Bool) -> Void )){
        let jsonObject: [String : Any] = [
            "id": datas.id,
            "emoji": datas.emoji,
            "title": datas.title,
            "description": datas.description,
            "date": datas.date,
            "terminated": datas.terminated
        ]
                
        Service.shared.put(params: jsonObject) { (error) in
            guard error == nil else {
                print("failed to update task\(error!)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func deleteTask(completion: @escaping ((Bool) -> Void )){
        service.delete(id: idTask) { (error) in
            guard error == nil else {
                print("failed to update task\(error!)")
                completion(false)
                return
            }
            completion(true)
        }
    }
}
