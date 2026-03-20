import SwiftUI

struct PrescriptionRefillView: View {
    @Environment(\.dismiss) private var dismiss

    let prescription: Prescription

    @State private var refillQuantity: String = "30"
    @State private var pickupMethod: String = "Pickup"
    @State private var notes: String = ""

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        summaryCard
                        refillCard
                        notesCard
                    }
                    .padding(16)
                }

                Button(action: submitRefill) {
                    Text("Submit Refill Request")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(navy)
                        .cornerRadius(14)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 18)
            }
        }
    }

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(navy)
            }

            Spacer()

            Text("Request Refill")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(prescription.name)
                .font(.system(size: 18, weight: .bold))
            Text("\(prescription.dosage) • \(prescription.frequency)")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
            Text(prescription.instructions)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var refillCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Refill Details")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)

            TextField("Quantity", text: $refillQuantity)
                .keyboardType(.numberPad)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)

            Picker("Pickup Method", selection: $pickupMethod) {
                Text("Pickup").tag("Pickup")
                Text("Delivery").tag("Delivery")
            }
            .pickerStyle(.segmented)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var notesCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Notes")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
            TextField("Add a note for the pharmacy", text: $notes, axis: .vertical)
                .lineLimit(3, reservesSpace: true)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private func submitRefill() {
        dismiss()
    }
}

#Preview {
    PrescriptionRefillView(prescription: Prescription(name: "Lisinopril", dosage: "10mg", frequency: "Once daily", daysLeft: 10, supplyPercent: 0.5, instructions: "Take daily with food", color: .blue, icon: "pills.fill"))
}
