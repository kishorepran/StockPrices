//
//  StocksPriceTableViewController.swift
//  StocksPrice
//
//  Created by Pran Kishore on 27.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import UIKit

class StocksPriceTableViewController: UITableViewController {

    let viewModel = SPViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
        viewModel.fetchQuotes()
    }

    func setupView() {
        title = "Stocks Chart"
        tableView.register(cellType: StocksPriceTableViewCell.self)
        tableView.register(FormatTableHeaderView.self, forHeaderFooterViewReuseIdentifier: FormatTableHeaderView.reuseIdentifer)
        tableView.estimatedSectionHeaderHeight = 60.0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.listStock?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as StocksPriceTableViewCell
        configure(cell, at: indexPath)
        return cell
    }
    func configure(_ cell: StocksPriceTableViewCell, at index: IndexPath) {
        let model = viewModel.listStock?[index.row]
        cell.lblStockName.text = model?.shortName
        cell.lblStockCode.text = model?.symbol
        cell.lblStockPrice.text = model?.price
        cell.lblStockChange.text = viewModel.stockChange(at: index)
        cell.lblStockPostChange.attributedText = viewModel.postStockChange(at: index)
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FormatTableHeaderView.reuseIdentifer) as? FormatTableHeaderView else {
            return nil
        }
        header.delegate = self
        return header
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - ViewModelDelegate
extension StocksPriceTableViewController: ViewModelDelegate {
    func viewModelDidUpdate(sender: SPBaseViewModel) {
        tableView.reloadData()
    }
    
    func viewModelUpdateFailed(error: SPError) {
        print(error.localizedMessage)
    }
}
// MARK: - FormatTableHeaderViewDelegate
extension StocksPriceTableViewController: FormatTableHeaderViewDelegate {
    func didChange(to format: ChangeFormat) {
        viewModel.selectedChangeFormat = format
        tableView.reloadData()
    }
}
