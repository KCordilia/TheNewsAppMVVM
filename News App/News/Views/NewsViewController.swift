//
//  NewsViewController.swift
//  News App
//
//  Created by Karim Cordilia on 22/03/2023.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    private let viewModel = NewsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { [weak self] timer in self?.viewModel.switchToAllNews() }
        
        viewModel.$uiModel
            .sink { [weak self] uiModel in
                self?.renderUIModel(uiModel)
            }
            .store(in: &cancellables)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
    
    private func renderUIModel(_ uiModel: NewsUIModel) {
        switch uiModel {
        case .loading:
            print("loading...")
        case .data(let array):
            print(array)
        case .error:
            print("error")
        }
    }
}

