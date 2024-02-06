//
//  ContentView.swift
//  DemoCharts
//
//  Created by Bourne Koloh on 25/07/1402 AP.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                       ChartView(data:getChartDailyData(),chartKind:.Daily)
            //            ChartView(data:getChartWeeklyData(),chartKind:.Weekly)
             //ChartView(data:getChartMonthlyData(),chartKind:.Monthly)
        }
        .padding()
    }
    
    ///*
    
    func getChartDailyData() -> [GetDailySummariesDatum]{
        
        return [
            //x - position of a bar, y - height of a bar
            GetDailySummariesDatum(timestamp: nil, steps: 100, duration: "20", distance: 20, calories: 60, date: "2023-10-17T02:45:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 200, duration: "100", distance: 20, calories: 60, date: "2023-10-17T03:45:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 50, duration: "100", distance: 20, calories: 60, date: "2023-10-17T04:45:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 800, duration: "100", distance: 20, calories: 60, date: "2023-10-17T04:55:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 0, duration: "100", distance: 20, calories: 60, date: "2023-10-17T07:45:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 1000, duration: "100", distance: 20, calories: 60, date: "2023-10-17T09:45:00Z", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),

        ]
    }
    
    func getChartWeeklyData() -> [GetDailySummariesDatum]{
        
        return [
            //x - position of a bar, y - height of a bar
            GetDailySummariesDatum(timestamp: nil, steps: 2178, duration: "20", distance: 1669.4400000008754, calories: 60, date: "2023-10-16", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 2020, duration: "100", distance: 1364.4699999983422, calories: 60, date: "2023-10-15", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 4185, duration: "100", distance: 3353.7700000039767, calories: 60, date: "2023-10-14", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 1667, duration: "100", distance: 3353.7700000039767, calories: 60, date: "2023-10-13", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 1661, duration: "100", distance: 20, calories: 60, date: "2023-10-12", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 5661, duration: "100", distance: 20, calories: 60, date: "2023-10-11", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),

        ]
    }
    
    
    func getChartMonthlyData() -> [GetDailySummariesDatum]{
        
        return [
            //x - position of a bar, y - height of a bar
            GetDailySummariesDatum(timestamp: nil, steps: 2178, duration: "20", distance: 1669.4400000008754, calories: 60, date: "2023-10-16", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 2020, duration: "100", distance: 1364.4699999983422, calories: 60, date: "2023-10-15", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 4185, duration: "100", distance: 3353.7700000039767, calories: 60, date: "2023-10-14", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 1667, duration: "100", distance: 3353.7700000039767, calories: 60, date: "2023-10-13", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 1661, duration: "100", distance: 20, calories: 60, date: "2023-10-12", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),
            GetDailySummariesDatum(timestamp: nil, steps: 5661, duration: "100", distance: 20, calories: 60, date: "2023-10-11", activeCalories: 0, points: 0, source: "", stressSummary: nil, heartRateSummary: nil),

        ]
    }
}


    //*/
