//
//  VehiculoModel.swift
//  Speed_Strider
//
//  Created by Jose Antonio Liebana Delgado on 24/4/24.
//

import Foundation

struct Vehiculo: Codable {
    var nombreVehiculo: String
    var colorVehiculo: String?
    var tamanoVehiculo: TamanoVehiculo
}
