import SwiftUI

private struct CheckInService: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
    let tint: Color
    let background: Color
}

struct CheckInView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var selectedServiceID: String = "general-opd"
    @State private var showBookAppointment: Bool = false
    @State private var showLaboratoryQueue: Bool = false
    @State private var showPharmacyCheckIn: Bool = false

    private let screenBackground = Color(.systemGroupedBackground)
    private let navy = Color(red: 0.10, green: 0.19, blue: 0.34)
    private let accentBlue = Color(red: 0.15, green: 0.39, blue: 0.96)
    private let actionBlue = Color(red: 0.12, green: 0.32, blue: 0.48)
    private let mutedText = Color(red: 0.39, green: 0.47, blue: 0.60)

    private let services: [CheckInService] = [
        CheckInService(
            id: "general-opd",
            title: "General OPD",
            subtitle: "Outpatient Department",
            icon: "square.3.layers.3d.down.right",
            tint: Color(red: 0.15, green: 0.39, blue: 0.96),
            background: Color(red: 0.82, green: 0.88, blue: 0.98)
        ),
        CheckInService(
            id: "laboratory",
            title: "Laboratory",
            subtitle: "Blood Tests & Diagnostics",
            icon: "flask",
            tint: Color(red: 0.50, green: 0.12, blue: 0.90),
            background: Color(red: 0.92, green: 0.86, blue: 0.98)
        ),
        CheckInService(
            id: "pharmacy",
            title: "Pharmacy",
            subtitle: "Prescription Collection",
            icon: "cross.case",
            tint: Color(red: 0.06, green: 0.62, blue: 0.25),
            background: Color(red: 0.84, green: 0.96, blue: 0.88)
        )
    ]

    var body: some View {
        ZStack {
            screenBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        titleSection

                        VStack(spacing: 18) {
                            ForEach(services) { service in
                                serviceCard(service)
                            }
                        }

                        quickTipCard
                            .padding(.top, 6)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 18)
                    .padding(.bottom, 28)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .safeAreaInset(edge: .bottom) {
            confirmButtonBar
        }
        .navigationDestination(isPresented: $showBookAppointment) {
            BookAppointmentView()
        }
        .navigationDestination(isPresented: $showLaboratoryQueue) {
            LaboratoryQueueView(onCompleteVisit: {
                showLaboratoryQueue = false
                dismiss()
            })
        }
        .navigationDestination(isPresented: $showPharmacyCheckIn) {
            PharmacyQueueView(onCompleteVisit: {
                showPharmacyCheckIn = false
                dismiss()
            })
        }
    }

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                GlassBackButtonLabel(tint: Color(red: 0.10, green: 0.30, blue: 0.42))
            }

            Spacer()

            Text("Check-In")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(navy)

            Spacer()

            GlassBackButtonLabel(tint: Color(red: 0.10, green: 0.30, blue: 0.42))
            .opacity(0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Select Service")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(navy)

            Text("Choose the department you need to visit today")
                .font(.system(size: 16))
                .foregroundColor(mutedText)
        }
        .padding(.top, 10)
        .padding(.bottom, 8)
    }

    private func serviceCard(_ service: CheckInService) -> some View {
        let isSelected = selectedServiceID == service.id

        return Button {
            selectedServiceID = service.id
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(service.background)
                        .frame(width: 72, height: 72)

                    Image(systemName: service.icon)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(service.tint)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text(service.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(navy)

                    Text(service.subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(mutedText)
                        .multilineTextAlignment(.leading)
                }

                Spacer(minLength: 12)

                ZStack {
                    Circle()
                        .stroke(isSelected ? accentBlue : Color(.systemGray4), lineWidth: 2.5)
                        .frame(width: 30, height: 30)

                    if isSelected {
                        Circle()
                            .fill(accentBlue)
                            .frame(width: 16, height: 16)
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(isSelected ? accentBlue : Color(.systemGray5), lineWidth: isSelected ? 3 : 1.5)
            )
            .cornerRadius(28)
            .shadow(color: isSelected ? accentBlue.opacity(0.18) : .black.opacity(0.04), radius: 8, y: 3)
        }
        .buttonStyle(.plain)
    }

    private var quickTipCard: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.17, green: 0.41, blue: 0.96), Color(red: 0.12, green: 0.32, blue: 0.88)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 72, height: 72)

                Image(systemName: "exclamationmark.circle")
                    .font(.system(size: 30, weight: .medium))
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Quick Tip")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.16, green: 0.29, blue: 0.65))

                Text("You can track your queue position in real-time after check-in")
                    .font(.system(size: 16))
                    .foregroundColor(accentBlue)
                    .multilineTextAlignment(.leading)
            }

            Spacer(minLength: 0)
        }
        .padding(18)
        .background(Color(red: 0.92, green: 0.96, blue: 1.0))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color(red: 0.69, green: 0.82, blue: 1.0), lineWidth: 1.5)
        )
        .cornerRadius(22)
    }

    private var confirmButtonBar: some View {
        VStack(spacing: 12) {
            Button(action: confirmCheckIn) {
                Text("Confirm Check-In")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(actionBlue)
                    .cornerRadius(18)
                    .shadow(color: actionBlue.opacity(0.2), radius: 8, y: 3)
            }

            Text(confirmHintText)
                .font(.system(size: 13))
                .foregroundColor(mutedText)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 10)
        .background(Color(.systemGroupedBackground))
    }

    private var confirmHintText: String {
        switch selectedServiceID {
        case "general-opd":
            return "General OPD will continue to appointment booking."
        case "laboratory":
            return "Laboratory will open your lab queue and prescribed tests."
        case "pharmacy":
            return "Pharmacy will open your medication collection token."
        default:
            return ""
        }
    }

    private func confirmCheckIn() {
        switch selectedServiceID {
        case "general-opd":
            showBookAppointment = true
        case "laboratory":
            showLaboratoryQueue = true
        case "pharmacy":
            showPharmacyCheckIn = true
        default:
            break
        }
    }
}

#Preview {
    NavigationStack {
        CheckInView()
    }
}
