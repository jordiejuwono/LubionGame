import Core
import Common

public struct GameDetailTransformer: Mapper {

    public typealias Response = GameDetailResponse
    public typealias Entity = GameDetailModel
    public typealias Domain = GameDetailModel
    
    public init() {}
    
    public func transformResponseToEntity(response: GameDetailResponse) -> GameDetailModel {
        return GameDetailModel(id: response.id ?? 0, slug: response.slug ?? "", name: response.name ?? "", released: response.released ?? "", backgroundImage: response.backgroundImage ?? "", backgroundImageAdditional: response.backgroundImageAdditional ?? "", website: response.website ?? "", rating: response.rating ?? 0.0, ratings: mapDetailRatingsToDomains(input: response.ratings), playtime: response.playtime ?? 0, metacritic: response.metacritic ?? 0, platforms: GameListTransformer().mapPlatformsElementResponseToDomains(input: response.platforms), developers: mapDeveloperResponseToDomains(input: response.developers), genres: mapDeveloperResponseToDomains(input: response.genres), publishers: mapDeveloperResponseToDomains(input: response.publishers), clip: response.clip ?? "", descriptionRaw: response.descriptionRaw ?? "")
    }
    
    public func transformEntityToDomain(entity: GameDetailModel) -> GameDetailModel {
        return GameDetailModel(id: entity.id ?? 0, slug: entity.slug ?? "", name: entity.name ?? "", released: entity.released ?? "", backgroundImage: entity.backgroundImage ?? "", backgroundImageAdditional: entity.backgroundImageAdditional ?? "", website: entity.website ?? "", rating: entity.rating ?? 0.0, ratings: [], playtime: entity.playtime, metacritic: entity.metacritic, platforms: [], developers: entity.developers, genres: entity.genres, publishers: [], clip: entity.clip ?? "", descriptionRaw: entity.descriptionRaw ?? "")
    }
    
    
        public func mapDetailRatingsToDomains(
            input ratingsResponse: [DetailRating]?
        ) -> [DetailRatingModel]? {
            return ratingsResponse?.map { result in
                return DetailRatingModel(id: result.id ?? 0, title: result.title ?? "", count: result.count ?? 0, percent: result.percent ?? 0)
            }
        }
    
    public func mapDeveloperResponseToDomains(
            input developerResponse: [Developer]?
        ) -> [DeveloperModel]? {
            return developerResponse?.map { result in
                return DeveloperModel(id: result.id ?? 0, name: result.name ?? "", slug: result.slug ?? "", gamesCount: result.gamesCount ?? 0, imageBackground: result.imageBackground ?? "")
            }
        }
    
    }


