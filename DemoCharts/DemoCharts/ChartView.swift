//
//  ChartView.swift
//  DemoCharts
//
//  Created by Bourne Koloh on 25/07/1402 AP.
//
///*
import DGCharts
import SwiftUI
import UIKit

enum ChartKind{
    case Daily,Weekly,Monthly
}

struct ChartView:UIViewRepresentable{
    typealias UIViewType = BarChartView
    
    //Bar chart accepts data as array of BarChartDataEntry objects
    var data:[GetDailySummariesDatum]
    var chartKind:ChartKind
    
    var dateFormatter = DateFormatter()
    
    // this func is required to conform to UIViewRepresentable protocol
    func makeUIView(context: Context) -> BarChartView {
        //crate new chart
        let chart = BarChartView()
        //it is convenient to form chart data in a separate func
        //chart.data = addDailyData()
        return chart
    }
    
    // this func is required to conform to UIViewRepresentable protocol
    func updateUIView(_ barChart: BarChartView, context: Context) {
        //when data changes chartd.data update is required
        //
        barChart.noDataText = "No Data Available."
        barChart.chartDescription.text = "Steps By Hr"
        barChart.chartDescription.font = UIFont(name: "HelveticaNeue-Light", size: 10)!
        barChart.chartDescription.textAlign = NSTextAlignment.center
        barChart.chartDescription.enabled = false
        barChart.drawMarkers = true
        barChart.drawValueAboveBarEnabled = true
        barChart.pinchZoomEnabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.scaleYEnabled = false
        
        //
        let xAxis = barChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.granularity = 1
        xAxis.granularityEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.wordWrapEnabled = true
        xAxis.drawAxisLineEnabled = true
        xAxis.axisLineColor = .black
        xAxis.labelTextColor = .black
        xAxis.valueFormatter = ChartAxisFormatter(chartKind:chartKind)
        xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 9)!
        
        xAxis.axisMinimum = 0
        
        
        xAxis.centerAxisLabelsEnabled = false
        xAxis.avoidFirstLastClippingEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.labelRotationAngle = 0
        
        let leftAxis = barChart.leftAxis
        leftAxis.enabled = false
        leftAxis.granularityEnabled = true
        leftAxis.granularity = 1000
        leftAxis.axisMinimum = 0 //Start at zero
        leftAxis.drawGridLinesEnabled = false
        
        let rightAxis = barChart.rightAxis
        rightAxis.enabled = false
        rightAxis.axisMinimum = 0 //Start at zero
        rightAxis.granularityEnabled = true
        rightAxis.granularity = 1000
        rightAxis.drawGridLinesEnabled = false
        
        
        //
        let legend = barChart.legend
        legend.font = UIFont(name: "HelveticaNeue-Light", size: 9)!
        legend.verticalAlignment = .bottom
        legend.horizontalAlignment = .right
        legend.orientation = .horizontal
        legend.drawInside = false
        legend.form = .circle
        //legend.formSize = 20
        //legend.textSize = 16
        legend.textColor = .black
        legend.xEntrySpace = 10
        //legend.yEntrySpace = 50
        //legend.yOffset = 20
        legend.wordWrapEnabled = true
        legend.enabled = true
        
        //
        if chartKind == .Daily {
            //24 Bars for 24 hrs
            xAxis.setLabelCount(24, force: true)
            xAxis.axisMaxLabels = 24
            
            let stopLoss = ChartLimitLine(limit: 10 , label: "stop loss")
                stopLoss.lineWidth = 0.5
                stopLoss.lineColor = .blue
                stopLoss.lineDashLengths = [8.0]
                leftAxis.addLimitLine(stopLoss)

                let takeProfit = ChartLimitLine(limit: 10, label: "take profit")
                takeProfit.lineWidth = 0.5
                takeProfit.lineColor = .black
                takeProfit.lineDashLengths = [8.0]
                leftAxis.addLimitLine(takeProfit)
            //
            xAxis.gridLineDashLengths = [10, 10]
                  xAxis.gridLineDashPhase = 0

         
            //
            barChart.data = addDailyData()
        }else if chartKind == .Weekly{
            //7 days for 1 week
            xAxis.setLabelCount(7, force: true)
            xAxis.axisMaxLabels = 7
            //
            barChart.data = addWeeklyData()
        }else if chartKind == .Monthly{
            //4 Bars for 4 weeks
            //xAxis.setLabelCount(4, force: true)
            xAxis.axisMaxLabels = 4
            //
            barChart.data = addMonthlyData()
        }
        
        //after all the customization part add this line of code
        barChart.fitBars = true
        //
        if barChart.marker == nil {
            //
            let marker =  CustomBaloon(color: .gray, font: UIFont(name: "HelveticaNeue-Light", size: 9)!, textColor: UIColor(named:"colorTextBlack") ?? .white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 15.0, right: 7.0))
            //
            marker.chartView = barChart
            //
            barChart.marker = marker
        }
    }
    
    func addMonthlyData() -> BarChartData{
        let calendar = Calendar(identifier: .gregorian)
        //
        var entries = [BarChartDataEntry]()
        //Mon to Sun
        for index in 0 ... 3 {
            //Find records for this hour
            let records = data.filter { item in
                //
                dateFormatter.dateFormat = "yyyy-MM-dd"
                //
                if let dstring = item.date, let dd = dateFormatter.date(from: dstring){
                    //
                    let weekNo = calendar.component(.weekOfMonth, from: dd)
                    //
                    return weekNo == index
                }
                //
                return false
            }
            
            //Sum all steps for that Hr
            let steps = records.lazy.map { $0.steps ?? 0 }.reduce(0, +)
            
            //Append value in entries
            entries.append(BarChartDataEntry(x: Double(index), y: Double(steps)))
        }
        
        let data = BarChartData()
        //BarChartDataSet is an object that contains information about your data, styling and more
        let dataSet = BarChartDataSet(entries: entries)
        // change bars color to green
        dataSet.colors = ChartColorTemplates.material()
        dataSet.valueColors = [.black]
        dataSet.valueFont = UIFont(name: "HelveticaNeue-Light", size: 9)!
        dataSet.drawValuesEnabled = false
        //change data label
        dataSet.label = "Steps by Week"
        data.dataSets.append(dataSet)
        return data
    
    }
    
    func addWeeklyData() -> BarChartData{
        let calendar = Calendar(identifier: .gregorian)
        //
        var entries = [BarChartDataEntry]()
        //Mon to Sun
        for index in 0 ... 6 {
            //Find records for this hour
            let records = data.filter { item in
                //
                dateFormatter.dateFormat = "yyyy-MM-dd"
                //
                if let dstring = item.date, let dd = dateFormatter.date(from: dstring){
                    //
                    let dow = calendar.component(.weekday, from: dd)
                    //
                    return dow == index
                }
                //
                return false
            }
            
            //Sum all steps for that Hr
            let steps = records.lazy.map { $0.steps ?? 0 }.reduce(0, +)
            
            //Append value in entries
            entries.append(BarChartDataEntry(x: Double(index), y: Double(steps)))
        }
        
        let data = BarChartData()
        //BarChartDataSet is an object that contains information about your data, styling and more
        let dataSet = BarChartDataSet(entries: entries)
        // change bars color to green
        dataSet.colors = ChartColorTemplates.material()
        dataSet.valueColors = [.black]
        dataSet.valueFont = UIFont(name: "HelveticaNeue-Light", size: 9)!
        dataSet.drawValuesEnabled = false
        //change data label
        dataSet.label = "Steps by Day"
        data.dataSets.append(dataSet)
        return data
    
    }
    
    func addDailyData() -> BarChartData{
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
//        if let val = dateFormatter.date(from: "2017-01-09T11:00:00.00Z"){
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let val = dateFormatter.date(from: "2023-10-17T04:45:00Z"){
            
            print("date: \(val)")
        }
        //
        var entries = [BarChartDataEntry]()
        //00hrs to 23hr
        for index in 0...23 {
            //
            let hh = String(format: "%02d", index)
            //Find records for this hour
            let records = data.filter { item in
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                //
                if let dstring = item.date, let dd = dateFormatter.date(from: dstring){
                    dateFormatter.dateFormat = "HH"
                    let gg = dateFormatter.string(from: dd)
                    return gg == hh
                }
                //
                return false
            }
            
            //Sum all steps for that Hr
            let steps = records.lazy.map { $0.steps ?? 0 }.reduce(0, +)
            
            //Append value in entries
            entries.append(BarChartDataEntry(x: Double(index), y: Double(steps)))
        }
        
        let data = BarChartData()
        //BarChartDataSet is an object that contains information about your data, styling and more
        let dataSet = BarChartDataSet(entries: entries)
        // change bars color to green
        dataSet.colors = ChartColorTemplates.material()
        dataSet.valueColors = [.black]
        dataSet.valueFont = UIFont(name: "HelveticaNeue-Light", size: 9)!
        dataSet.drawValuesEnabled = false
        //change data label
        dataSet.label = "Steps by Hour"
        data.dataSets.append(dataSet)
        return data
    }
}

class ChartAxisFormatter: AxisValueFormatter,ValueFormatter {
    
    var chartKind:ChartKind
    
    init(chartKind:ChartKind){
        self.chartKind = chartKind
    }
    
    //Dataset Value Formater
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        //
        if entry is BarChartDataEntry{
            
            
//            let formatter = NumberFormatter()
//            formatter.currencyCode = "KSH"
//            formatter.currencySymbol = "KES"
//            //formatter.minimumFractionDigits = (value!.contains(".00")) ? 0 : 2
//            formatter.maximumFractionDigits = 2
//            formatter.numberStyle = .currencyAccounting
//            //formatter.maximumFractionDigits = 1
//            formatter.multiplier = 1.0
//            //
//            return formatter.string(from: NSNumber(value: value)) ?? "0.0"
        }else{
            let formatter = NumberFormatter()
            formatter.numberStyle = .percent
            formatter.maximumFractionDigits = 1
            formatter.multiplier = 1.0
            //
//            if let e = entry as? CustomPieChartDataEntry{
//                //print("Actual = \(e.actual)")
//                return formatter.string(from: NSNumber(value: e.actual)) ?? "0%"
//            }
            
            //
            return formatter.string(from: NSNumber(value: value)) ?? "0%"
        }
        
        return ""
    }
    
    //Axis Value Formatter
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        if axis is XAxis {
            //
            if(chartKind == .Daily){
                return String(format: "%02d", Int(value))
            }else if chartKind == .Weekly {
                
                if value == 0 {
                    return "Mon"
                }else if value == 1 {
                   return "Tue"
                }else if value == 2 {
                    return "Wed"
                }else if value == 3 {
                     return "Thur"
                }else if value == 4 {
                      return "Fri"
                }else if value == 5 {
                       return "Sat"
                }else if value == 6 {
                        return "Sun"
                }else{
                    //return ""
                }
            }else if chartKind == .Monthly {
                
                if value == 0 {
                    return "Week 1"
                }else if value == 1 {
                   return "Week 2"
                }else if value == 2 {
                    return "Week 3"
                }else if value == 3 {
                     return "Week 4"
                }else if value == 4 {
                      return "Week 5"
                }
            }
        }else{
            //
            if value > 10000{
                //
                return "\(Int(value/1000))K"
            }
        }
        // "1,605,436" where Locale == en_US
        return String(format: "%d", locale: Locale.current, value)
    }
}

struct Bar_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(data: [
            //x - position of a bar, y - height of a bar
            GetDailySummariesDatum(timestamp: nil, steps: 100, duration: "20", distance: 20, calories: 60, date: "2023-10-17T02:45:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 200, duration: "100", distance: 20, calories: 60, date: "2023-10-17T03:45:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 50, duration: "100", distance: 20, calories: 60, date: "2023-10-17T04:45:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 800, duration: "100", distance: 20, calories: 60, date: "2023-10-17T04:55:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 0, duration: "100", distance: 20, calories: 60, date: "2023-10-17T07:45:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 1000, duration: "100", distance: 20, calories: 60, date: "2023-10-17T09:45:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),

        ], chartKind:.Daily)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

// MARK: - GetDailySummariesResponse
struct GetDailySummariesResponse: Codable {
    let status: String?
    let metadata: String?
    let message: String?
    let data: [GetDailySummariesDatum]?
    let timestamp: String?
}
// MARK: - Datum
struct GetDailySummariesDatum: Codable,Hashable {
    let timestamp: String?
    let steps: Int?
    let duration: String?
    let distance: Double?
    let calories: Double?
    let date: String?
    let activeCalories: Double?
    let points: Double?
    let source: String?
    let stressSummary: GetDailySummariesStressSummary?
    let heartRateSummary: GetDailySummariesHeartRateSummary?
    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case steps = "steps"
        case duration = "duration"
        case distance = "distance"
        case calories = "calories"
        case date = "date"
        case activeCalories = "active_calories"
        case points = "points"
        case source = "source"
        case stressSummary = "stress_summary"
        case heartRateSummary = "heart_rate_summary"
    }
}

// MARK: - HeartRateSummary
struct GetDailySummariesHeartRateSummary: Codable ,Hashable {
    let min: Int?
    let max: Int?
    let average: Int?
    let resting: String?
    enum CodingKeys: String, CodingKey {
        case min = "min"
        case max = "max"
        case average = "average"
            case resting = "resting"
    }
}

// MARK: - StressSummary
struct GetDailySummariesStressSummary: Codable,Hashable{
    let averageStressLevel: Int?
    let maxStressLevel: Int?
    enum CodingKeys: String, CodingKey {
        case averageStressLevel = "average_stress_level"
        case maxStressLevel = "max_stress_level"
    }
}

class CustomBaloon: BalloonMarker {

    override func setLabel(_ newLabel: String) {
        let value = String(format: "%.0f", locale: Locale.current, Double(newLabel) ?? 0.0)
        super.setLabel(value)
    }
}

open class BalloonMarker: MarkerImage
{
    open var color: UIColor
    open var arrowSize = CGSize(width: 15, height: 11)
    open var font: UIFont
    open var textColor: UIColor
    open var insets: UIEdgeInsets
    open var minimumSize = CGSize()
    
    fileprivate var label: String?
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedString.Key : Any]()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
        super.init()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = self.offset
        var size = self.size
        
        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }
        
        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0

        var origin = point
        origin.x -= width / 2
        origin.y -= height

        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
            origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - width - padding
        }
        
        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
            origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }
        
        return offset
    }
    
    open override func draw(context: CGContext, point: CGPoint) {
        guard let label = label else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()
        
        context.setFillColor(color.cgColor)
        
        if offset.y > 0 {
            
            context.beginPath()
            let rect2 = CGRect(x: rect.origin.x, y: rect.origin.y + arrowSize.height, width: rect.size.width, height: rect.size.height - arrowSize.height)
            let clipPath = UIBezierPath(roundedRect: rect2, cornerRadius: 5.0).cgPath
            context.addPath(clipPath)
            context.closePath()
            context.fillPath()
            
            // arraow vertex
            context.beginPath()
            let p1 = CGPoint(x: rect.origin.x + rect.size.width / 2.0 - arrowSize.width / 2.0, y: rect.origin.y + arrowSize.height + 1)
            context.move(to: p1)
            context.addLine(to: CGPoint(x: p1.x + arrowSize.width, y: p1.y))
            context.addLine(to: CGPoint(x: point.x, y: point.y))
            context.addLine(to: p1)

            context.fillPath()
            
        } else {
            context.beginPath()
            let rect2 = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: rect.size.height - arrowSize.height)
            let clipPath = UIBezierPath(roundedRect: rect2, cornerRadius: 5.0).cgPath
            context.addPath(clipPath)
            context.closePath()
            context.fillPath()

            // arraow vertex
            context.beginPath()
            let p1 = CGPoint(x: rect.origin.x + rect.size.width / 2.0 - arrowSize.width / 2.0, y: rect.origin.y + rect.size.height - arrowSize.height - 1)
            context.move(to: p1)
            context.addLine(to: CGPoint(x: p1.x + arrowSize.width, y: p1.y))
            context.addLine(to: CGPoint(x: point.x, y: point.y))
            context.addLine(to: p1)

            context.fillPath()
        }
        
        if offset.y > 0 {
            rect.origin.y += self.insets.top + arrowSize.height
        } else {
            rect.origin.y += self.insets.top
        }
        
        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        label.draw(in: rect, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open /*override*/ func drawOld(context: CGContext, point: CGPoint)
    {
        guard let label = label else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()
        
        context.setFillColor(color.cgColor)

        if offset.y > 0
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.fillPath()
        }
        else
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.fillPath()
        }

        if offset.y > 0 {
            rect.origin.y += self.insets.top + arrowSize.height
        } else {
            rect.origin.y += self.insets.top
        }

        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        label.draw(in: rect, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        setLabel(String(entry.y))
    }
    
    open func setLabel(_ newLabel: String)
    {
        label = newLabel
        
        _drawAttributes.removeAll()
        _drawAttributes[.font] = self.font
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = self.textColor
        
        _labelSize = label?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
}
//*/
