import CorePackage
import Common

public struct FavoriteGamesTransformer {
    
    public init() {}

    public func mapGamesEntityToDomains(
        input gamesModel: [GameEntity]
    ) -> [GameTableModel] {
        return gamesModel.map { result in
            return GameTableModel(id: result.id, name: result.name, backgroundImage: result.backgroundImage)
        }
    }

    public func mapGameDomainToEntities(
        input gameModel: GameTableModel
    ) -> GameEntity {
        let gameEntity = GameEntity()
        gameEntity.id = gameModel.id ?? 0
        gameEntity.name = gameModel.name ?? ""
        gameEntity.backgroundImage = gameModel.backgroundImage ?? ""
        return gameEntity
    }

    public func mapGameResponseToGameTable(
        input gameResponse: ResultModel
    ) -> GameTableModel {
        return GameTableModel(id: gameResponse.id, name: gameResponse.name, backgroundImage: gameResponse.backgroundImage)
    }
    
}


