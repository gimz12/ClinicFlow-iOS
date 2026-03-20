import SwiftUI

// MARK: - Payment Card Model
struct PaymentCard: Identifiable {
    let id = UUID()
    let type: String
    let lastFour: String
    let expiryDate: String
    let icon: String
    let iconColor: Color
    var isSelected: Bool
}

// MARK: - Payment View
struct PaymentView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showSuccess: Bool = false
    @State private var shouldDismissToDashboard: Bool = false
    @State private var showAddCard: Bool = false
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    // Appointment Details (passed from previous view)
    let service: String
    let doctor: String
    let dateTime: String
    var onDismissToDashboard: (() -> Void)? = nil
    
    // Payment State
    @State private var paymentCards: [PaymentCard] = [
        PaymentCard(type: "Visa", lastFour: "1234", expiryDate: "12/26", icon: "creditcard.fill", iconColor: Color(red: 0.13, green: 0.27, blue: 0.40), isSelected: true),
        PaymentCard(type: "Mastercard", lastFour: "5678", expiryDate: "09/27", icon: "creditcard.fill", iconColor: Color(red: 0.13, green: 0.27, blue: 0.40), isSelected: false)
    ]
    
    // Fee breakdown
    let consultationFee: Double = 150.00
    let facilityFee: Double = 25.00
    let taxRate: Double = 0.10
    let insuranceCoverage: Double = 0.80
    
    var serviceTax: Double {
        (consultationFee + facilityFee) * taxRate
    }
    
    var totalAmount: Double {
        consultationFee + facilityFee + serviceTax
    }
    
    var insurancePays: Double {
        consultationFee * insuranceCoverage
    }
    
    var youPay: Double {
        totalAmount - insurancePays
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
                            Text("Complete Payment")
                                .font(.system(size: 28, weight: .bold))
                            Text("Secure payment for your appointment")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 8)
                        
                        // Appointment Summary
                        appointmentSummaryCard
                        
                        // Payment Details
                        paymentDetailsSection
                        
                        // Payment Method
                        paymentMethodSection
                        
                        // Insurance Coverage
                        insuranceCoverageCard
                        
                        // Security Message
                        securityMessage
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
        .onChange(of: shouldDismissToDashboard) { _, newValue in
            if newValue {
                if let callback = onDismissToDashboard {
                    callback()
                } else {
                    dismiss()
                }
            }
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
            
            Text("Payment")
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
    
    // MARK: - Appointment Summary Card
    var appointmentSummaryCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("APPOINTMENT SUMMARY")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(navy)
                .tracking(0.5)
            
            VStack(spacing: 8) {
                summaryRow(label: "Service:", value: service)
                summaryRow(label: "Doctor:", value: doctor)
                summaryRow(label: "Date & Time:", value: dateTime)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .overlay(
            Rectangle()
                .fill(navy)
                .frame(width: 4),
            alignment: .leading
        )
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    func summaryRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
        }
    }
    
    // MARK: - Payment Details Section
    var paymentDetailsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PAYMENT DETAILS")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            VStack(spacing: 12) {
                paymentRow(label: "Consultation Fee", amount: consultationFee)
                paymentRow(label: "Facility Fee", amount: facilityFee)
                paymentRow(label: "Service Tax (10%)", amount: serviceTax)
                
                Divider()
                
                HStack {
                    Text("Total Amount")
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                    Text(String(format: "$%.2f", totalAmount))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(navy)
                }
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    func paymentRow(label: String, amount: Double) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(.primary)
            Spacer()
            Text(String(format: "$%.2f", amount))
                .font(.system(size: 15))
                .foregroundColor(.primary)
        }
    }
    
    // MARK: - Payment Method Section
    var paymentMethodSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("PAYMENT METHOD")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
                    .tracking(0.5)
                Spacer()
                Button("Manage") {
                    // Manage cards action
                }
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(navy)
            }
            
            VStack(spacing: 12) {
                // Payment Cards
                ForEach(Array(paymentCards.enumerated()), id: \.element.id) { index, card in
                    Button(action: {
                        selectCard(at: index)
                    }) {
                        HStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(card.isSelected ? navy : lightBlue)
                                    .frame(width: 44, height: 32)
                                Image(systemName: card.icon)
                                    .font(.system(size: 16))
                                    .foregroundColor(card.isSelected ? .white : navy)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(card.type) •••• \(card.lastFour)")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.primary)
                                Text("Expires \(card.expiryDate)")
                                    .font(.system(size: 13))
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            if card.isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(navy)
                            }
                        }
                        .padding(16)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(card.isSelected ? navy : Color(.systemGray4), lineWidth: card.isSelected ? 2 : 1)
                        )
                    }
                }
                
                // Add New Card
                Button(action: {
                    showAddCard = true
                }) {
                    HStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray5))
                                .frame(width: 44, height: 32)
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Add New Card")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.primary)
                            Text("Credit or Debit Card")
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                }
                .navigationDestination(isPresented: $showAddCard) {
                    AddPaymentMethodView()
                }
            }
        }
    }
    
    func selectCard(at index: Int) {
        for i in 0..<paymentCards.count {
            paymentCards[i].isSelected = (i == index)
        }
    }
    
    // MARK: - Insurance Coverage Card
    var insuranceCoverageCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.teal.opacity(0.1))
                        .frame(width: 44, height: 44)
                    Image(systemName: "checkmark.shield.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.teal)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Insurance Coverage")
                        .font(.system(size: 15, weight: .semibold))
                    Text("Your insurance covers 80% of consultation fees")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
            
            VStack(spacing: 8) {
                HStack {
                    Text("Insurance pays:")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(String(format: "$%.2f", insurancePays))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.green)
                }
                
                HStack {
                    Text("You pay:")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(String(format: "$%.2f", youPay))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(navy)
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    // MARK: - Security Message
    var securityMessage: some View {
        HStack(spacing: 8) {
            Image(systemName: "lock.fill")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            Text("Your payment is secured with 256-bit SSL encryption")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    // MARK: - Bottom Button
    var bottomButton: some View {
        VStack(spacing: 12) {
            // Pay button
            Button(action: {
                showSuccess = true
            }) {
                Text(String(format: "Pay $%.2f", youPay))
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(navy)
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.15), radius: 6, y: 3)
            }
            .padding(.horizontal, 16)
            .navigationDestination(isPresented: $showSuccess) {
                PaymentSuccessView(onDismissToDashboard: {
                    showSuccess = false
                    shouldDismissToDashboard = true
                })
            }
            
            // Terms
            HStack(spacing: 4) {
                Text("By proceeding, you agree to our")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                Button("Terms of Service") {
                    // Terms action
                }
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(navy)
            }
            .padding(.bottom, 8)
        }
        .padding(.top, 12)
        .background(
            Color(.systemBackground)
                .shadow(color: .black.opacity(0.05), radius: 8, y: -4)
        )
    }
}

// MARK: - Payment Success View
struct PaymentSuccessView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showInvoice: Bool = false
    @State private var showAppointmentDetails: Bool = false
    @State private var shouldDismissToDashboard: Bool = false
    
    var onDismissToDashboard: () -> Void
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    // Payment details
    let amountPaid: Double = 72.50
    let transactionId: String = "#TXN-2026-0228-001"
    let paymentMethod: String = "Visa •••• 1234"
    let transactionDateTime: String = "Feb 21, 2026 at 9:41 AM"
    
    // Appointment details
    let service: String = "Follow-up Consultation"
    let doctor: String = "Dr. Sarah Johnson"
    let appointmentDateTime: String = "Feb 28, 10:30 AM"
    let location: String = "Room C-205"
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                // Success Icon
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.15))
                        .frame(width: 100, height: 100)
                    Image(systemName: "checkmark")
                        .font(.system(size: 50, weight: .semibold))
                        .foregroundColor(.green)
                }
                .padding(.top, 40)
                
                // Title
                VStack(spacing: 8) {
                    Text("Payment Successful!")
                        .font(.system(size: 28, weight: .bold))
                    
                    Text("Your appointment has been confirmed")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                
                // Amount Paid Card
                amountPaidCard
                
                // Appointment Confirmed Card
                appointmentConfirmedCard
                
                // Confirmation Message
                confirmationMessage
                
                // Buttons
                VStack(spacing: 12) {
                    // View Receipt Button
                    Button(action: {
                        showInvoice = true
                    }) {
                        Text("View Receipt")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(navy)
                            .cornerRadius(30)
                    }
                    .navigationDestination(isPresented: $showInvoice) {
                        InvoiceView()
                    }
                    
                    // View Appointment Details Button
                    Button(action: {
                        showAppointmentDetails = true
                    }) {
                        Text("View Appointment Details")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(navy)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(.systemBackground))
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                    }
                    .navigationDestination(isPresented: $showAppointmentDetails) {
                        AppointmentDetailsView(onDismissToDashboard: {
                            showAppointmentDetails = false
                            shouldDismissToDashboard = true
                        })
                    }
                    
                    // Back to Home
                    Button(action: {
                        shouldDismissToDashboard = true
                    }) {
                        Text("Back to Home")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(navy)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onChange(of: shouldDismissToDashboard) { _, newValue in
            if newValue {
                onDismissToDashboard()
            }
        }
    }
    
    // MARK: - Amount Paid Card
    var amountPaidCard: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                Text("Amount Paid")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                Text(String(format: "$%.2f", amountPaid))
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(navy)
            }
            
            Divider()
            
            VStack(spacing: 12) {
                detailRow(label: "Transaction ID", value: transactionId)
                detailRow(label: "Payment Method", value: paymentMethod)
                detailRow(label: "Date & Time", value: transactionDateTime)
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        .padding(.horizontal, 16)
    }
    
    // MARK: - Appointment Confirmed Card
    var appointmentConfirmedCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("APPOINTMENT CONFIRMED")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(navy)
                .tracking(0.5)
            
            VStack(spacing: 10) {
                appointmentRow(label: "Service:", value: service)
                appointmentRow(label: "Doctor:", value: doctor)
                appointmentRow(label: "Date & Time:", value: appointmentDateTime)
                appointmentRow(label: "Location:", value: location)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(lightBlue.opacity(0.5))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(navy.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }
    
    // MARK: - Confirmation Message
    var confirmationMessage: some View {
        HStack(spacing: 10) {
            Image(systemName: "envelope.fill")
                .font(.system(size: 16))
                .foregroundColor(navy.opacity(0.6))
            
            Text("Confirmation sent to your email and phone")
                .font(.system(size: 14))
                .foregroundColor(navy.opacity(0.8))
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(lightBlue.opacity(0.3))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(navy.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }
    
    func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
        }
    }
    
    func appointmentRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    NavigationStack {
        PaymentView(
            service: "Follow-up Consultation",
            doctor: "Dr. Sarah Johnson",
            dateTime: "Feb 28, 10:30 AM"
        )
    }
}
