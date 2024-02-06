//
//  DependecyInjectionBootCamp.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 05/02/2024.
//

import SwiftUI
import Combine

struct DependecyInjectionBootCamp: View {
    
    @StateObject private var vm :PostViewModel
    
    init(postDataService: PostDataService) {
     _vm = StateObject(wrappedValue: PostViewModel(postDataService: postDataService))
    }
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(vm.dataArray){item in
                    VStack{
                        Text("\(item.id)")
                            .underline()
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth:.infinity)
                        Text(item.title)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth:.infinity)
                        
                    }.frame(maxWidth:.infinity)
                }
            }.frame(maxWidth:.infinity)
        }
    }
}


struct DependecyInjectionBootCamp_Previews: PreviewProvider {
    static let dataService = PostDataService(url:  URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    
    static var previews: some View {
        DependecyInjectionBootCamp(postDataService: dataService)
    }
}

struct PostModel : Identifiable,Codable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

struct PostDataService {
    
    //static let instance = PostDataService()
    //let urlString = "https://jsonplaceholder.typicode.com/posts"
    //let url : URL = URL(string: urlString)!
    //DI
    let url :URL
    init(url: URL) {
        self.url = url
    }
    //
    func getData() -> AnyPublisher<[PostModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    //
}


class PostViewModel: ObservableObject {
    //
    @Published var dataArray: [PostModel] = []
    var cancelable = Set<AnyCancellable>()
    let postDataService:PostDataService
    //
    init( postDataService: PostDataService) {
        self.postDataService = postDataService
        loadPosts()
    }
    //
    func loadPosts(){
       // PostDataService.instance.getData()
        postDataService.getData()
            .sink { _ in
                
            } receiveValue: {[weak self] data in
                self?.dataArray = data
            }
            .store(in: &cancelable)

    }
}
