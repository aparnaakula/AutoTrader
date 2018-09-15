//
//  ViewController.swift
//  AutoTrader
//
//  Created by Ramphe, Ravi on 8/4/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit


protocol Countable { }

extension Countable where Self: RawRepresentable, Self.RawValue == Int {
    
    static func count() -> Int {
        var count = 0
        while let _ = Self(rawValue: count) { count += 1 }
        return count
    }
    
    static func cases() -> [Countable] {
        var cases = [Countable]()
        var count = 0
        while let `case` = Self(rawValue: count) {
            cases.append(`case`)
            count += 1
        }
        return cases
    }
    
    static func selectRandom() -> Countable {
        return Self(rawValue: self.randomValue())!
    }
    
    private static func randomValue() -> Int {
        let min = 0
        let max = self.count()
        return Int(arc4random_uniform(UInt32(max - min)) + UInt32(min))
    }
    
}

protocol FilterOption { }

enum VehicleType: Int, Countable, FilterOption {
    case fourDoor
    case twoDoor
    case smallSuv
    case bigSuv
    case truck
    case motorcycle
    
    var stringValue: String {
        switch self {
        case .fourDoor: return "fourDoor"
        case .twoDoor: return "twoDoor"
        case .smallSuv: return "smallSuv"
        case .bigSuv: return "bigSuv"
        case .truck: return "truck"
        case .motorcycle: return "motorcycle"
        }
    }
}

enum Make: Int, Countable, FilterOption {
    case honda
    case volkswagen
    case acura
    case audi
    case bmw
    case bugatti
    case buick
    case cadillac
    case chevrolet
    case chrysler
    case dodge
    case fiat
    case ford
    case gm
    case hyundai
    case infiniti
    case jaguar
    case jeep
    
    var stringValue: String {
        switch self {
        case .honda: return "honda"
        case .volkswagen: return "volkswagen"
        case .acura: return "acura"
        case .audi: return "audi"
        case .bmw: return "bmw"
        case .bugatti: return "bugatti"
        case .buick: return "buick"
        case .cadillac: return "cadillac"
        case .chevrolet: return "chevrolet"
        case .chrysler: return "chrysler"
        case .dodge: return "dodge"
        case .fiat: return "fiat"
        case .ford: return "ford"
        case .gm: return "gm"
        case .hyundai: return "hyundai"
        case .infiniti: return "infiniti"
        case .jaguar: return "jaguar"
        case .jeep: return "jeep"
        }
    }
}

enum Year: Int, Countable {
    case twoThousandTen
    case twoThousandEleven
    case twoThousandTwelve
    case twoThousandThirteen
    case twoThousandFourteen
    case twoThousandFifteen
    case twoThousandSixteen
    case twoThousandSeventeen
    case twoThousandEightteen
    
    var integerValue: Int {
        switch self {
        case .twoThousandTen: return 2010
        case .twoThousandEleven: return 2011
        case .twoThousandTwelve: return 2012
        case .twoThousandThirteen: return 2013
        case .twoThousandFourteen: return 2014
        case .twoThousandFifteen: return 2015
        case .twoThousandSixteen: return 2016
        case .twoThousandSeventeen: return 2017
        case .twoThousandEightteen: return 2018
        }
    }
}

struct Vehicle: Codable {
    let make: String
    let model: String
    let year: Int
    let id: UUID
    let price: Double
    let type: String
}

struct VehiclesGenerator {
    var vehicles: [Vehicle] {
        return (0...1000).map { _ in Vehicle(make: (Make.selectRandom() as! Make).stringValue, model: "Civic", year: (Year.selectRandom() as! Year).integerValue, id: UUID(), price: Double(arc4random_uniform(UInt32(60_000 - 1_000)) + UInt32(1_000)), type: (VehicleType.selectRandom() as! VehicleType).stringValue)  }
    }
}
protocol SortOption{}
enum PriceSortOption: SortOption {
    case lowestToHighest
    case highestToLowest
}
enum ModelSortOption: SortOption {
    case model_aToZ
    case model_zToA
}
enum YearSortOption: SortOption {
    
    case newestToOldest
    case oldestToNewest
}
struct YearFilterOption: FilterOption {
    let minimumYear: Int
    let maximumYear: Int
    
}
struct PriceFilterOption: FilterOption {
    let miminumPrice: Double
    let maximumPrice: Double
}
class CarsModel {
    var choseFilterOptions = [FilterOption]()
    var chosenSortOptions = [SortOption]()
    var vehicles = [Vehicle]()
    var selectedIndex = 0
    
    init(){
//        let sortByVehicleOption = VehicleType.fourDoor as! SortOption
//        let sortByMakeOption = Make.audi as! SortOption
//        let sortByModelOption = ModelSortOption.model_aToZ
//        let sortByYearOption = YearSortOption.newestToOldest
//        self.chosenSortOptions = [sortByVehicleOption, sortByMakeOption, sortByModelOption, sortByYearOption]
        
        self.vehicles = (0...1000).map { _ in Vehicle(make: (Make.selectRandom() as! Make).stringValue, model: "Civic", year: (Year.selectRandom() as! Year).integerValue, id: UUID(), price: Double(arc4random_uniform(UInt32(60_000 - 1_000)) + UInt32(1_000)), type: (VehicleType.selectRandom() as! VehicleType).stringValue)}
        
        
    }
}
class CarsCell: UITableViewCell {
    
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
}


class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var model: CarsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        model = CarsModel()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vehicleViewController = segue.destination as? VehicleDetailViewController else {
          return
        }
        vehicleViewController.vehicle = model.vehicles[model.selectedIndex]
        super.prepare(for: segue, sender: sender)
    }
}
extension ViewController: UITableViewDelegate {
        func tableView(_tableview: UITableView, didSelectRowAt indexPath: IndexPath){
          print("User Selected row at \(indexPath.row)" )
            model.selectedIndex = indexPath.row
            performSegue(withIdentifier: "showDetails", sender: self)
        }
}
extension ViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.vehicles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vehicleCell = tableView.dequeueReusableCell(withIdentifier: "carsCell", for: indexPath) as?
        CarsCell  else {
            return UITableViewCell()
        }
        let vehicle = model.vehicles[indexPath.row]
        vehicleCell.makeLabel.text = "Make: " + vehicle.make
        vehicleCell.modelLabel.text = "Model: " + vehicle.model
        vehicleCell.yearLabel.text = "\(vehicle.year)"
        return vehicleCell
    }
    
        


}

