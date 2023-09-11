import Core

public struct GameListTransformer: Mapper {
    
    public typealias Response = GameListResponse
    public typealias Entity = GameListModel
    public typealias Domain = GameListModel
    
    public init() {}
    
    public func transformResponseToEntity(response: GameListResponse) -> GameListModel {
        return GameListModel(results: mapResultsResponseToDomains(input: response.results))
    }
    
    public func transformEntityToDomain(entity: GameListModel) -> GameListModel {
        return GameListModel(results: [])
    }
    
    func mapResultsResponseToDomains(
        input resultsResponse: [Result]?
    ) -> [ResultModel]? {
        return resultsResponse?.map { result in
            return ResultModel(id: result.id ?? 0, name: result.name ?? "", released: result.released ?? "", backgroundImage: result.backgroundImage ?? "", rating: result.rating ?? 0.0, platforms: mapPlatformsElementResponseToDomains(input: result.platforms), genres: mapGenresResponseToDomains(input: result.genres)
            )
        }
    }
    
    public func mapPlatformsElementResponseToDomains(
        input platformElement: [PlatformElement]?
    ) -> [PlatformElementModel]? {
        return platformElement?.map { result in
            return PlatformElementModel(platform: mapPlatformsResponseToDomains(input: result.platform), releasedAt: result.releasedAt ?? "")
        }
    }

    public func mapPlatformsResponseToDomains(
        input platform: PlatformPlatform?
    ) -> PlatformPlatformModel? {
        return PlatformPlatformModel(id: platform?.id ?? 0, name: platform?.name ?? "", slug: platform?.slug ?? "", yearStart: platform?.yearStart ?? 0, gamesCount: platform?.gamesCount ?? 0, imageBackground: platform?.imageBackground ?? "")
    }
    
    func mapGenresResponseToDomains(
        input genres: [Genre]?
    ) -> [GenreModel]? {
        return genres?.map { result in
            return GenreModel(id: result.id ?? 0, name: result.name ?? "", slug: result.slug ?? "", gamesCount: result.gamesCount ?? 0, imageBackground: result.imageBackground ?? "")
        }
    }
}
