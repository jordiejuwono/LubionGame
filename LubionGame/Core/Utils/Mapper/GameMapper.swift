//import Foundation
//import Common
//
//final class GameMapper {
//    static func mapGameListResponseToDomains(
//        input gameListResponse: GameListResponse
//    ) -> GameListModel {
//        return GameListModel(
//                             results: mapResultsResponseToDomains(input: gameListResponse.results))
//    }
//
//    static func mapResultsResponseToDomains(
//        input resultsResponse: [Result]?
//    ) -> [ResultModel]? {
//        return resultsResponse?.map { result in
//            return ResultModel(id: result.id ?? 0, name: result.name ?? "", released: result.released ?? "", backgroundImage: result.backgroundImage ?? "", rating: result.rating ?? 0.0,
//                               platforms: mapPlatformsElementResponseToDomains(input: result.platforms),
//                               genres: mapGenresResponseToDomains(input: result.genres)
//            )
//        }
//    }
//
//    static func mapPlatformsElementResponseToDomains(
//        input platformElement: [PlatformElement]?
//    ) -> [PlatformElementModel]? {
//        return platformElement?.map { result in
//            return PlatformElementModel(platform: mapPlatformsResponseToDomains(input: result.platform), releasedAt: result.releasedAt ?? "")
//        }
//    }
//
//    static func mapPlatformsResponseToDomains(
//        input platform: PlatformPlatform?
//    ) -> PlatformPlatformModel? {
//        return PlatformPlatformModel(id: platform?.id ?? 0, name: platform?.name ?? "", slug: platform?.slug ?? "", yearStart: platform?.yearStart ?? 0, gamesCount: platform?.gamesCount ?? 0, imageBackground: platform?.imageBackground ?? "")
//    }
//
//    static func mapGenresResponseToDomains(
//        input genres: [Genre]?
//    ) -> [GenreModel]? {
//        return genres?.map { result in
//            return GenreModel(id: result.id ?? 0, name: result.name ?? "", slug: result.slug ?? "", gamesCount: result.gamesCount ?? 0, imageBackground: result.imageBackground ?? "")
//        }
//    }
//
//    // MARK: - GameDetail
//    static func mapGameDetailResponseToDomains(
//        input gameDetailResponse: GameDetailResponse
//    ) -> GameDetailModel {
//        return GameDetailModel(id: gameDetailResponse.id ?? 0, slug: gameDetailResponse.slug ?? "", name: gameDetailResponse.name ?? "", released: gameDetailResponse.released ?? "", backgroundImage: gameDetailResponse.backgroundImage ?? "", backgroundImageAdditional: gameDetailResponse.backgroundImageAdditional ?? "", website: gameDetailResponse.website ?? "", rating: gameDetailResponse.rating ?? 0.0, ratings: mapDetailRatingsToDomains(input: gameDetailResponse.ratings), playtime: gameDetailResponse.playtime ?? 0, metacritic: gameDetailResponse.metacritic ?? 0,platforms: mapPlatformsElementResponseToDomains(input: gameDetailResponse.platforms), developers: mapDeveloperResponseToDomains(input: gameDetailResponse.developers), genres: mapDeveloperResponseToDomains(input: gameDetailResponse.genres), publishers: mapDeveloperResponseToDomains(input: gameDetailResponse.publishers), clip: gameDetailResponse.clip ?? "", descriptionRaw: gameDetailResponse.descriptionRaw ?? "")
//    }
//
//    static func mapDetailRatingsToDomains(
//        input ratingsResponse: [DetailRating]?
//    ) -> [DetailRatingModel]? {
//        return ratingsResponse?.map { result in
//            return DetailRatingModel(id: result.id ?? 0, title: result.title ?? "", count: result.count ?? 0, percent: result.percent ?? 0)
//        }
//    }
//
//    static func mapDeveloperResponseToDomains(
//        input developerResponse: [Developer]?
//    ) -> [DeveloperModel]? {
//        return developerResponse?.map { result in
//            return DeveloperModel(id: result.id ?? 0, name: result.name ?? "", slug: result.slug ?? "", gamesCount: result.gamesCount ?? 0, imageBackground: result.imageBackground ?? "")
//        }
//    }
//
//    static func mapGamesEntityToDomains(
//        input gamesModel: [GameEntity]
//    ) -> [GameTableModel] {
//        return gamesModel.map { result in
//            return GameTableModel(id: result.id, name: result.name, backgroundImage: result.backgroundImage)
//        }
//    }
//
//    static func mapGameDomainToEntities(
//        input gameModel: GameTableModel
//    ) -> GameEntity {
//        let gameEntity = GameEntity()
//        gameEntity.id = gameModel.id ?? 0
//        gameEntity.name = gameModel.name ?? ""
//        gameEntity.backgroundImage = gameModel.backgroundImage ?? ""
//        return gameEntity
//    }
//
//    static func mapGameResponseToGameTable(
//        input gameResponse: ResultModel
//    ) -> GameTableModel {
//        return GameTableModel(id: gameResponse.id, name: gameResponse.name, backgroundImage: gameResponse.backgroundImage)
//    }
//
//}
