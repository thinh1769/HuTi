//
//  FilterResultViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import Foundation
import RxCocoa
import RxSwift

class FilterResultViewModel: BaseViewModel {
    var optionsList = [String]()
    let post = BehaviorRelay<[PostDetail]>(value: [])
    let options = BehaviorRelay<[String]>(value: [])
    var tabBarItemTitle = TabBarItemTitle.sell
    var mainTabBarItemTitle = MainTitle.sell
    var tuppleOptionsList = [(key: Int, value: String)]()
    
    func getPost() ->Observable<[PostDetail]> {
        return postService.getPosts()
    }
    
    func parseOptionTuppleToArray() {
        optionsList = []
        for (_, element) in tuppleOptionsList.enumerated() {
            optionsList.append(element.value)
        }
        options.accept(optionsList)
    }
}
