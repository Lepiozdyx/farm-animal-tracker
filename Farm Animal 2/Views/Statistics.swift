import SwiftUI
import Charts

struct Statistics: View {
    @ObservedObject var animalStore: AnimalStore
    @ObservedObject var saleStore: SaleStore
    
    private var totalAnimals: Int {
        animalStore.animals.reduce(0) { $0 + $1.quantity }
    }
    
    private var todayIncome: Double {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return saleStore.sales.filter { calendar.isDate($0.date, inSameDayAs: today) }.reduce(0) { $0 + $1.amount }
    }
    
    private var weekIncome: Double {
        let calendar = Calendar.current
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        return saleStore.sales.filter { $0.date >= weekAgo }.reduce(0) { $0 + $1.amount }
    }
    
    private var monthIncome: Double {
        let calendar = Calendar.current
        let monthAgo = calendar.date(byAdding: .day, value: -30, to: Date())!
        return saleStore.sales.filter { $0.date >= monthAgo }.reduce(0) { $0 + $1.amount }
    }
    
    private var weeklyChartData: [(String, Double)] {
        let calendar = Calendar.current
        let weekdays = ["M", "T", "W", "T", "F", "S", "S"]
        var data: [(String, Double)] = []
        
        for i in (0..<7).reversed() {
            let date = calendar.date(byAdding: .day, value: -i, to: Date())!
            let dayIncome = saleStore.sales.filter { calendar.isDate($0.date, inSameDayAs: date) }.reduce(0) { $0 + $1.amount }
            let weekdayIndex = (calendar.component(.weekday, from: date) + 5) % 7
            data.append((weekdays[weekdayIndex], dayIncome))
        }
        
        return data
    }
    
    private var topProductivity: [(AnimalType, Double, Int)] {
        let calendar = Calendar.current
        let monthAgo = calendar.date(byAdding: .day, value: -30, to: Date())!
        
        var typeIncome: [AnimalType: Double] = [:]
        var typeUnits: [AnimalType: Int] = [:]
        
        for sale in saleStore.sales.filter({ $0.date >= monthAgo }) {
            typeIncome[sale.animalType, default: 0] += sale.amount
            typeUnits[sale.animalType, default: 0] += Int(sale.quantity)
        }
        
        return typeIncome.map { (type, income) in
            (type, income, typeUnits[type] ?? 0)
        }.sorted { $0.1 > $1.1 }.prefix(2).map { $0 }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: screenHeight * 0.02) {
                HStack {
                    Text("Statistics")
                        .font(.custom("Onest-SemiBold", size: screenHeight * 0.028))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal, screenHeight * 0.025)
//                .padding(.top, screenHeight * 0.06)
                
                VStack(alignment: .leading, spacing: screenHeight * 0.01) {
                    Text("Total animals")
                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Text("\(totalAnimals)")
                        .font(.custom("Onest-SemiBold", size: screenHeight * 0.05))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(screenHeight * 0.02)
                .background(
                    RoundedRectangle(cornerRadius: screenHeight * 0.02)
                        .fill(Color("color_3"))
                )
                .padding(.horizontal, screenHeight * 0.025)
                
                HStack(spacing: screenHeight * 0.015) {
                    IncomeCard(title: "Day", amount: todayIncome)
                    IncomeCard(title: "Week", amount: weekIncome)
                    IncomeCard(title: "Month", amount: monthIncome)
                }
                .padding(.horizontal, screenHeight * 0.025)
                
                VStack(alignment: .leading, spacing: screenHeight * 0.015) {
                    Text("Weekly income")
                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                        .foregroundColor(.white.opacity(0.7))
                    
                    if #available(iOS 16.0, *) {
                        Chart {
                            ForEach(weeklyChartData, id: \.0) { item in
                                BarMark(
                                    x: .value("Day", item.0),
                                    y: .value("Income", item.1)
                                )
                                .foregroundStyle(Color("color_5"))
                                .cornerRadius(screenHeight * 0.008)
                            }
                        }
                        .chartXAxis {
                            AxisMarks(values: .automatic) { _ in
                                AxisValueLabel()
                                    .foregroundStyle(Color.white.opacity(0.5))
                                    .font(.custom("Onest-Medium", size: screenHeight * 0.016))
                            }
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading) { value in
                                AxisGridLine()
                                    .foregroundStyle(Color.white.opacity(0.1))
                                AxisValueLabel()
                                    .foregroundStyle(Color.white.opacity(0.5))
                                    .font(.custom("Onest-Medium", size: screenHeight * 0.016))
                            }
                        }
                        .frame(height: screenHeight * 0.25)
                    } else {
                        Text("Chart available on iOS 16+")
                            .foregroundColor(.white.opacity(0.5))
                            .frame(height: screenHeight * 0.25)
                    }
                }
                .padding(screenHeight * 0.02)
                .background(
                    RoundedRectangle(cornerRadius: screenHeight * 0.02)
                        .fill(Color("color_3"))
                )
                .padding(.horizontal, screenHeight * 0.025)
                
                VStack(alignment: .leading, spacing: screenHeight * 0.015) {
                    Text("Top productivity (month)")
                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                        .foregroundColor(.white.opacity(0.7))
                    
                    if topProductivity.isEmpty {
                        Text("No data")
                            .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                            .foregroundColor(.white.opacity(0.5))
                            .padding(.vertical, screenHeight * 0.02)
                    } else {
                        VStack(spacing: screenHeight * 0.015) {
                            ForEach(Array(topProductivity.enumerated()), id: \.offset) { index, item in
                                HStack(spacing: screenHeight * 0.015) {
                                    ZStack {
                                        Circle()
                                            .fill(index == 0 ? Color("color_5") : Color.white.opacity(0.3))
                                            .frame(width: screenHeight * 0.045, height: screenHeight * 0.045)
                                        
                                        Text("\(index + 1)")
                                            .font(.custom("Onest-SemiBold", size: screenHeight * 0.02))
                                            .foregroundColor(.white)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: screenHeight * 0.003) {
                                        Text(item.0.rawValue)
                                            .font(.custom("Onest-SemiBold", size: screenHeight * 0.02))
                                            .foregroundColor(.white)
                                        
                                        Text("\(item.2) units")
                                            .font(.custom("Onest-Medium", size: screenHeight * 0.016))
                                            .foregroundColor(.white.opacity(0.6))
                                    }
                                    
                                    Spacer()
                                    
                                    Text("£\(Int(item.1))")
                                        .font(.custom("Onest-SemiBold", size: screenHeight * 0.022))
                                        .foregroundColor(Color("color_1"))
                                }
                            }
                        }
                    }
                }
                .padding(screenHeight * 0.02)
                .background(
                    RoundedRectangle(cornerRadius: screenHeight * 0.02)
                        .fill(Color("color_3"))
                )
                .padding(.horizontal, screenHeight * 0.025)
                .padding(.bottom, screenHeight * 0.02)
            }
        }
    }
}

struct IncomeCard: View {
    let title: String
    let amount: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: screenHeight * 0.008) {
            Text(title)
                .font(.custom("Onest-Medium", size: screenHeight * 0.018))
                .foregroundColor(.white.opacity(0.7))
            
            Text("£\(Int(amount))")
                .font(.custom("Onest-SemiBold", size: screenHeight * 0.028))
                .foregroundColor(Color("color_1"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(screenHeight * 0.015)
        .background(
            RoundedRectangle(cornerRadius: screenHeight * 0.015)
                .fill(Color("color_3"))
        )
    }
}

#Preview {
    Statistics(animalStore: AnimalStore.shared, saleStore: SaleStore.shared)
        .background(Color.black)
}
