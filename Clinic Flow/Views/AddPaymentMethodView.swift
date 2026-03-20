import SwiftUI

// MARK: - Add Payment Method View
struct AddPaymentMethodView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var cardNumber: String = ""
    @State private var holderName: String = ""
    @State private var expiryDate: String = ""
    @State private var cvv: String = ""
    @State private var billingZip: String = ""
    @State private var setAsPrimary: Bool = false
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    // Computed property for card type
    private var cardType: String {
        let cleanNumber = cardNumber.replacingOccurrences(of: " ", with: "")
        if cleanNumber.hasPrefix("4") {
            return "Visa"
        } else if cleanNumber.hasPrefix("5") || cleanNumber.hasPrefix("2") {
            return "Mastercard"
        } else if cleanNumber.hasPrefix("3") {
            return "Amex"
        }
        return "Card"
    }
    
    // Formatted card number (with spaces)
    private var formattedDisplayNumber: String {
        let cleanNumber = cardNumber.replacingOccurrences(of: " ", with: "")
        var result = ""
        for (index, char) in cleanNumber.enumerated() {
            if index > 0 && index % 4 == 0 {
                result += " "
            }
            result += String(char)
        }
        // Pad with bullet points if needed
        let remaining = 16 - cleanNumber.count
        if remaining > 0 {
            if result.isEmpty {
                result = "•••• •••• •••• ••••"
            } else {
                // Add remaining bullets
                for i in cleanNumber.count..<16 {
                    if i % 4 == 0 && i > 0 {
                        result += " "
                    }
                    result += "•"
                }
            }
        }
        return result
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
                            Text("Add Payment Method")
                                .font(.system(size: 28, weight: .bold))
                            Text("Enter your card details")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 8)
                        
                        // Card Preview
                        cardPreview
                        
                        // Card Details Form
                        cardDetailsForm
                        
                        // Security Info
                        securityInfoCard
                        
                        // Supported Cards
                        supportedCardsSection
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 140)
                }
                
                Spacer()
            }
            
            // Bottom buttons
            VStack {
                Spacer()
                bottomButtons
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
            
            Text("Add Card")
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
    
    // MARK: - Card Preview
    var cardPreview: some View {
        ZStack {
            // Card background
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [navy, navy.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 200)
            
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text(cardType.uppercased())
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.9))
                        .tracking(1.5)
                    
                    Spacer()
                    
                    // Card type icon
                    Image(systemName: "creditcard.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                // Card number
                Text(formattedDisplayNumber)
                    .font(.system(size: 22, weight: .semibold, design: .monospaced))
                    .foregroundColor(.white)
                    .tracking(2)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CARDHOLDER")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                        Text(holderName.isEmpty ? "YOUR NAME" : holderName.uppercased())
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("EXPIRES")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                        Text(expiryDate.isEmpty ? "MM/YY" : expiryDate)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(24)
        }
    }
    
    // MARK: - Card Details Form
    var cardDetailsForm: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("CARD DETAILS")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            VStack(spacing: 0) {
                // Card Number
                formField(
                    icon: "creditcard",
                    placeholder: "Card Number",
                    text: $cardNumber,
                    keyboardType: .numberPad,
                    showDivider: true
                )
                
                // Cardholder Name
                formField(
                    icon: "person",
                    placeholder: "Cardholder Name",
                    text: $holderName,
                    keyboardType: .default,
                    showDivider: true
                )
                
                // Expiry and CVV
                HStack(spacing: 0) {
                    // Expiry Date
                    HStack(spacing: 12) {
                        Image(systemName: "calendar")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                            .frame(width: 24)
                        
                        TextField("MM/YY", text: $expiryDate)
                            .font(.system(size: 16))
                            .keyboardType(.numberPad)
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 16)
                    
                    // Divider
                    Rectangle()
                        .fill(Color(.separator))
                        .frame(width: 1)
                        .padding(.vertical, 12)
                    
                    // CVV
                    HStack(spacing: 12) {
                        Image(systemName: "lock")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                            .frame(width: 24)
                        
                        SecureField("CVV", text: $cvv)
                            .font(.system(size: 16))
                            .keyboardType(.numberPad)
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 16)
                }
                
                Divider()
                
                // Billing Zip Code
                formField(
                    icon: "mappin.circle",
                    placeholder: "Billing Zip Code",
                    text: $billingZip,
                    keyboardType: .numberPad,
                    showDivider: false
                )
            }
            .background(Color(.systemBackground))
            .cornerRadius(14)
            
            // Set as Primary Toggle
            HStack {
                Button(action: {
                    setAsPrimary.toggle()
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: setAsPrimary ? "checkmark.square.fill" : "square")
                            .font(.system(size: 20))
                            .foregroundColor(setAsPrimary ? navy : .secondary)
                        
                        Text("Set as primary payment method")
                            .font(.system(size: 15))
                            .foregroundColor(.primary)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 8)
        }
    }
    
    func formField(icon: String, placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType, showDivider: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .frame(width: 24)
                
                TextField(placeholder, text: text)
                    .font(.system(size: 16))
                    .keyboardType(keyboardType)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            
            if showDivider {
                Divider()
                    .padding(.leading, 52)
            }
        }
    }
    
    // MARK: - Security Info
    var securityInfoCard: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(lightBlue)
                    .frame(width: 44, height: 44)
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 18))
                    .foregroundColor(navy)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Secure Transaction")
                    .font(.system(size: 15, weight: .semibold))
                Text("Your card details are encrypted using industry-standard SSL encryption.")
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
    
    // MARK: - Supported Cards
    var supportedCardsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SUPPORTED CARDS")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            HStack(spacing: 12) {
                cardTypeIcon("V", label: "Visa", color: navy)
                cardTypeIcon("M", label: "Mastercard", color: .red)
                cardTypeIcon("A", label: "Amex", color: .blue)
                cardTypeIcon("D", label: "Discover", color: .orange)
                
                Spacer()
            }
        }
    }
    
    func cardTypeIcon(_ letter: String, label: String, color: Color) -> some View {
        VStack(spacing: 4) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: 50, height: 34)
                Text(letter)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
            Text(label)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - Bottom Buttons
    var bottomButtons: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                // Cancel Button
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(.systemBackground))
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                
                // Add Card Button
                Button(action: {
                    // Add card action
                    dismiss()
                }) {
                    Text("Add Card")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(navy)
                        .cornerRadius(30)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(
            Color(.systemBackground)
                .shadow(color: .black.opacity(0.05), radius: 8, y: -4)
        )
    }
}

#Preview {
    NavigationStack {
        AddPaymentMethodView()
    }
}
