//
//  ServiceRequestViewModel.swift
//  NewsAppAssignment
//
//  Created by M1066900 on 26/08/21.
//

import Foundation


class ViewModel:NSObject{
    
    //MARK:- PROPERTIES
    
    var newsAPIData = [Article]()
    
    var newsCellViewModels = [NewsCellViewModel](){
        didSet{
            refreshTableView?()
        }
    }
    var refreshTableView: (()->Void)?
    
    let serviceRequestData = ServiceRequest(baseURL: newsURL)
    
    
    //MARK:- Calling func to get API data from VIEW MODEL class
        func requestingDataFromAPI(){
            serviceRequestData.getDataFromAPI(){ success in
                if success {
                    switch self.serviceRequestData.state{
                                case .results(let data):
                                    self.fetchNewsData(newsAPIData: data.articles)
                                case .loading:
                                    print(loading)
                                }
                }
                else{
                            print(noData)
                }
            }
        }
    
    //MARK:-GETTING THE CELL MODEL
    func getCellViewModel(at indexPath:IndexPath)->NewsCellViewModel{
        return newsCellViewModels[indexPath.row]
    }
    
    
    
    //MARK:-CREATING THE CELL MODEL
    func createNewsCellModel(newsAPIData:Article)->NewsCellViewModel{
        let name = newsAPIData.source.name
        let image = newsAPIData.urlToImage ?? emptyImage
        let description =  newsAPIData.articleDescription ?? noDescription
        let url = newsAPIData.url
        return NewsCellViewModel(image: image, descriptionArticle: description, nameArticle: name, url: url)
    }
    
    
    
    //MARK:-FETCHING THE DATA FROM API AND ASSIGNING DATA TO CREATE CELL MODEL
    func fetchNewsData(newsAPIData:[Article]){
        self.newsAPIData = newsAPIData
        var viewModels = [NewsCellViewModel]()
        for newsArticle in newsAPIData{
            viewModels.append(createNewsCellModel(newsAPIData: newsArticle))
        }
        newsCellViewModels = viewModels
        print(newsCellViewModels)
    }
    
}
