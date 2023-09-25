//
//  ArticlesSameAuthorScreens.swift
//  HW_2_OTUS_2023
//
//  Created by Филатов Олег Олегович on 24.09.2023.
//

import SwiftUI

struct ArticlesSameAuthorScreens: View {
    
    
    @State var newsVM: NewsViewModel
    
    var body: some View {
        ScrollView {
            HStack {
                NavigationPopButton(destination: .previous) {
                    Image(systemName: "arrow.backward.circle")
                        .font(.title2)
                        .padding(.leading)
                }
                Spacer()
            }
            NewsGridView(newsVM: newsVM)
        }
        .background(LinearGradient(gradient: Gradient(colors: [.blue, Color(red: 25/255, green: 25/255, blue: 112/255)]), startPoint: .top, endPoint: .bottom))
    }
}

//struct ArticlesSameAuthorScreens_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticlesSameAuthorScreens()
//    }
//}
