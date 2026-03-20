import SwiftUI

// MARK: - Transaction Model
struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let amount: Double
    let status: TransactionStatus
    let iconName: String
}

enum TransactionStatus: String {
    case paid = "Paid"
    case pending = "Pending"
    case refunded = "Refunded"
    
    var color: Color {
        switch self {
        case .paid:
            return Color.green
        case .pending:
            return Color.orange
        case .refunded:
            return Color.blue
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .paid:
            return Color.green.opacity(0.15)
        case .pending:
            return Color.orange.opacity(0.15)
        case .refunded:
            return Color.blue.opacity(0.15)
        }
    }
}

// MARK: - Filter Tab
enum TransactionFilter: String, CaseIterable {
    case all = "All"
    case paid = "Paid"
    case pending = "Pending"
    case refunded = "Refunded"
}

// MARK: - Billing History View
struct BillingHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedFilter: TransactionFilter = .all
    @State private var showDownload: Bool = false
    @State private var showLoadMore: Bool = false
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    private let transactions: [Transaction] = [
        Transaction(title: "Lab Work - Blood Panel", date: "May 15, 2025", amount: 85.00, status: .paid, iconName: "cross.vial"),
        Transaction(title: "Consultation - Dr. Smith", date: "May 10, 2025", amount: 150.00, status: .paid, iconName: "stethoscope"),
        Transaction(title: "Prescription Refill", date: "May 8, 2025", amount: 45.00, status: .pending, iconName: "pills"),
        Transaction(title: "X-Ray Imaging", date: "May 1, 2025", amount: 200.00, status: .refunded, iconName: "waveform.path.ecg"),
        Transaction(title: "Annual Physical Exam", date: "April 28, 2025", amount: 120.00, status: .paid, iconName: "heart.text.square"),
        Transaction(title: "Vaccination", date: "April 20, 2025", amount: 35.00, status: .paid, iconName: "syringe")
    ]
    
    var filteredTransactions: [Transaction] {
        switch selectedFilter {
        case .all:
            return transactions
        case .paid:
            return transactions.filter { $0.status == .paid }
        case .pending:
            return transactions.filter { $0.status == .pending }
        case .refunded:
            return transactions.filter { $0.status == .refunded }
        }
    }
    
    var totalPaid: Double {
        transactions.filter { $0.status == .paid }.reduce(0) { $0 + $1.amount }
    }
    
    var totalPending: Double {
        transactions.filter { $0.status == .pending }.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                headerView
                
                // Content
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Title Section
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Billing History")
                                .font(.system(size: 28, weight: .bold))
                            Text("View all your transactions")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 8)
                        
                        // Summary Cards
                        summaryCards
                        
                        // Filter Tabs
                        filterTabs
                        
                        // Transactions List
                        transactionsList
                        
                        // Load More
                        loadMoreButton
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $showDownload) {
            PlaceholderScreen(title: "Download Statement")
        }
        .navigationDestination(isPresented: $showLoadMore) {
            PlaceholderScreen(title: "Load More Transactions")
        }
    }
    
    // MARK: - Header
    var headerView: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Back")
                        .font(.system(size: 17))
                }
                .foregroundColor(.primary)
            }
            
            Spacer()
            
            Text("Billing History")
                .font(.system(size: 17, weight: .semibold))
            
            Spacer()
            
            // Download button
            Button(action: {
                showDownload = true
            }) {
                Image(systemName: "arrow.down.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Summary Cards
    var summaryCards: some View {
        HStack(spacing: 12) {
            // Total Paid
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    ZStack {
                        Circle()
                            .fill(Color.green.opacity(0.15))
                            .frame(width: 28, height: 28)
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.green)
                    }
                    Text("Total Paid")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Text("$\(String(format: "%.2f", totalPaid))")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.green)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
            
            // Total Pending
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    ZStack {
                        Circle()
                            .fill(Color.orange.opacity(0.15))
                            .frame(width: 28, height: 28)
                        Image(systemName: "clock.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                    }
                    Text("Pending")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Text("$\(String(format: "%.2f", totalPending))")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.orange)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Filter Tabs
    var filterTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(TransactionFilter.allCases, id: \.self) { filter in
                    filterTab(filter)
                }
            }
        }
    }
    
    func filterTab(_ filter: TransactionFilter) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedFilter = filter
            }
        }) {
            Text(filter.rawValue)
                .font(.system(size: 14, weight: selectedFilter == filter ? .semibold : .regular))
                .foregroundColor(selectedFilter == filter ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(selectedFilter == filter ? navy : Color(.systemBackground))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(selectedFilter == filter ? Color.clear : Color(.systemGray4), lineWidth: 1)
                )
        }
    }
    
    // MARK: - Transactions List
    var transactionsList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("TRANSACTIONS")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            ForEach(filteredTransactions) { transaction in
                transactionRow(transaction)
            }
            
            if filteredTransactions.isEmpty {
                HStack {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: 40))
                            .foregroundColor(.secondary)
                        Text("No \(selectedFilter.rawValue.lowercased()) transactions")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 40)
                    Spacer()
                }
            }
        }
    }
    
    func transactionRow(_ transaction: Transaction) -> some View {
        HStack(spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 44, height: 44)
                Image(systemName: transaction.iconName)
                    .font(.system(size: 18))
                    .foregroundColor(navy)
            }
            
            // Details
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.system(size: 15, weight: .semibold))
                Text(transaction.date)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Amount and Status
            VStack(alignment: .trailing, spacing: 4) {
                Text(transaction.status == .refunded ? "+$\(String(format: "%.2f", transaction.amount))" : "$\(String(format: "%.2f", transaction.amount))")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(transaction.status == .refunded ? .blue : .primary)
                
                Text(transaction.status.rawValue)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(transaction.status.color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(transaction.status.backgroundColor)
                    .cornerRadius(4)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    // MARK: - Load More
    var loadMoreButton: some View {
        Button(action: {
            showLoadMore = true
        }) {
            HStack {
                Spacer()
                Text("Load More Transactions")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(navy)
                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(navy)
                Spacer()
            }
            .padding(.vertical, 12)
        }
    }
}

#Preview {
    NavigationStack {
        BillingHistoryView()
    }
}
