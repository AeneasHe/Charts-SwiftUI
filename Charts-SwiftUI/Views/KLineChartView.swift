//
//  KlineChartView.swift
//  Charts-SwiftUI
//
//  Created by Aeneas on 2021/3/22.
//

import SwiftUI
import Charts
import UIKit

// k线图

struct KLineChartView:View {
    @State private var selectedItem:CandleChartDataEntry = CandleChartDataEntry()

    var body:some View{
        VStack {
            KLineChart(selectedItem: $selectedItem)
                .frame(height: 400)
                //.background(Color(hex: "#181C26"))
        }
    }
}

struct KLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        KLineChartView()
    }
}
