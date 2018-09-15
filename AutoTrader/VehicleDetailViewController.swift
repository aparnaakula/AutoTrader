//
//  VehicleDetailViewController.swift
//  AutoTrader
//
//  Created by Ramphe, Ravi on 8/11/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation
import UIKit

class VehicleDetailViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var vehicle: Vehicle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let vehicle = vehicle else {
            return
        }
        self.textView.text = "\(vehicle.id.uuidString) \n \(vehicle.make) \n \(vehicle.model) \n \(vehicle.type)"
    }
    
}
