//
//  NewsViewModel.swift
//  HW_2_OTUS_2023
//
//  Created by Филатов Олег Олегович on 24.09.2023.
//

import SwiftUI
import NewsApiNetworking


final class NewsViewModel: ObservableObject {
    
    private var currentPage: Int = 1
    
    @Published var articles: [Article] = .init()
    @Published var articles2D: [[Article]] = .init()
    @Published var theme: String
    
    init(with theme: String) {
        self.theme = theme
        nextPage(with: theme)
    }
//  apiKey:   79a072c27ce147868936661a703d2ec6
//  apiKey:   cc668a0525bf44c480d5b5b5f76c13d0
    func nextPage(with theme: String) {
        ArticlesAPI.everythingGet(q: theme,
                                  from: "2023-09-01",
                                  sortBy: "publichedAt",
                                  language: "en",
                                  apiKey: "cc668a0525bf44c480d5b5b5f76c13d0",
        page: currentPage) { data, error in
            if error != nil {
                print("Error ===> \(error?.localizedDescription)")
                return
            }
            self.currentPage += 1
            self.articles.append(contentsOf: data?.articles ?? [])
        }
    }
}
