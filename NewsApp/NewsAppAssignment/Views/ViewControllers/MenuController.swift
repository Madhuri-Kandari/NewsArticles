//
//  MenuController.swift
//  NewsAppAssignment
//
//  Created by M1066900 on 27/08/21.
//

import UIKit

class MenuController:UITableViewController{
    
    lazy var viewModel = {
        ViewModel()
    }()
    
    struct CellIdentifiers{
        static let newsArticleCell = newsTableViewCell
        static let loadingCell = loadingTableViewCell
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        configureTableView(tableView: tableView)
        registeringCells(tableView: tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK:-Configuring table view
    func configureTableView(tableView:UITableView){
        title = readNewsArticles
        //setting the delegate and datasource
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 180
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        //refreshing the tableview data whenever the cells are created and to be called after loading
        viewModel.refreshTableView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
//MARK:- Registering the cells in table view
    func registeringCells(tableView:UITableView){
        var cellNib = UINib(nibName: CellIdentifiers.newsArticleCell , bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.newsArticleCell)
        cellNib = UINib(nibName: CellIdentifiers.loadingCell, bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.loadingCell)
    }

//MARK:-Refreshing the table view with new data
    @objc func refresh(sender:AnyObject)
    {
        viewModel.requestingDataFromAPI()
        viewModel.refreshTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        self.refreshControl?.endRefreshing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestingDataFromAPI()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
//    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.serviceRequestData.state {
        case .loading:
            return 1
        case .results( _):
            return viewModel.newsCellViewModels.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.serviceRequestData.state {
        
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.loadingCell, for: indexPath)
            let spinner = cell.viewWithTag(99) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
            
        case .results( _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.newsArticleCell, for: indexPath) as? NewsTableViewCell
            else{
                fatalError(noCellIdentifierName)
            }
            let newResult = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = newResult
            cellDesign(cell: cell)
            return cell
        }
    }
//MARK:- UIDesign for each cell in table view
    func cellDesign(cell:UITableViewCell){
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 10
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
    }
    
//MARK:-When row is selected in MenuController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.serviceRequestData.state {
        case .loading:
            return
        case .results( _):
            let newResult = viewModel.getCellViewModel(at: indexPath)
            let newsLinkUrl = WebArticleViewController(url: newResult.url, titleDetail:newResult.nameArticle)
            showDetailViewController(newsLinkUrl, sender: nil)
        }
    }
}









//assigning the data from the network manager class
//            let newsResult = data.articles[indexPath.section]
//            cell.cellViewModel?.descriptionArticle = newsResult.articleDescription!
//            cell.cellViewModel?.image = newsResult.urlToImage!
//            return cell
        
//assigning the data from view model class varible
//let newsResult = viewModel.newsAPIData[indexPath.section]
//cell.cellViewModel?.descriptionArticle = newsResult.articleDescription!
//cell.cellViewModel?.image = newsResult.urlToImage!
    
