//
//  TabbedStartView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import SwiftUI

// 底部tab导航视图
struct TabbedStartView: View {
    var body: some View {
        TabView {
            // 条形图
            BCView()
                .tabItem {
                    Image("BarChart")
                    Text("条形图")
                }
            // 组合条形图：两张图在y方向组合
            GroupedBCView()
                .tabItem {
                    Image("Grouped")
                    Text("组合图")
                }
            // 饼图
//            PCView()
//                .tabItem {
//                    Image(systemName: "chart.pie")
//                    Text("Pie Chart")
//                }
            // 堆积图
            LineChrtView()
                .tabItem {
                    Image("StackedLine")
                    Text("堆积图")
                }

            // 复合图：两张图在z方向堆叠
            CombinedChrtView()
                .tabItem {
                    Image("StackedBarLine")
                    Text("复合图")
                }
            
            // K线图
            KLineChartView()
                .tabItem{
                    Image(systemName: "heart.fill")
                    Text("KLine")
                }
        }
    }
}

struct TabbedStartView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedStartView()
    }
}
