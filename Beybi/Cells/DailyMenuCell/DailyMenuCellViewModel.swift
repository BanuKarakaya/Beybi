//
//  DailyMenuCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//


import Foundation
import Food

protocol DailyMenuCellViewModelProtocol {
    func viewDidLoad()
    func numberOfItemsInSection(breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Int
    func foodAtIndex(index: Int, breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Food?
    func sendSelectedCell()
    func didSelectItemAt(index: Int, breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Food?
}

protocol DailyMenuCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
    func reloadData()
}

final class DailyMenuCellViewModel {
    private weak var delegate: DailyMenuCellViewModelDelegate?
    private var randomBreakfastArray: [Food] = []
    private var randomLunchArray: [Food] = []
    private var randomDinnerArray: [Food] = []
    var selectedCell: Food?
    private let networkManager: NetworkManagerInterface
    let group = DispatchGroup()
    
    init(delegate: DailyMenuCellViewModelDelegate, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func breakfastMenu() {
        networkManager.getDailyBreakfastMenu { responseData in
            switch responseData {
            case .success(let foods):
                self.randomBreakfastArray = foods
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(foods)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func lunchMenu() {
        networkManager.getDailyLunchMenu { responseData in
            switch responseData {
            case .success(let foods):
                self.randomLunchArray = foods
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(foods)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func dinnerMenu() {
        networkManager.getDailyDinnerMenu { responseData in
            switch responseData {
            case .success(let foods):
                self.randomDinnerArray = foods
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(foods)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

extension DailyMenuCellViewModel: DailyMenuCellViewModelProtocol {
    func didSelectItemAt(index: Int, breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Food? {
        if breakfastTapped {
            selectedCell = randomBreakfastArray[index]
            return selectedCell
        } else if lunchTapped {
            selectedCell = randomLunchArray[index]
            return selectedCell
        } else if dinnerTapped {
            selectedCell = randomDinnerArray[index]
            return selectedCell
        } else {
            selectedCell = randomDinnerArray[index]
            return selectedCell
        }
    }
    
    func sendSelectedCell() {
        let selectedCell: [String: Food?] = ["selectedCell": selectedCell]
        NotificationCenter.default.post(name: .foodCellTapped, object: nil, userInfo: selectedCell as [AnyHashable : Any])
    }
    
    func foodAtIndex(index: Int, breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Food? {
        if breakfastTapped {
            let food = randomBreakfastArray[index]
                return food
        } else if lunchTapped {
            let food = randomLunchArray[index]
                return food
        } else if dinnerTapped {
            let food = randomDinnerArray[index]
                return food
        } else {
            let food = randomDinnerArray[index]
                return food
        }
    }
    
    func numberOfItemsInSection(breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Int {
        if breakfastTapped {
            return randomBreakfastArray.count
        } else if lunchTapped {
            return randomLunchArray.count
        } else if dinnerTapped {
            return randomDinnerArray.count
        } else {
            return randomDinnerArray.count
        }
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
        
        group.notify(queue: .main) { [self] in
            print("All processes finished")
            breakfastMenu()
            lunchMenu()
            dinnerMenu()
        }
    }
 }
