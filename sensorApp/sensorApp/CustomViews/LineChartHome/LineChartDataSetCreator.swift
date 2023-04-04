//
//  LineChartDataSetCreator.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 4.04.2023.
//

import Charts

class LineChartDataSetCreator {
    static func create(with entries: [ChartDataEntry], label: String) -> LineChartDataSet {
        let dataSet = LineChartDataSet(entries: entries, label: label)
        dataSet.colors = [NSUIColor.systemBlue.withAlphaComponent(1)]
        dataSet.lineWidth = 2.0
        dataSet.drawValuesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = false
        return dataSet
    }
}

