//
//  ArticleExtension.swift
//  HW_2_OTUS_2023
//
//  Created by Филатов Олег Олегович on 25.09.2023.
//

import Foundation
import NewsApiNetworking

extension Article: Identifiable {
    public var id: String { url } // потому что url единственный неопциональный параметр
}
