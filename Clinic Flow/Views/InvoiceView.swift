import SwiftUI

// MARK: - Invoice View
struct InvoiceView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)
    private let lightBlue = Color(red: 0.88, green: 0.93, blue: 0.97)
    
    // Invoice details
    let invoiceNumber: String = "INV-2026-0228"
    let issueDate: String = "Feb 21, 2026"
    
    // Hospital info
    let hospitalName: String = "Central Medical Hospital"
    let hospitalAddress: String = "123 Healthcare Avenue\nMedical City, MC 12345"
    let hospitalPhone: String = "(555) 123-4567"
    
    // Patient info
    let patientName: String = "John Patient"
    let patientId: String = "#P-12345"
    let patientEmail: String = "john.patient@email.com"
    let patientPhone: String = "(555) 987-6543"
    
    // Service details
    let serviceName: String = "Follow-up Consultation"
    let doctorName: String = "Dr. Sarah Johnson - Cardiology"
    let serviceDate: String = "Feb 28, 2026 at 10:30 AM"
    let serviceLocation: String = "Room C-205"
    
    // Payment breakdown
    let consultationFee: Double = 150.00
    let facilityFee: Double = 25.00
    let serviceTax: Double = 17.50
    var subtotal: Double { consultationFee + facilityFee + serviceTax }
    
    // Insurance
    let insuranceProvider: String = "HealthCare Plus"
    let policyNumber: String = "HCP-123-456-789"
    let coveragePercent: String = "80%"
    let insurancePays: Double = 120.00
    
    // Final amount
    let amountPaid: Double = 72.50
    
    // Payment info
    let paymentMethod: String = "Visa •••• 1234"
    let transactionId: String = "#TXN-2026-0228-001"
    let paymentDate: String = "Feb 21, 2026"
    let paymentTime: String = "9:41 AM"
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                headerView
                
                // Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Paid Badge
                        paidBadge
                        
                        // Invoice Title
                        invoiceTitle
                        
                        // Hospital Card
                        hospitalCard
                        
                        // Billed To
                        billedToSection
                        
                        // Service Details
                        serviceDetailsSection
                        
                        // Payment Breakdown
                        paymentBreakdownSection
                        
                        // Insurance Coverage
                        insuranceCoverageSection
                        
                        // Amount Paid
                        amountPaidCard
                        
                        // Payment Information
                        paymentInformationSection
                        
                        // Note
                        noteSection
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
            
            Text("Invoice")
                .font(.system(size: 17, weight: .semibold))
            
            Spacer()
            
            Button(action: {
                // Share action
            }) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Paid Badge
    var paidBadge: some View {
        HStack(spacing: 6) {
            Image(systemName: "checkmark")
                .font(.system(size: 12, weight: .bold))
            Text("PAID")
                .font(.system(size: 12, weight: .bold))
        }
        .foregroundColor(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(navy)
        .cornerRadius(20)
    }
    
    // MARK: - Invoice Title
    var invoiceTitle: some View {
        VStack(spacing: 4) {
            Text("Invoice #\(invoiceNumber)")
                .font(.system(size: 24, weight: .bold))
            Text("Issued on \(issueDate)")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - Hospital Card
    var hospitalCard: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(lightBlue)
                    .frame(width: 44, height: 44)
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(navy)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(hospitalName)
                    .font(.system(size: 15, weight: .semibold))
                Text(hospitalAddress.replacingOccurrences(of: "\n", with: ", "))
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                Text("Phone: \(hospitalPhone)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    // MARK: - Billed To Section
    var billedToSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("BILLED TO")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(patientName)
                    .font(.system(size: 15, weight: .semibold))
                Text("Patient ID: \(patientId)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                Text("Email: \(patientEmail)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                Text("Phone: \(patientPhone)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Service Details Section
    var serviceDetailsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SERVICE DETAILS")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(serviceName)
                    .font(.system(size: 15, weight: .semibold))
                Text(doctorName)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                Text("Date: \(serviceDate)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                Text("Location: \(serviceLocation)")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    // MARK: - Payment Breakdown Section
    var paymentBreakdownSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PAYMENT BREAKDOWN")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            VStack(spacing: 12) {
                paymentRow(label: "Consultation Fee", amount: consultationFee)
                paymentRow(label: "Facility Fee", amount: facilityFee)
                paymentRow(label: "Service Tax (10%)", amount: serviceTax)
                
                Divider()
                
                HStack {
                    Text("Subtotal")
                        .font(.system(size: 15, weight: .semibold))
                    Spacer()
                    Text(String(format: "$%.2f", subtotal))
                        .font(.system(size: 15, weight: .semibold))
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
                .font(.system(size: 14))
                .foregroundColor(.primary)
            Spacer()
            Text(String(format: "$%.2f", amount))
                .font(.system(size: 14))
                .foregroundColor(.primary)
        }
    }
    
    // MARK: - Insurance Coverage Section
    var insuranceCoverageSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("INSURANCE COVERAGE")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            VStack(spacing: 10) {
                insuranceRow(label: "Provider:", value: insuranceProvider)
                insuranceRow(label: "Policy #:", value: policyNumber)
                insuranceRow(label: "Coverage:", value: coveragePercent)
                
                HStack {
                    Text("Insurance Pays:")
                        .font(.system(size: 14))
                        .foregroundColor(navy)
                    Spacer()
                    Text(String(format: "$%.2f", insurancePays))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(navy)
                }
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(navy.opacity(0.2), lineWidth: 1)
            )
        }
    }
    
    func insuranceRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(navy.opacity(0.7))
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(navy)
        }
    }
    
    // MARK: - Amount Paid Card
    var amountPaidCard: some View {
        HStack {
            Text("Amount Paid")
                .font(.system(size: 16, weight: .semibold))
            Spacer()
            Text(String(format: "$%.2f", amountPaid))
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(navy)
        }
        .padding(16)
        .background(lightBlue)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(navy.opacity(0.3), lineWidth: 1)
        )
    }
    
    // MARK: - Payment Information Section
    var paymentInformationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PAYMENT INFORMATION")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .tracking(0.5)
            
            VStack(spacing: 10) {
                infoRow(label: "Payment Method:", value: paymentMethod)
                infoRow(label: "Transaction ID:", value: transactionId)
                infoRow(label: "Payment Date:", value: paymentDate)
                infoRow(label: "Payment Time:", value: paymentTime)
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        }
    }
    
    func infoRow(label: String, value: String) -> some View {
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
    
    // MARK: - Note Section
    var noteSection: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("Note:")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.secondary)
            Text("This is an official invoice from Central Medical Hospital. Please keep this for your records. For questions about this invoice, contact our billing department at (555) 123-4567.")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
    
    // MARK: - Bottom Buttons
    var bottomButtons: some View {
        VStack(spacing: 12) {
            // Download PDF button
            Button(action: {
                // Download PDF action
            }) {
                Text("Download PDF")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(navy)
                    .cornerRadius(30)
            }
            .padding(.horizontal, 16)
            
            // Email Invoice button
            Button(action: {
                // Email invoice action
            }) {
                Text("Email Invoice")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .padding(.top, 12)
        .background(
            Color(.systemBackground)
                .shadow(color: .black.opacity(0.05), radius: 8, y: -4)
        )
    }
}

#Preview {
    NavigationStack {
        InvoiceView()
    }
}
