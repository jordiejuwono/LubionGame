import Foundation
import RealmSwift

public class GameEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundImage: String = ""
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}
