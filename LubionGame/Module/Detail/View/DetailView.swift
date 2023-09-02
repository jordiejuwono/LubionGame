import SwiftUI
import AVKit

struct DetailView: View {
    
    var gameId: String
    @ObservedObject var detailPresenter: DetailPresenter
    @State var showAlert: Bool = false
    @State var showTrailer: Bool = false
    
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
                            VStack(alignment: .center) {
                                Text(self.detailPresenter.gameDetail?.name ?? "").frame(maxWidth: .infinity, alignment: .leading).bold().font(.system(size: 20))
                                Text(self.detailPresenter.gameDetail?.genres?.map { $0.name ?? "" }.joined(separator: ", ") ?? "-").bold().foregroundColor(Color.gray).font(.system(size: 12)).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 5)
                            }
                        }.padding(.vertical, 3)
                        HStack {
                            VStack {
                                Text("Rating").foregroundColor(Color.gray).bold().font(.system(size: 12))
                                HStack {
                                    Image(systemName: "star.fill").resizable().frame(width: 12, height: 12).foregroundColor(Color.yellow)
                                    Text(String(format: "%.1f", self.detailPresenter.gameDetail?.rating ?? 0.0)).foregroundColor(Color.black).font(.system(size: 12)).bold()
                                }
                            }.frame(maxWidth: .infinity)
                            Divider().frame(width: 2)
                            VStack {
                                Text("Playtime").foregroundColor(Color.gray).bold().font(.system(size: 12))
                                Spacer()
                                HStack {
                                    Text("\(String(self.detailPresenter.gameDetail?.playtime ?? 0)) Hour").foregroundColor(Color.black).font(.system(size: 12)).bold()
                                }
                            }.frame(maxWidth: .infinity)
                            Divider().frame(width: 2)
                            VStack {
                                Text("Released").foregroundColor(Color.gray).bold().font(.system(size: 12))
                                Spacer()
                                HStack {
                                    Text(self.detailPresenter.gameDetail?.released ?? "-").foregroundColor(Color.black).font(.system(size: 12)).bold()
                                }
                            }.frame(maxWidth: .infinity)
                            Divider().frame(width: 2)
                            VStack {
                                Text("Metacritic").foregroundColor(Color.gray).bold().font(.system(size: 12))
                                Spacer()
                                HStack {
                                    Text(String(self.detailPresenter.gameDetail?.metacritic ?? 0)).foregroundColor(Color.black).font(.system(size: 12)).bold()
                                }
                            }.frame(maxWidth: .infinity)
                        }.frame(maxWidth: .infinity).padding(.horizontal, 8).padding(.vertical, 16).overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray.opacity(0.3), lineWidth: 1)
                        ).padding(.vertical, 8)
                        
                        if self.detailPresenter.player != nil {
                            if self.showTrailer {
                                VideoPlayer(player: self.detailPresenter.player).frame(height: 300).cornerRadius(16).onAppear {
                                    self.detailPresenter.player!.play()
                                }
                            }
                            Button {
                                self.showTrailer = !self.showTrailer
                                if self.showTrailer == false {
                                    self.detailPresenter.player!.pause()
                                }
                            } label: {
                                Text(self.showTrailer ? "Hide Trailer" : "Show Trailer").bold().frame(maxWidth: .infinity)
                            }.buttonStyle(.borderedProminent).padding(.bottom, 8)
                        }
                        Text("Overview").frame(maxWidth: .infinity, alignment: .leading).bold().font(.system(size: 16)).padding(.bottom, 1)
                        Text(self.detailPresenter.gameDetail?.descriptionRaw ?? "").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 12)).foregroundColor(Color.gray).fixedSize(horizontal: false, vertical: true)
                    }
                }.padding(16)
            }
        }.onAppear {
            if detailPresenter.gameDetail == nil {
                detailPresenter.getGameDetail(gameId: gameId)
                detailPresenter.isFavorited(id: Int(gameId) ?? 0)
            }
        }.onDisappear {
            if self.detailPresenter.player != nil {
                if self.showTrailer {
                    self.detailPresenter.player?.pause()
                }
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    self.showAlert = true
                    if self.detailPresenter.player != nil {
                        if self.showTrailer {
                            self.detailPresenter.player!.pause()
                        }
                    }
                } label: {
                    Image(systemName: self.detailPresenter.isFavorited ? "heart.fill" : "heart").foregroundColor(Color.red)
                }.alert(isPresented: $showAlert) {
                    let gameName = self.detailPresenter.gameDetail?.name
                    if self.detailPresenter.isFavorited {
                        return Alert(title: Text("Remove from Favorite"), message: Text("Remove \(gameName ?? "") from favorite?"), primaryButton: .default(Text("Cancel")) {
                            self.showAlert = false
                            if self.detailPresenter.player != nil {
                                if self.showTrailer {
                                    self.detailPresenter.player!.play()
                                }
                            }
                        }, secondaryButton: .default(Text("Yes").bold()) {
                            self.detailPresenter.deleteFavorite(id: self.detailPresenter.gameDetail?.id ?? 0)
                            if self.detailPresenter.player != nil {
                                if self.showTrailer {
                                    self.detailPresenter.player!.play()
                                }
                            }
                        })
                    } else {
                        return Alert(title: Text("Add to Favorite"), message: Text("Add \(gameName ?? "") to favorite?"), primaryButton: .default(Text("Cancel")) {
                            self.showAlert = false
                            if self.detailPresenter.player != nil {
                                if self.showTrailer {
                                    self.detailPresenter.player!.play()
                                }
                            }
                        }, secondaryButton: .default(Text("Yes").bold()) {
                            self.detailPresenter.addFavoriteGame(game: GameTableModel(id: self.detailPresenter.gameDetail?.id, name: self.detailPresenter.gameDetail?.name, backgroundImage: self.detailPresenter.gameDetail?.backgroundImage))
                            if self.detailPresenter.player != nil {
                                if self.showTrailer {
                                    self.detailPresenter.player!.play()
                                }
                            }
                        })
                    }
                }
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
