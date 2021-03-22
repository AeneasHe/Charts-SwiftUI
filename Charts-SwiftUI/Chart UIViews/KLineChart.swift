//
//  KLineChart.swift
//  Charts-SwiftUI
//
//  Created by Aeneas on 2021/3/22.
//

import Foundation

import SwiftUI
import Charts

struct KLineChart: UIViewRepresentable {
    @Binding var selectedItem: CandleChartDataEntry

    var entries : [CandleChartDataEntry] = [CandleChartDataEntry]()

    let kLineChart = CandleStickChartView()
    
    func makeUIView(context: Context) ->  CandleStickChartView {
        kLineChart.delegate = context.coordinator
        return kLineChart
    }

    func updateUIView(_ uiView: CandleStickChartView, context: Context) {
        // 更新图表的数据
        setChartData(uiView,Int(15), range: UInt32(15))
         
        // 更新图表的配置
        configureChart2(uiView)

        // 手动通知图表进行更渲染
        uiView.notifyDataSetChanged()
    }


    func setChartData(_ chartView:CandleStickChartView ,_ count: Int, range: UInt32) {
            
            let yVals1 = (0..<count).map { (i) -> CandleChartDataEntry in
                let mult = range + 1
                let val = Double(arc4random_uniform(40) + mult)
                let high = Double(arc4random_uniform(9) + 8)
                let low = Double(arc4random_uniform(9) + 8)
                let open = Double(arc4random_uniform(6) + 1)
                let close = Double(arc4random_uniform(6) + 1)
                let even = i % 2 == 0
                
                return CandleChartDataEntry(
                    x: Double(i),
                    shadowH: val + high,
                    shadowL: val - low,
                    open: even ? val + open : val - open,
                    close: even ? val - close : val + close
                )
            }
            
            let set1 = CandleChartDataSet(entries: yVals1, label: "Data Set")
            // 数据集设置
            set1.axisDependency = .left
            set1.setColor(UIColor(white: 80/255, alpha: 1))
            
            // 高亮十字线的颜色
            // 在charts的CandleStickChartRenderer.swift文件里定义了具体高亮的方法
            // 在LineScatterCandleRadarRenderer.swift文件里定义了画十字线的方法
            set1.highlightColor = .white
            set1.highlightLineWidth = CGFloat(0.8)
            
            // 文字颜色
            set1.valueTextColor = .white
            set1.valueFont = UIFont.boldSystemFont(ofSize: 10)
            
            set1.drawIconsEnabled = false
            set1.shadowColor = .darkGray
            set1.shadowWidth = 0.7
        
            // 增长的蜡烛颜色
            set1.decreasingColor = .red
            set1.decreasingFilled = true
            
            // 下降的蜡烛颜色
            set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
            set1.increasingFilled = true
        
            set1.neutralColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
            
            // 是否允许高亮
            set1.highlightEnabled = true
            set1.shadowColorSameAsCandle = true
        
            let data = CandleChartData(dataSet: set1)
            chartView.data = data
        
            
        }

    func configureChart(_ chartView:CandleStickChartView){
        chartView.noDataText = "No Data"

        chartView.chartDescription!.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(true)

        chartView.maxVisibleCount = 200
        chartView.pinchZoomEnabled = true
        
        // 图例
        chartView.legend.horizontalAlignment = .right
        chartView.legend.verticalAlignment = .top
        chartView.legend.orientation = .vertical
        chartView.legend.drawInside = false
        chartView.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        // 左y轴
        chartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        chartView.leftAxis.spaceTop = 0.3
        chartView.leftAxis.spaceBottom = 0.3
        chartView.leftAxis.axisMinimum = 0
        
        // 右y轴
        chartView.rightAxis.enabled = false
        
        // x轴
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        
        let marker:BalloonMarker = BalloonMarker(
            color: UIColor.red,
            font: UIFont(name: "Helvetica", size: 12)!,
            textColor: UIColor.white,
            insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0)
        )
        // marker最小值
        marker.minimumSize = CGSize(width: 75, height: 35)
        chartView.marker = marker

    }

     func configureChart2(_ chartView:CandleStickChartView){
        //画板颜色
        chartView.gridBackgroundColor = UIColor(Color(hex:"#2A2B34" )) //"#181C26"
        chartView.drawGridBackgroundEnabled = true
        
        
        //边框颜色
        //chartView.borderColor = UIColor(Color(hex:"#DAD8DA"))
        //chartView.drawBordersEnabled = false
        //chartView.borderLineWidth = (1.0/UIScreen.main.scale)
        
        /// 属性设置
        //(垂直方向拖拽)
        chartView.scaleYEnabled = false
        //图表描述
        chartView.chartDescription?.enabled = false
        
        //(是否支持x、y方向同时缩放)
        chartView.pinchZoomEnabled = false
        //(数字展示的最大蜡烛个数)
        //chartView.maxVisibleCount = 0
        
        //图例 （不使用图例）
        chartView.legend.enabled = false
        
        //空数据
        chartView.noDataText = ""
        
        //双击缩放（关闭）
        chartView.doubleTapToZoomEnabled = false
        
        /// x轴
        //轴向
        chartView.xAxis.labelPosition = .bottom
        //是否绘制x轴坐标点
        //chartView.xAxis.drawLabelsEnabled = false
        //坐标轴上最多显示多少个坐标点
        chartView.xAxis.labelCount = 4
        //是否绘制网格线（不绘制）
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        
        /// 左轴
        //是否绘制网格线（不绘制）
        chartView.leftAxis.drawGridLinesEnabled = false
        //是否绘制坐标点（不绘制）
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false
        
        /// 右轴
        //是否绘制网格线（不绘制）
        chartView.rightAxis.drawGridLinesEnabled = false
        //是否绘制坐标点（不绘制）
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        
        //y轴自动缩放开启
        chartView.autoScaleMinMaxEnabled = true
                
        //显示完整的蜡烛图(不被左右轴截去)
        chartView.xAxis.spaceMin = 0.5
        chartView.xAxis.spaceMax = 0.5
        
        //x轴坐标值显示
        chartView.xAxis.labelTextColor = UIColor.white
        
        //手势
        chartView.highlightPerTapEnabled = true
        
        // 拖手势
        chartView.highlightPerDragEnabled = true
        
        // 边距值
        chartView.minOffset = 0.0
        
//        let marker:BalloonMarker = BalloonMarker(
//            color: UIColor.white,
//            font: UIFont(name: "Helvetica", size: 12)!,
//            textColor: UIColor.blue,
//            insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0)
//        )
//        // marker最小值
//        marker.minimumSize = CGSize(width: 75, height: 35)
//        chartView.marker = marker
        
    }


        // 协调器，这里主要用于选中数据时，将数据对应的线条颜色加深
    class Coordinator: NSObject, ChartViewDelegate {

        let parent: KLineChart
        
        init(parent: KLineChart) {
            self.parent = parent
            print("coordinator init")
        }

        // 这里的chartValueSelected是 ChartViewDelegate协议要实现的方法
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            // 更新选中的数据
            parent.selectedItem.x = entry.x
            print("选中了",parent.selectedItem.x)
            //print("datasetindex",highlight)

            // 高亮选中的数据
            chartView.highlightValue(x: parent.selectedItem.x, dataSetIndex: 0, callDelegate: false)
            //self.parent.kLineChart.highlightValues([highlight])
            
            // 移动视图以选中居中
            self.parent.kLineChart.centerViewToAnimated(
                xValue: entry.x,
                yValue: entry.y,
                axis: self.parent.kLineChart.data!.getDataSetByIndex(highlight.dataSetIndex).axisDependency,
                duration: 0.5
            )
        }
    }
    
    // 生成协调器
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

}
