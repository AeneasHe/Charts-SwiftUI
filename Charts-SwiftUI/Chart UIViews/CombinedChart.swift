//
//  CombinedChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-29.
//

import Charts
import SwiftUI

// 复合图
struct CombinedChart: UIViewRepresentable {
    var barEntries : [BarChartDataEntry]
    var lineEntries : [ChartDataEntry]

    // 双向绑定的quarter
    @Binding var quarter: Int

    // 创建初始视图
    func makeUIView(context: Context) -> CombinedChartView {
        // CombinedChartView是包Charts里面定义的复合图视图
        return CombinedChartView()
    }
    
    // 更新视图
    func updateUIView(_ uiView: CombinedChartView, context: Context) {
        // 这里拿到的uiView，类型是CombinedChartView
        // 这个uiView最开始是从makeUIView创建的，然后不断更新这个视图

        // 更新图表的数据
        setChartData(uiView)

        // 更新图表的配置
        configureChart(uiView)

        // 显示轴格式化
        formatXAxis(uiView.xAxis)
        formatLeftAxis(uiView.leftAxis)
        formatRightAxis(uiView.rightAxis)

        // 手动通知图表进行更渲染
        uiView.notifyDataSetChanged()
    }
    
    func setChartData(_ combinedChart: CombinedChartView) {
        // 条形图数据集合及数据
        let barDataSet = BarChartDataSet(entries: barEntries)
        let barChartData = BarChartData(dataSet: barDataSet)

        // 折线图数据集合及数据
        let lineDataSet = LineChartDataSet(entries: lineEntries)
        let lineChartData = LineChartData(dataSet: lineDataSet)

        // 组合数据
        let data = CombinedChartData()
        data.lineData = lineChartData
        data.barData = barChartData

        // 将数据绑定到图表
        combinedChart.data = data

        // 格式化数据
        formatLineChartDataSet(lineDataSet)
        formatBarChartDataSet(barDataSet)

    }
    
    func formatLineChartDataSet(_ lineDataSet: LineChartDataSet) {
        lineDataSet.label = "Revenue"
        lineDataSet.setColor(.systemIndigo)
        lineDataSet.lineWidth = 2.5
        lineDataSet.setCircleColor(.systemIndigo)
        lineDataSet.circleRadius = 5
        lineDataSet.circleHoleRadius = 0

        let dataSetFormatter = NumberFormatter()
        dataSetFormatter.numberStyle = .currency
        dataSetFormatter.maximumFractionDigits = 0

        lineDataSet.valueFormatter = DefaultValueFormatter(formatter: dataSetFormatter)
        lineDataSet.valueFont = .boldSystemFont(ofSize: 10)
        lineDataSet.valueTextColor = .systemIndigo
        lineDataSet.axisDependency = .right
    }

    func formatBarChartDataSet( _ barDataSet: BarChartDataSet) {
        barDataSet.label = "Units Sold"
        barDataSet.colors = [UIColor.systemPurple]
        barDataSet.valueTextColor = UIColor.white
        barDataSet.valueFont = .boldSystemFont(ofSize: 10)
        barDataSet.axisDependency = .left
        barDataSet.highlightAlpha = 0
    }
    
    // 图表配置
    func configureChart(_ combinedChart: CombinedChartView) {

        combinedChart.noDataText = "No Data"
        combinedChart.drawValueAboveBarEnabled = false
        combinedChart.setScaleEnabled(false)
        combinedChart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5, easingOption: .linear)
        
        // 设置缩放比例
        if combinedChart.scaleX == 1.0 && quarter == 0 {
            combinedChart.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        } else {
            combinedChart.fitScreen()
        }

        // 设置marker
        let marker:CombinedMarker = CombinedMarker(color: UIColor.blue, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0), quarter: quarter)
        marker.minimumSize = CGSize(width: 75, height: 35)
        combinedChart.marker = marker
    }
    
    // 格式化x轴
    func formatXAxis(_ xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = -0.5
        xAxis.axisMaximum = Double(barEntries.count) - 0.5
        xAxis.granularity = 1
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Sale.monthsToDisplayForQuarter(quarter))
        xAxis.labelTextColor =  UIColor.label
    }

    // 格式化左y轴
    func formatLeftAxis(_ leftAxis: YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = (barEntries.map{$0.y}.max() ?? 0) + 20
        leftAxis.labelTextColor =  .red
    }

    // 格式化右y轴
    func formatRightAxis(_ rightAxis: YAxis) {
        let rightAxisFormatter = NumberFormatter()
        rightAxisFormatter.numberStyle = .currency
        rightAxisFormatter.maximumFractionDigits = 0
        rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: rightAxisFormatter)
        rightAxis.axisMinimum = 0
        rightAxis.axisMaximum = (lineEntries.map{$0.y}.max() ?? 0) + 150
        rightAxis.labelTextColor =  .red
    }
}



struct CombinedChart_Previews: PreviewProvider {
    static var previews: some View {
        CombinedChart(barEntries: Sale.UnitsFor(Sale.allSales, quarter: 0), lineEntries: Sale.TransactionsFor(Sale.allSales, quarter: 0), quarter: .constant(0))
    }
}
