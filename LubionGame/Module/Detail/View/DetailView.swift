import SwiftUI

struct DetailView: View {
    
    var gameId: String
    @ObservedObject var detailPresenter: DetailPresenter
    
    var body: some View {
        ZStack {
            if detailPresenter.isLoading {
                VStack {
                    ProgressView()
                    Spacer().frame(height: 5)
                    Text("Loading")
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        AsyncImage(url: URL(string: (self.detailPresenter.gameDetail?.backgroundImageAdditional ?? self.detailPresenter.gameDetail?.backgroundImage) ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView().frame(height: 240)
                        }.aspectRatio(contentMode: .fill).frame(maxWidth: .infinity, maxHeight: 240).clipped().cornerRadius(12).padding(.bottom, 5)
                        HStack {
                            AsyncImage(url: URL(string: self.detailPresenter.gameDetail?.backgroundImage ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView().frame(height: 140)
                            }.aspectRatio(contentMode: .fill).frame(width: 50, height: 50).clipped().cornerRadius(12).padding(.trailing, 3)
                            VStack {
                                Text(self.detailPresenter.gameDetail?.name ?? "").frame(maxWidth: .infinity, alignment: .leading).bold().font(.system(size: 20)).padding(.bottom, 2)
                                Text(self.detailPresenter.gameDetail?.genres?.map { $0.name ?? "" }.joined(separator: ", ") ?? "-").bold().foregroundColor(Color.gray).font(.system(size: 12)).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 5)
                            }
                        }.padding(.vertical, 3)
                        HStack(spacing: 12) {
                            VStack {
                                Text("Rating").foregroundColor(Color.gray).bold().font(.system(size: 12))
                                HStack {
                                    Image(systemName: "star.fill").resizable().frame(width: 12, height: 12).foregroundColor(Color.yellow)
                                    Text(String(self.detailPresenter.gameDetail?.rating ?? 0.0)).foregroundColor(Color.black).font(.system(size: 12)).bold()
                                }
                            }
                            Divider().frame(width: 1)
                            VStack {
                                Text("Playtime").foregroundColor(Color.gray).bold().font(.system(size: 12))
                                Spacer()
                                HStack {
                                    Text("\(String(self.detailPresenter.gameDetail?.playtime ?? 0)) Hour").foregroundColor(Color.black).font(.system(size: 12)).bold()
                                }
                            }
                            Divider().frame(width: 1)
                            VStack {
                                Text("Released").foregroundColor(Color.gray).bold().font(.system(size: 12))
                                Spacer()
                                HStack {
                                    Text(self.detailPresenter.gameDetail?.released ?? "-").foregroundColor(Color.black).font(.system(size: 12)).bold()
                                }
                            }
                            Divider().frame(width: 1)
                            VStack {
                                Text("Metacritic").foregroundColor(Color.gray).bold().font(.system(size: 12))
                                Spacer()
                                HStack {
                                    Text(String(self.detailPresenter.gameDetail?.metacritic ?? 0)).foregroundColor(Color.black).font(.system(size: 12)).bold()
                                }
                            }
                        }.frame(maxWidth: .infinity).padding(16).overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray.opacity(0.3), lineWidth: 1)
                        ).padding(.vertical, 8)
                        Text("Overview").frame(maxWidth: .infinity, alignment: .leading).bold().font(.system(size: 16)).padding(.bottom, 1)
                        Text(self.detailPresenter.gameDetail?.descriptionRaw ?? "").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 12)).foregroundColor(Color.gray).fixedSize(horizontal: false, vertical: true)
                    }
                }.padding(16)
            }
        }.onAppear {
            if detailPresenter.gameDetail == nil {
                detailPresenter.getGameDetail(gameId: gameId)
            }
        }
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
