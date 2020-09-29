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
        title = "Stocks Chart"
        tableView.register(cellType: StocksPriceTableViewCell.self)
        tableView.register(FormatTableHeaderView.self, forHeaderFooterViewReuseIdentifier: FormatTableHeaderView.reuseIdentifer)
        tableView.estimatedSectionHeaderHeight = 60.0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        viewModel.fetchQuotes()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as StocksPriceTableViewCell
        cell.lblStockPostChange.attributedText = viewModel.attributedString(for: "-2.10%")
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FormatTableHeaderView.reuseIdentifer) as? FormatTableHeaderView else {
            return nil
        }
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
