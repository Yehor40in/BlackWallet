//
//  GradientLineChartView.swift
//  CryptoStash
//
//  Created by Yehor Sorokin on 08.02.24.
//

import SwiftUI
import Charts

enum WeatherData {
    static let hourlyUVIndex: [(date: Date, uvIndex: Int)] = [
        (.startOfDay.addingTimeInterval(3600*0), 10),
        (.startOfDay.addingTimeInterval(3600*1), 7),
        (.startOfDay.addingTimeInterval(3600*2), 4),
        (.startOfDay.addingTimeInterval(3600*3), 6),
        (.startOfDay.addingTimeInterval(3600*4), 5),
        (.startOfDay.addingTimeInterval(3600*5), 4),
        (.startOfDay.addingTimeInterval(3600*6), 3),
        (.startOfDay.addingTimeInterval(3600*7), 4),
        (.startOfDay.addingTimeInterval(3600*8), 5),
        (.startOfDay.addingTimeInterval(3600*9), 6),
        (.startOfDay.addingTimeInterval(3600*10), 7),
        (.startOfDay.addingTimeInterval(3600*11), 12),
        (.startOfDay.addingTimeInterval(3600*12), 10),
        (.startOfDay.addingTimeInterval(3600*13), 11),
        (.startOfDay.addingTimeInterval(3600*14), 12),
        (.startOfDay.addingTimeInterval(3600*15), 13),
        (.startOfDay.addingTimeInterval(3600*16), 12),
        (.startOfDay.addingTimeInterval(3600*17), 10),
        (.startOfDay.addingTimeInterval(3600*18), 12),
        (.startOfDay.addingTimeInterval(3600*19), 13),
        (.startOfDay.addingTimeInterval(3600*20), 13),
        (.startOfDay.addingTimeInterval(3600*21), 10),
        (.startOfDay.addingTimeInterval(3600*22), 9),
        (.startOfDay.addingTimeInterval(3600*23), 7)
    ]
}

struct GradientLineChartView: View {
    var isOverview: Bool

    @State private var selectedDate: Date?
    @State var data = WeatherData.hourlyUVIndex

    var body: some View {
        Group {
            if isOverview {
                chart
                    .allowsHitTesting(false)
            } else {
                List {
                    Section {
                        chart
                    }
                }
            }
        }
        .accessibilityChartDescriptor(self)
    }

    private var chart: some View {
        Chart {
            RectangleMark(
                xStart: .value("hour", Calendar.current.startOfDay(for: Date())),
                xEnd: .value("hour", Calendar.current.startOfDay(for: Date()).addingTimeInterval(60*60*23))
            )
            .foregroundStyle(.linearGradient(stops: [
                Gradient.Stop(color: .blue, location: 0),
//                Gradient.Stop(color: .green, location: 2/14),
//                Gradient.Stop(color: .pink, location: 5/14),
//                Gradient.Stop(color: .orange, location: 8/14),
//                Gradient.Stop(color: .red, location: 10/14),
                Gradient.Stop(color: .purple, location: 14/14),
            ], startPoint: .bottom, endPoint: .top))
            .mask {
                if let max = WeatherData.hourlyUVIndex.max(by: { $0.uvIndex < $1.uvIndex }),
                   let min = WeatherData.hourlyUVIndex.min(by: { $0.uvIndex < $1.uvIndex }){
                    ForEach(WeatherData.hourlyUVIndex, id: \.date) { hour in
//                        AreaMark(
//                            x: .value("hour", hour.date),
//                            y: .value("uvIndex", hour.uvIndex)
//                        )
//                        .interpolationMethod(.cardinal)
//                        .foregroundStyle(.black.opacity(0.4))

                        LineMark(
                            x: .value("hour", hour.date),
                            y: .value("uvIndex", hour.uvIndex)
                        )
                        .interpolationMethod(.cardinal)
                        .lineStyle(StrokeStyle(lineWidth: 4))
//                        .symbol(Circle().strokeBorder(style: StrokeStyle(lineWidth: 0)))
//                        .symbolSize(hour.date == max.date ? CGSize(width: 10, height: 10) : .zero)
                    }

//                    PointMark(
//                        x: .value("hour", max.date),
//                        y: .value("uvIndex", max.uvIndex)
//                    )
//                    .symbolSize(CGSize(width: 5, height: 5))
//                    .foregroundStyle(.green)
//                    .annotation(spacing: 0) {
//                        Text("\(max.uvIndex)")
//                            .font(.caption.weight(.bold))
//                            .foregroundColor(.secondary)
//                    }
//                    PointMark(
//                        x: .value("hour", min.date),
//                        y: .value("uvIndex", min.uvIndex)
//                    )
//                    .symbolSize(CGSize(width: 5, height: 5))
//                    .foregroundStyle(.green)
//                    .annotation(spacing: 0) {
//                        Text("\(min.uvIndex)")
//                            .font(.caption.weight(.bold))
//                            .foregroundColor(.secondary)
//                    }
                    
                }
            }

            if let selectedDate, let uvIndex = WeatherData.hourlyUVIndex.first(where: { $0.date == selectedDate })?.uvIndex {
                RuleMark(x: .value("hour", selectedDate))
                    #if os(macOS)
                    .foregroundStyle(Color.primary)
                    #else
                    .foregroundStyle(Color(.label))
                    #endif
                PointMark(
                    x: .value("hour", selectedDate),
                    y: .value("uvIndex", uvIndex)
                )
                .symbolSize(CGSize(width: 15, height: 15))
                #if os(macOS)
                .foregroundStyle(Color.primary)
                #else
                .foregroundStyle(Color(.label))
                #endif
            }
        }
        .chartYScale(domain: 0...14)
        .chartYAxis {
            AxisMarks(position: .trailing, values: .automatic(desiredCount: 14)) { axisValue in
                if axisValue.index % 2 == 0 {
                    AxisValueLabel()
                }
                AxisGridLine()
            }

            AxisMarks(preset: .inset, position: .leading, values: .automatic(desiredCount: 14)) { axisValue in
                switch axisValue.index {
                case 1:
                    AxisValueLabel("Low", anchor: .topLeading)
                case 3:
                    AxisValueLabel("Moderate", anchor: .topLeading)
                case 6:
                    AxisValueLabel("High", anchor: .topLeading)
                case 8:
                    AxisValueLabel("Very high", anchor: .topLeading)
                case 11:
                    AxisValueLabel("Extreme", anchor: .topLeading)
                default:
                    AxisValueLabel()
                }
            }
        }
        .chartXAxis {
            AxisMarks(position: .bottom, values: .automatic) { _ in
                AxisValueLabel()
                AxisGridLine()
                AxisTick()
            }

            AxisMarks(position: .top, values: .automatic(desiredCount: 24)) { value in
                if value.index % 2 != 0 {
                    AxisValueLabel("\(WeatherData.hourlyUVIndex[value.index].uvIndex)", anchor: .bottom)
                }
            }
        }
        .chartOverlay { proxy in
            GeometryReader { g in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let x = value.location.x - g[proxy.plotAreaFrame].origin.x
                                if let date: Date = proxy.value(atX: x), let roundedHour = date.nearestHour() {
                                    self.selectedDate = roundedHour
                                }
                            }
                            .onEnded { value in
                                self.selectedDate = nil
                            }
                    )
            }
        }
        .chartYAxis(isOverview ? .hidden : .visible)
        .chartXAxis(isOverview ? .hidden : .visible)
//        .frame(height: isOverview ? Constants.previewChartHeight : Constants.detailChartHeight)
        .accessibilityRepresentation {
            Chart(data, id: \.date) { hour in
                Plot {
                    BarMark(
                        x: .value("hour", hour.date),
                        y: .value("uvIndex", hour.uvIndex)
                    )
                }
                .accessibilityLabel(hour.date.formatted(date: .omitted, time: .standard))
                .accessibilityValue("\(hour.uvIndex)")
            }
            .accessibilityHidden(isOverview)
        }
    }
}

enum Constants {
    static let previewChartHeight: CGFloat = 100
    static let detailChartHeight: CGFloat = 300
}

// MARK: - Accessibility

extension GradientLineChartView: AXChartDescriptorRepresentable {
    func makeChartDescriptor() -> AXChartDescriptor {
        let min = data.map(\.uvIndex).min() ?? 0
        let max = data.map(\.uvIndex).max() ?? 0

        // A closure that takes a date and converts it to a label for axes
        let dateTupleStringConverter: (((date: Date, uvIndex: Int)) -> (String)) = { dataPoint in
            dataPoint.date.formatted(date: .omitted, time: .standard)
        }
        
        let xAxis = AXCategoricalDataAxisDescriptor(
            title: "Time of day",
            categoryOrder: data.map { dateTupleStringConverter($0) }
        )

        let yAxis = AXNumericDataAxisDescriptor(
            title: "UV Index value",
            range: Double(min)...Double(max),
            gridlinePositions: []
        ) { value in "\(Int(value))" }

        let series = AXDataSeriesDescriptor(
            name: "UV Index",
            isContinuous: true,
            dataPoints: data.map {
                .init(x: dateTupleStringConverter($0), y: Double($0.uvIndex))
            }
        )

        return AXChartDescriptor(
            title: "UV Index",
            summary: nil,
            xAxis: xAxis,
            yAxis: yAxis,
            additionalAxes: [],
            series: [series]
        )
    }
}

// MARK: - Preview

struct GradientLine_Previews: PreviewProvider {
    static var previews: some View {
        GradientLineChartView(isOverview: true)
//        GradientLineChartView(isOverview: false)
    }
}
