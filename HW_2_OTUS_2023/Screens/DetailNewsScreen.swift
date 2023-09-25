//
//  DetailNewsScreen.swift
//  HW_2_OTUS_2023
//
//  Created by Филатов Олег Олегович on 24.09.2023.
//

import NewsApiNetworking
import SwiftUI

struct DetailNewsScreen: View {
    
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    NavigationPopButton(destination: .previous) {
                        Image(systemName: "arrow.backward.circle")
                            .font(.title2)
                            .padding(.leading)
                    }
                    Text(article.source?.name ?? "")
                        .font(.title)
                    Spacer()
                    
                }
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
                            .transition(.scale(scale: 0.3, anchor: .center))
                    case .failure:
                        Image("news")
                            .resizable()
                    @unknown default:
                        EmptyView()
                    }
                }
                .scaledToFit()
                //                    .frame(maxWidth: geometry.size.width * 0.6)
                VStack(alignment: .leading) {
                    Text(article.title ?? "")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(article.description ?? "")
                    Text(article.publishedAt ?? "")
                        .foregroundColor(Color.secondary)
                        .font(.system(size: 12))
                        .padding(.top)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white.opacity(0.5))
                        .padding(.vertical)
                    Text("Author")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 72, height: 72)
                    
                    
                    VStack(alignment: .leading) {
                        Text(article.author ?? "")
                            .font(.headline)
                        NavigationPushButton(destination: ArticlesSameAuthorScreens(newsVM: .init(with: article.author ?? ""))) {
                            Text("Read more articles by this author")
                                .underline()
                                .padding(.top)
                        }
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding(.horizontal)
                
            }
            .padding(.bottom)
        }
        .background(LinearGradient(gradient: Gradient(colors: [.blue, Color(red: 25/255, green: 25/255, blue: 112/255)]), startPoint: .top, endPoint: .bottom))
    }
}


//    var body: some View {
//
//        VStack {
//            Text("SecondScreen")
//                .font(.title)
//            NavigationPushButton(destination: Text("1234")) {
//                Text("Third")
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.orange)
//            }
//                NavigationPopButton(destination: .previous) {
//                    Text("Back")
//                        .padding()
//                        .foregroundColor(.white)
//                        .background(Color.gray)
//                }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.yellow)
//    }



