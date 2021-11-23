import Foundation


public struct Task: Codable {
    let id: Int
    var emoji: String
    var title: String
    var description: String
    var date: String
    var terminated: Bool
    
    
    init(title: String) {
        self.id = 0
        self.emoji = "🗓"
        self.title = title
        self.description = ""
        self.date = ""
        self.terminated = false
    }
}
