//
//  NewsScreen.swift
//  HW_2_OTUS_2023
//
//  Created by Филатов Олег Олегович on 20.09.2023.
//

import SwiftUI
import NewsApiNetworking

struct NewsScreen: View {
    
    @StateObject var newsVMCars: NewsViewModel = .init(with: "Cars")
    @StateObject var newsVMSport: NewsViewModel = .init(with: "Sport")
    @StateObject var newsVMWeather: NewsViewModel = .init(with: "Weather")
    
    var listOptions = ["Cars", "Sport", "Weather"]
    @State var listOptionsIndex = "Cars"
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $listOptionsIndex) {
                    ForEach(listOptions, id: \.self) { item in
                        Text(item)
                            .tag(item)
                    }
                }
                .pickerStyle(.segmented)
                
                switch listOptionsIndex {
                case "Cars": grid(with: newsVMCars)
                case "Sport": grid(with: newsVMSport)
                case "Weather": grid(with: newsVMWeather)
                default:
                    EmptyView()
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [.blue, Color(red: 25/255, green: 25/255, blue: 112/255)]), startPoint: .top, endPoint: .bottom))
        }
    }
    
    @ViewBuilder
    func grid(with newsVM: NewsViewModel) -> some View {
        NewsGridView(newsVM: newsVM)
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
