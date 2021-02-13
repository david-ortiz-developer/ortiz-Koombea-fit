//
//  HomeListView.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 10/02/21.
//

import UIKit
/// View Protocol Implementation for UI tasks
protocol HomeListView: ViewProtocol {
    func setupUI()
    func reload()
    func nextpage()
    func noResults()
}
extension HomeListViewController: HomeListView {
    /// Reloads the UI after data fetched or changed
    func reload() {
    }
    /// Tjhis method is called after the scrolling reach the end of the page
    func nextpage() {
    }
    /// This is the initial window
    func noResults() {
    }
    func setupUI() {
        showLoadingScene()
    }
}
