//
//  ListArticleCell.swift
//  HW_2_OTUS_2023
//
//  Created by Филатов Олег Олегович on 24.09.2023.
//

import SwiftUI
import NewsApiNetworking


struct ListArticleCell: View {
    
    let article: Article
    @State var isFavorite = false
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: URL(string: article.urlToImage ?? ""),
                transaction: Transaction(animation: .easeInOut)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .transition(.scale(scale: 0.2, anchor: .center))
                case .failure:
                    Image("news")
                        .resizable()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color.gray)
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        DispatchQueue.main.async {
                            withAnimation(.easeInOut(duration: 2)) {
                                isFavorite.toggle()
                            }
                        }
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.title3)
                            .foregroundColor(.red).bold(isFavorite)
                    }
                    .padding(8)
                }
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
                    Text((article.title!.isEmpty ? article.description : article.title) ?? "")
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke( Color(red: 0.2, green: 0.2, blue: 0.3))
        )
    }
}
