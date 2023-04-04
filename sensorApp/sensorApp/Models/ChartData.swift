//
//  ChartData.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 29.03.2023.
//

import UIKit
import Charts

struct ChartData {
    let name: String
    let dataEntries: [ChartDataEntry]
}

let chartData: [ChartData] = [
    ChartData(name: "Gas 1", dataEntries: [
                ChartDataEntry(x: 1, y: 4.8),
                ChartDataEntry(x: 2, y: 4.7),
                ChartDataEntry(x: 3, y: 4.9),
                ChartDataEntry(x: 4, y: 5.0),
                ChartDataEntry(x: 5, y: 5.0),
                ChartDataEntry(x: 6, y: 4.95),
                ChartDataEntry(x: 7, y: 5.0),
                ChartDataEntry(x: 8, y: 5.0),
                ChartDataEntry(x: 9, y: 4.9),
                ChartDataEntry(x: 10, y: 4.8)
            ]),
    ChartData(name: "Gas 2", dataEntries: [
                ChartDataEntry(x: 1, y: 4.8),
                ChartDataEntry(x: 2, y: 4.7),
                ChartDataEntry(x: 3, y: 4.9),
                ChartDataEntry(x: 4, y: 5.0),
                ChartDataEntry(x: 5, y: 5.0),
                ChartDataEntry(x: 6, y: 4.95),
                ChartDataEntry(x: 7, y: 5.0),
                ChartDataEntry(x: 8, y: 5.0),
                ChartDataEntry(x: 9, y: 4.9),
                ChartDataEntry(x: 10, y: 4.8)
            ]),
    ChartData(name: "Gas 3", dataEntries: [
                ChartDataEntry(x: 1, y: 4.8),
                ChartDataEntry(x: 2, y: 4.7),
                ChartDataEntry(x: 3, y: 4.9),
                ChartDataEntry(x: 4, y: 5.0),
                ChartDataEntry(x: 5, y: 5.0),
                ChartDataEntry(x: 6, y: 4.95),
                ChartDataEntry(x: 7, y: 5.0),
                ChartDataEntry(x: 8, y: 5.0),
                ChartDataEntry(x: 9, y: 4.9),
                ChartDataEntry(x: 10, y: 4.8)
            ]),
    ChartData(name: "Gas 4", dataEntries: [
                ChartDataEntry(x: 1, y: 4.8),
                ChartDataEntry(x: 2, y: 4.7),
                ChartDataEntry(x: 3, y: 4.9),
                ChartDataEntry(x: 4, y: 5.0),
                ChartDataEntry(x: 5, y: 5.0),
                ChartDataEntry(x: 6, y: 4.95),
                ChartDataEntry(x: 7, y: 5.0),
                ChartDataEntry(x: 8, y: 5.0),
                ChartDataEntry(x: 9, y: 4.9),
                ChartDataEntry(x: 10, y: 4.8)
            ]),
    ChartData(name: "Gas 5", dataEntries: [
                ChartDataEntry(x: 1, y: 4.8),
                ChartDataEntry(x: 2, y: 4.7),
                ChartDataEntry(x: 3, y: 4.9),
                ChartDataEntry(x: 4, y: 5.0),
                ChartDataEntry(x: 5, y: 5.0),
                ChartDataEntry(x: 6, y: 4.95),
                ChartDataEntry(x: 7, y: 5.0),
                ChartDataEntry(x: 8, y: 5.0),
                ChartDataEntry(x: 9, y: 4.9),
                ChartDataEntry(x: 10, y: 4.8)
            ]),
]
    
    
//
//
//    (name: "Gas 1", dataEntries: [
//        ChartDataEntry(x: 1, y: 4.8),
//        ChartDataEntry(x: 2, y: 4.7),
//        ChartDataEntry(x: 3, y: 4.9),
//        ChartDataEntry(x: 4, y: 5.0),
//        ChartDataEntry(x: 5, y: 5.0),
//        ChartDataEntry(x: 6, y: 4.95),
//        ChartDataEntry(x: 7, y: 5.0),
//        ChartDataEntry(x: 8, y: 5.0),
//        ChartDataEntry(x: 9, y: 4.9),
//        ChartDataEntry(x: 10, y: 4.8)
//    ]),
//    (name: "Gas 2", dataEntries: [
//        ChartDataEntry(x: 1, y: 5.0),
//        ChartDataEntry(x: 2, y: 5.2),
//        ChartDataEntry(x: 3, y: 5.5),
//        ChartDataEntry(x: 4, y: 5.8),
//        ChartDataEntry(x: 5, y: 5.6),
//        ChartDataEntry(x: 6, y: 5.4),
//        ChartDataEntry(x: 7, y: 5.3),
//        ChartDataEntry(x: 8, y: 5.2),
//        ChartDataEntry(x: 9, y: 5.1),
//        ChartDataEntry(x: 10, y: 4.9)
//    ]),
//    (name: "Gas 3", dataEntries: [
//        ChartDataEntry(x: 1, y: 4.7),
//        ChartDataEntry(x: 2, y: 4.8),
//        ChartDataEntry(x: 3, y: 4.7),
//        ChartDataEntry(x: 4, y: 4.8),
//        ChartDataEntry(x: 5, y: 4.9),
//        ChartDataEntry(x: 6, y: 5.0),
//        ChartDataEntry(x: 7, y: 5.1),
//        ChartDataEntry(x: 8, y: 5.0),
//        ChartDataEntry(x: 9, y: 4.8),
//        ChartDataEntry(x: 10, y: 4.7)
//    ]),
//    (name: "Gas 4", dataEntries: [
//        ChartDataEntry(x: 1, y: 4.9),
//        ChartDataEntry(x: 2, y: 4.8),
//        ChartDataEntry(x: 3, y: 4.7),
//        ChartDataEntry(x: 4, y: 4.8),
//        ChartDataEntry(x: 5, y: 4.9),
//        ChartDataEntry(x: 6, y: 5.0),
//        ChartDataEntry(x: 7, y: 4.9),
//        ChartDataEntry(x: 8, y: 4.8),
//        ChartDataEntry(x: 9, y: 4.7),
//        ChartDataEntry(x: 10, y: 4.8)
//    ]),
//]
//
//
