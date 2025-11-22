//
//  HomeView.swift
//  couplesTime
//
//  Created by Mahdi Miad on 21/11/2025.
//

import SwiftUI

// MARK: - Transaction Model
struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let amount: Double
    let date: Date
    let isExpense: Bool
    let icon: String
    let paidBy: String
}

struct HomeView: View {
    @State private var totalBalance: Double = 2847.50
    @State private var income: Double = 3200.00
    @State private var expenses: Double = 352.50
    
    // Sample weekly spending data
    let weeklySpending: [Double] = [45, 30, 60, 20, 85, 100, 75]
    let weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    // Monthly spending by category
    @State private var selectedMonth: Date = Date()
    @State private var selectedTimePeriod: String = "This month"
    let monthlyCategorySpending: [(category: String, amount: Double, icon: String, color: Color)] = [
        ("Transport", 850.00, "car.fill", Color.yellow),
        ("Home", 1200.00, "house.fill", Color(red: 0.8, green: 0.7, blue: 0.9)),
        ("Education", 600.00, "graduationcap.fill", Color(red: 0.7, green: 0.6, blue: 0.9)),
        ("Entertainment", 450.00, "gamecontroller.fill", Color(red: 0.6, green: 0.8, blue: 1.0)),
        ("Nutrition", 800.00, "apple.fill", Color(red: 0.7, green: 0.9, blue: 0.7))
    ]
    
    private var totalMonthlyExpenses: Double {
        monthlyCategorySpending.reduce(0) { $0 + $1.amount }
    }
    
    private var currentMonthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        
        switch selectedTimePeriod {
        case "This month":
            return formatter.string(from: Date())
        case "Last month":
            if let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date()) {
                return formatter.string(from: lastMonth)
            }
            return formatter.string(from: Date())
        case "This year":
            formatter.dateFormat = "yyyy"
            return formatter.string(from: Date())
        default:
            return formatter.string(from: Date())
        }
    }
    
    // Sample transactions
    @State private var recentTransactions: [Transaction] = [
        Transaction(
            title: "Grocery Shopping",
            category: "Food",
            amount: 125.50,
            date: Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date(),
            isExpense: true,
            icon: "cart.fill",
            paidBy: "Sarah"
        ),
        Transaction(
            title: "Salary",
            category: "Income",
            amount: 3200.00,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            isExpense: false,
            icon: "dollarsign.circle.fill",
            paidBy: "Sarah"
        ),
        Transaction(
            title: "Restaurant Dinner",
            category: "Dining",
            amount: 87.30,
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
            isExpense: true,
            icon: "fork.knife",
            paidBy: "John"
        )
    ]
    
    // Calculate max value for chart scaling
    private var maxSpending: Double {
        weeklySpending.max() ?? 100
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header Section
                    headerSection
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                    
                    // Total Balance Card
                    totalBalanceCard
                        .padding(.horizontal, 20)
                    
                    // Income and Expenses Cards
                    incomeExpensesSection
                        .padding(.horizontal, 20)
                    
                    // Action Buttons
                    actionButtonsSection
                        .padding(.horizontal, 20)
                    
                    // Spending Chart
                    spendingChartSection
                        .padding(.horizontal, 20)
                    
                    // Monthly Spending by Category
                    monthlyCategorySpendingSection
                        .padding(.horizontal, 20)
                    
                    // Recent Transactions
                    recentTransactionsSection
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack(alignment: .center, spacing: 12) {
            // Profile Picture
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)
                
                Image(systemName: "person.fill")
                    .foregroundColor(.blue)
                    .font(.title3)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(getGreeting())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Sarah")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            // Notification Bell with badge
            ZStack(alignment: .topTrailing) {
                Button(action: {}) {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.primary)
                        .font(.title3)
                        .frame(width: 44, height: 44)
                }
                
                // Notification badge
                Circle()
                    .fill(Color.red)
                    .frame(width: 8, height: 8)
                    .offset(x: 4, y: -4)
            }
        }
    }
    
    private func getGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }
    
    // MARK: - Total Balance Card
    private var totalBalanceCard: some View {
        VStack(spacing: 12) {
            Text("Total Balance")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            Text("$\(totalBalance, specifier: "%.2f")")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
    }
    
    // MARK: - Income and Expenses Section
    private var incomeExpensesSection: some View {
        HStack(spacing: 16) {
            incomeExpenseCard(
                title: "Income",
                amount: income,
                icon: "arrow.up.circle.fill",
                iconColor: Color.green,
                backgroundColor: Color.green.opacity(0.12)
            )
            
            incomeExpenseCard(
                title: "Expenses",
                amount: expenses,
                icon: "arrow.down.circle.fill",
                iconColor: Color.red,
                backgroundColor: Color.red.opacity(0.12)
            )
        }
    }
    
    private func incomeExpenseCard(
        title: String,
        amount: Double,
        icon: String,
        iconColor: Color,
        backgroundColor: Color
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.title2)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("$\(amount, specifier: "%.2f")")
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(backgroundColor)
        )
    }
    
    // MARK: - Action Buttons Section
    private var actionButtonsSection: some View {
        HStack(spacing: 12) {
            // Add New Button
            Button(action: {}) {
                HStack(spacing: 8) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                    Text("Add New")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        colors: [Color(red: 1.0, green: 0.45, blue: 0.45), Color(red: 1.0, green: 0.35, blue: 0.35)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(16)
                .shadow(color: Color(red: 1.0, green: 0.4, blue: 0.4).opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .buttonStyle(PlainButtonStyle())
            
            // Analytics Button
            Button(action: {}) {
                HStack(spacing: 8) {
                    Image(systemName: "chart.pie.fill")
                        .font(.title3)
                    Text("Analytics")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    // MARK: - Spending Chart Section
    private var spendingChartSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Spending This Week")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal, 4)
            
            // Chart Container
            VStack(spacing: 16) {
                // Chart with bars
                HStack(alignment: .bottom, spacing: 12) {
                    ForEach(0..<weeklySpending.count, id: \.self) { index in
                        VStack(spacing: 10) {
                            // Bar with value label
                            ZStack(alignment: .top) {
                                // Bar
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color(red: 1.0, green: 0.45, blue: 0.45),
                                                Color(red: 1.0, green: 0.35, blue: 0.35)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(width: 36, height: calculateBarHeight(value: weeklySpending[index]))
                                    .shadow(color: Color(red: 1.0, green: 0.4, blue: 0.4).opacity(0.2), radius: 4, x: 0, y: 2)
                                
                                // Value label on top of bar
                                if weeklySpending[index] > 10 {
                                    Text("\(Int(weeklySpending[index]))")
                                        .font(.caption2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 2)
                                        .background(
                                            Capsule()
                                                .fill(Color(.systemBackground))
                                                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                                        )
                                        .offset(y: -20)
                                }
                            }
                            
                            // Day label
                            Text(weekDays[index])
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 180)
                .padding(.horizontal, 8)
                
                // Y-axis reference lines (optional, can be removed if too cluttered)
                Divider()
                    .padding(.horizontal, 8)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            )
        }
    }
    
    private func calculateBarHeight(value: Double) -> CGFloat {
        let maxHeight: CGFloat = 140
        let normalizedValue = value / maxSpending
        return max(normalizedValue * maxHeight, 8) // Minimum height of 8
    }
    
    // MARK: - Monthly Category Spending Section
    private var monthlyCategorySpendingSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header
            HStack {
                Text("Expenses by Category")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Menu {
                    Button(action: {
                        selectedTimePeriod = "This month"
                    }) {
                        HStack {
                            Text("This month")
                            if selectedTimePeriod == "This month" {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    
                    Button(action: {
                        selectedTimePeriod = "Last month"
                    }) {
                        HStack {
                            Text("Last month")
                            if selectedTimePeriod == "Last month" {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    
                    Button(action: {
                        selectedTimePeriod = "This year"
                    }) {
                        HStack {
                            Text("This year")
                            if selectedTimePeriod == "This year" {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text(selectedTimePeriod)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Image(systemName: "chevron.down")
                            .font(.caption)
                    }
                    .foregroundColor(.primary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 4)
            
            // Chart Container
            VStack(spacing: 24) {
                // Donut Chart with Month and Total
                ZStack(alignment: .center) {
                    // Donut Chart
                    DonutChartView(data: monthlyCategorySpending.map { $0.amount }, colors: monthlyCategorySpending.map { $0.color })
                        .frame(width: 220, height: 220)
                    
                    // Center Content - positioned on top
                    VStack(spacing: 8) {
                        Text(currentMonthName)
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.secondary)
                            .padding(.bottom, 2)
                        Text("-$\(Int(totalMonthlyExpenses))")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.primary)
                    }
                    .allowsHitTesting(false)
                }
                .frame(width: 220, height: 220)
                
                // Category Grid - 5 categories in flexible layout
                VStack(spacing: 12) {
                    // First row - 3 categories
                    HStack(spacing: 10) {
                        ForEach(Array(monthlyCategorySpending.prefix(3)), id: \.category) { category in
                            categoryButton(
                                category: category.category,
                                icon: category.icon,
                                color: category.color
                            )
                        }
                    }
                    
                    // Second row - 2 categories
                    HStack(spacing: 10) {
                        ForEach(Array(monthlyCategorySpending.suffix(2)), id: \.category) { category in
                            categoryButton(
                                category: category.category,
                                icon: category.icon,
                                color: category.color
                            )
                        }
                        Spacer()
                    }
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            )
        }
    }
    
    private func categoryButton(category: String, icon: String, color: Color) -> some View {
        Button(action: {}) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                    .frame(width: 20)
                Text(category)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 44)
            .background(color.opacity(0.25))
            .cornerRadius(14)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - Recent Transactions Section
    private var recentTransactionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Transactions")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {}) {
                    Text("See All")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.4))
                }
            }
            .padding(.horizontal, 4)
            
            VStack(spacing: 0) {
                ForEach(Array(recentTransactions.prefix(3).enumerated()), id: \.element.id) { index, transaction in
                    Button(action: {
                        // Handle transaction tap
                    }) {
                        TransactionRow(transaction: transaction)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    if index < 2 {
                        Divider()
                            .padding(.leading, 60)
                    }
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            )
        }
    }
}

// MARK: - Donut Chart View
struct DonutChartView: View {
    let data: [Double]
    let colors: [Color]
    let innerRadiusRatio: CGFloat = 0.5
    
    private var total: Double {
        data.reduce(0, +)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<data.count, id: \.self) { index in
                    DonutSlice(
                        startAngle: angle(for: index),
                        endAngle: angle(for: index + 1),
                        innerRadiusRatio: innerRadiusRatio
                    )
                    .fill(colors[index])
                    .opacity(0.9)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    private func angle(for index: Int) -> Angle {
        guard total > 0 else { return Angle(degrees: 0) }
        let sum = data.prefix(index).reduce(0, +)
        return Angle(degrees: (sum / total) * 360 - 90)
    }
}

struct DonutSlice: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let innerRadiusRatio: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * innerRadiusRatio
        
        var path = Path()
        
        // Calculate start and end points
        let startRadians = CGFloat(startAngle.radians)
        let endRadians = CGFloat(endAngle.radians)
        
        // Start at outer arc start point
        let outerStartPoint = CGPoint(
            x: center.x + outerRadius * cos(startRadians),
            y: center.y + outerRadius * sin(startRadians)
        )
        path.move(to: outerStartPoint)
        
        // Draw outer arc
        path.addArc(
            center: center,
            radius: outerRadius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        // Line to inner arc end point
        let innerEndPoint = CGPoint(
            x: center.x + innerRadius * cos(endRadians),
            y: center.y + innerRadius * sin(endRadians)
        )
        path.addLine(to: innerEndPoint)
        
        // Draw inner arc (reverse direction)
        path.addArc(
            center: center,
            radius: innerRadius,
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: true
        )
        
        path.closeSubpath()
        
        return path
    }
}


// MARK: - Transaction Row View
struct TransactionRow: View {
    let transaction: Transaction
    
    private var formattedDate: String {
        let now = Date()
        let timeInterval = now.timeIntervalSince(transaction.date)
        
        if timeInterval < 60 {
            return "a min ago"
        } else if timeInterval < 3600 {
            let minutes = Int(timeInterval / 60)
            return minutes == 1 ? "1 min ago" : "\(minutes) mins ago"
        } else if timeInterval < 86400 {
            let hours = Int(timeInterval / 3600)
            return hours == 1 ? "1 hour ago" : "\(hours) hours ago"
        } else if timeInterval < 604800 {
            let days = Int(timeInterval / 86400)
            return days == 1 ? "1 day ago" : "\(days) days ago"
        } else if timeInterval < 2592000 {
            let weeks = Int(timeInterval / 604800)
            return weeks == 1 ? "1 week ago" : "\(weeks) weeks ago"
        } else {
            let months = Int(timeInterval / 2592000)
            return months == 1 ? "1 month ago" : "\(months) months ago"
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(transaction.isExpense ? Color.red.opacity(0.12) : Color.green.opacity(0.12))
                    .frame(width: 48, height: 48)
                
                Image(systemName: transaction.icon)
                    .foregroundColor(transaction.isExpense ? .red : .green)
                    .font(.title3)
            }
            
            // Transaction Details
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(transaction.title)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(transaction.isExpense ? "-$\(transaction.amount, specifier: "%.2f")" : "+$\(transaction.amount, specifier: "%.2f")")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(transaction.isExpense ? .primary : .green)
                }
                
                HStack(spacing: 8) {
                    Text(transaction.category)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("•")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(transaction.paidBy)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("•")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(formattedDate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }
}

#Preview {
    HomeView()
}

