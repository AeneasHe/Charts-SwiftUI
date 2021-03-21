//
//  KlineChartView.swift
//  Charts-SwiftUI
//
//  Created by Aeneas on 2021/3/22.
//

import SwiftUI
import Charts

// k线图

struct KLineChartView:View {
    var body:some View{
        VStack {
            KlineChart()
                .frame(height: 400)
        }
    }
}

struct KLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        KLineChartView()
    }
}
