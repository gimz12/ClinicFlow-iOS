import SwiftUI

struct PrescriptionsListView: View {
    @Environment(\.dismiss) private var dismiss

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    private let prescriptions: [Prescription] = [
        Prescription(name: "Lisinopril", dosage: "10mg", frequency: "Once daily",
                     daysLeft: 13, supplyPercent: 0.65,
                     instructions: "Take: Every morning with food",
                     color: Color.purple, icon: "pills.fill"),
        Prescription(name: "Metformin", dosage: "500mg", frequency: "Twice daily",
                     daysLeft: 6, supplyPercent: 0.30,
                     instructions: "Take: Morning & evening with meals",
                     color: Color.orange, icon: "cross.vial.fill"),
        Prescription(name: "Atorvastatin", dosage: "20mg", frequency: "Once nightly",
                     daysLeft: 21, supplyPercent: 0.75,
                     instructions: "Take: Evening with water",
                     color: Color.blue, icon: "pills.circle.fill")
    ]

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(prescriptions) { rx in
                            prescriptionRow(rx)
                        }
                    }
                    .padding(16)
                }
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

            Text("Prescriptions")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private func prescriptionRow(_ rx: Prescription) -> some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(rx.color.opacity(0.15))
                        .frame(width: 44, height: 44)
                    Image(systemName: rx.icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(rx.color)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(rx.name)
                        .font(.system(size: 16, weight: .semibold))
                    Text("\(rx.dosage) • \(rx.frequency)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Text("\(rx.daysLeft)d left")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(rx.instructions)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)

                ProgressView(value: rx.supplyPercent)
                    .tint(rx.color)
            }
        }
        .padding(14)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
}

#Preview {
    PrescriptionsListView()
}
