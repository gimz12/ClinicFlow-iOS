import SwiftUI

// MARK: - Saved Card Model
struct SavedCard: Identifiable {
    let id = UUID()
    let type: String
    let lastFour: String
    let holderName: String
    let expiryDate: String
    var isPrimary: Bool
    let iconColor: Color
}

// MARK: - Payment Methods View
struct PaymentMethodsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showAddCard: Bool = false
    @State private var showBillingHistory: Bool = false
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    @State private var savedCards: [SavedCard] = [
        SavedCard(type: "Visa", lastFour: "1234", holderName: "John Patient", expiryDate: "12/2026", isPrimary: true, iconColor: Color(red: 0.13, green: 0.27, blue: 0.40)),
        SavedCard(type: "Mastercard", lastFour: "5678", holderName: "John Patient", expiryDate: "09/2027", isPrimary: false, iconColor: .orange),
        SavedCard(type: "Amex", lastFour: "9012", holderName: "John Patient", expiryDate: "03/2028", isPrimary: false, iconColor: .orange)
    ]
    
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
                            Text("Payment Methods")
                                .font(.system(size: 28, weight: .bold))
                            Text("Manage your saved payment methods")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 8)
                        
                        // Saved Cards Section
                        savedCardsSection
                        
                        // Security Card
                        securityCard
                        
                        // Billing History
                        billingHistoryCard
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 140)
                }
                
                Spacer()
            }
            
            // Bottom button
            VStack {
                Spacer()
                bottomButton
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
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
            
            Text("Payment Methods")
                .font(.system(size: 17, weight: .semibold))
            
            Spacer()
            
            // Placeholder for alignment
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                Text("Back")
                    .font(.system(size: 17))
            }
            .opacity(0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Saved Cards Section
    var savedCardsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SAVED CARDS")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            ForEach(Array(savedCards.enumerated()), id: \.element.id) { index, card in
                cardRow(card: card, index: index)
            }
        }
    }
    
    func cardRow(card: SavedCard, index: Int) -> some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                // Card icon
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(card.iconColor)
                        .frame(width: 48, height: 36)
                    Image(systemName: "creditcard.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 8) {
                        Text("\(card.type) •••• \(card.lastFour)")
                            .font(.system(size: 16, weight: .semibold))
                        
                        if card.isPrimary {
                            Text("Primary")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(navy)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(lightBlue)
                                .cornerRadius(4)
                        }
                    }
                    Text(card.holderName)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    Text("Expires \(card.expiryDate)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            // Action buttons
            HStack(spacing: 12) {
                if !card.isPrimary {
                    Button(action: {
                        setPrimaryCard(at: index)
                    }) {
                        Text("Set as Primary")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(navy)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                    }
                }
                
                Button(action: {
                    // Edit card action
                }) {
                    Text("Edit")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(.horizontal, card.isPrimary ? 24 : 16)
                        .padding(.vertical, 8)
                        .background(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                
                if card.isPrimary {
                    Button(action: {
                        // Remove card action
                    }) {
                        Text("Remove")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                    }
                } else {
                    Button(action: {
                        removeCard(at: index)
                    }) {
                        Image(systemName: "trash")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                    }
                }
                
                Spacer()
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    func setPrimaryCard(at index: Int) {
        for i in 0..<savedCards.count {
            savedCards[i].isPrimary = (i == index)
        }
    }
    
    func removeCard(at index: Int) {
        savedCards.remove(at: index)
    }
    
    // MARK: - Security Card
    var securityCard: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(lightBlue)
                    .frame(width: 44, height: 44)
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 20))
                    .foregroundColor(navy)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Secure & Encrypted")
                    .font(.system(size: 15, weight: .semibold))
                Text("All payment information is encrypted and securely stored. We never share your data.")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(16)
        .background(lightBlue.opacity(0.5))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(navy.opacity(0.15), lineWidth: 1)
        )
    }
    
    // MARK: - Billing History Card
    var billingHistoryCard: some View {
        Button(action: {
            showBillingHistory = true
        }) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color(.systemGray5))
                        .frame(width: 44, height: 44)
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Billing History")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    Text("View all transactions")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
        .navigationDestination(isPresented: $showBillingHistory) {
            BillingHistoryView()
        }
    }
    
    // MARK: - Bottom Button
    var bottomButton: some View {
        VStack(spacing: 0) {
            Button(action: {
                showAddCard = true
            }) {
                Text("Add New Payment Method")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(navy)
                    .cornerRadius(30)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .navigationDestination(isPresented: $showAddCard) {
                AddPaymentMethodView()
            }
        }
        .background(
            Color(.systemBackground)
                .shadow(color: .black.opacity(0.05), radius: 8, y: -4)
        )
    }
}

#Preview {
    NavigationStack {
        PaymentMethodsView()
    }
}
