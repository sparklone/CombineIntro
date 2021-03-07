//
//  SearchView.swift
//  CombineIntro
//
//  Created by Alexandr Glushchenko on 07.03.2021.
//

import SwiftUI
import Combine
import TimelaneCombine

class SearchController: ObservableObject {
    @Published var text = ""
    @Published var resultUrl: URL? = nil

    init() {
        $text
            .lane("input")
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .lane("debounce")
            .map { URL(string: "https://google.com/?q=\($0)")! }
            .flatMap (URLSession.shared.dataTaskPublisher)
            .retry(1)
            .map {
                $0.response.url

            }
            .lane("result")
            .replaceError(with: nil)
            .assign(to: &$resultUrl)
    }

}


struct SearchView: View {
    @StateObject var searchController = SearchController()

    var result : String {
        searchController.resultUrl?.absoluteString ?? ""
    }
    var body: some View {
        TextField("Search", text: $searchController.text)
            .border(Color.black)
            .padding()

        Text(result)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

