import SwiftUI

private struct PharmacyMedication: Identifiable {
    let id: String
    let name: String
    let dosage: String
    let quantity: String
}

struct PharmacyQueueView: View {
    @Environment(\.dismiss) private var dismiss
    var onCompleteVisit: (() -> Void)? = nil

    @State private var showDirections: Bool = false

    private let navy = Color(red: 0.10, green: 0.19, blue: 0.34)
    private let deepBlue = Color(red: 0.12, green: 0.32, blue: 0.48)
    private let green = Color(red: 0.05, green: 0.66, blue: 0.31)
    private let mutedText = Color(red: 0.39, green: 0.47, blue: 0.60)

    private let medications: [PharmacyMedication] = [
        PharmacyMedication(id: "amoxicillin", name: "Amoxicillin 500mg", dosage: "Take 1 tablet 3 times daily", quantity: "x15"),
        PharmacyMedication(id: "paracetamol", name: "Paracetamol 500mg", dosage: "Take 1-2 tablets when needed", quantity: "x20"),
        PharmacyMedication(id: "vitamin-d3", name: "Vitamin D3 1000 IU", dosage: "Take 1 capsule daily with food", quantity: "x30")
    ]

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 18) {
                        statusBadge
                            .padding(.top, 18)

                        tokenCard

                        prescriptionReadyCard

                        Text("PRESCRIBED MEDICATIONS")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(red: 0.42, green: 0.51, blue: 0.64))
                            .tracking(0.6)

                        VStack(spacing: 14) {
                            ForEach(medications) { medication in
                                medicationCard(medication)
                            }
                        }

                        statsRow
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .safeAreaInset(edge: .bottom) {
            bottomActions
        }
        .navigationDestination(isPresented: $showDirections) {
            RoomNavigationView()
        }
    }

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                GlassBackButtonLabel(tint: Color(red: 0.10, green: 0.30, blue: 0.42))
            }

            Spacer()

            Text("Pharmacy")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(navy)

            Spacer()

            Button(action: {}) {
                GlassIconButtonLabel(systemName: "ellipsis", tint: mutedText)
                    .rotationEffect(.degrees(90))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var statusBadge: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(green)
                .frame(width: 12, height: 12)

            Text("READY")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(red: 0.03, green: 0.55, blue: 0.38))
                .tracking(0.6)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
        .background(Color(red: 0.90, green: 0.98, blue: 0.94))
        .overlay(
            Capsule()
                .stroke(Color(red: 0.83, green: 0.94, blue: 0.88), lineWidth: 1)
        )
        .clipShape(Capsule())
    }

    private var tokenCard: some View {
        VStack(spacing: 18) {
            Text("PHARMACY TOKEN")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(red: 0.42, green: 0.51, blue: 0.64))
                .tracking(0.8)

            RoundedRectangle(cornerRadius: 22)
                .stroke(green, lineWidth: 5)
                .frame(width: 140, height: 140)
                .overlay(
                    Text("P09")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(green)
                )

            VStack(spacing: 6) {
                Text("Medication Collection")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(navy)

                Text("Counter 2 • Ground Floor")
                    .font(.system(size: 14))
                    .foregroundColor(mutedText)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 26)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 26)
                .stroke(Color(.systemGray5), lineWidth: 1.5)
        )
        .cornerRadius(26)
        .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
    }

    private var prescriptionReadyCard: some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Prescription Ready")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.03, green: 0.45, blue: 0.28))

                Text("Your medications are ready for collection")
                    .font(.system(size: 15))
                    .foregroundColor(Color(red: 0.12, green: 0.39, blue: 0.27))
            }

            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(green)
                    .frame(width: 46, height: 36)
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .padding(18)
        .background(Color(red: 0.88, green: 0.97, blue: 0.91))
        .cornerRadius(20)
    }

    private func medicationCard(_ medication: PharmacyMedication) -> some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(alignment: .leading, spacing: 10) {
                Text(medication.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(navy)

                Text(medication.dosage)
                    .font(.system(size: 14))
                    .foregroundColor(mutedText)
                    .multilineTextAlignment(.leading)
            }

            Spacer(minLength: 12)

            Text(medication.quantity)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(navy)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 18)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .cornerRadius(20)
    }

    private var statsRow: some View {
        HStack(spacing: 14) {
            statCard(title: "PEOPLE AHEAD", value: "2")
            statCard(title: "WAIT TIME", value: "10 min")
        }
    }

    private func statCard(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(red: 0.42, green: 0.51, blue: 0.64))
                .tracking(0.8)

            Text(value)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(navy)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .cornerRadius(20)
    }

    private var bottomActions: some View {
        VStack(spacing: 14) {
            Button(action: { showDirections = true }) {
                Text("Get Directions to Pharmacy")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(deepBlue)
                    .cornerRadius(18)
                    .shadow(color: deepBlue.opacity(0.2), radius: 8, y: 3)
            }

            Button(action: completeVisit) {
                Text("Complete Visit")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(deepBlue)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .padding(.bottom, 10)
        .background(Color(.systemGroupedBackground))
    }

    private func completeVisit() {
        dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            onCompleteVisit?()
        }
    }
}

#Preview {
    NavigationStack {
        PharmacyQueueView()
    }
}
