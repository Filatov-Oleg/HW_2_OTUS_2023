//
//  NewsGridView.swift
//  HW_2_OTUS_2023
//
//  Created by Филатов Олег Олегович on 25.09.2023.
//

import SwiftUI

struct NewsGridView: View {
    
    @ObservedObject var newsVM: NewsViewModel
    
    var body: some View {
        ScrollView {
            if !newsVM.articles.isEmpty {
                LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                    ForEach(newsVM.articles) { article in
                        let isLast = newsVM.articles.isLastElement(article)
                        VStack {
                            NavigationPushButton(destination: DetailNewsScreen(article: article)) {
                                ListArticleCell(article: article)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear {
                            if isLast {
                                newsVM.nextPage(with: newsVM.theme)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            } else {
                Text("There are no articles")
            }
        }
    }
}
