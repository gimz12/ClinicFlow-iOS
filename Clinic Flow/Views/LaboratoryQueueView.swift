import SwiftUI

private struct LaboratoryTest: Identifiable {
    let id: String
    let title: String
    let fastingText: String
}

struct LaboratoryQueueView: View {
    @Environment(\.dismiss) private var dismiss
    var onCompleteVisit: (() -> Void)? = nil

    @State private var showDirections: Bool = false
    @State private var completedTests: Set<String> = []

    private let navy = Color(red: 0.10, green: 0.19, blue: 0.34)
    private let deepBlue = Color(red: 0.12, green: 0.32, blue: 0.48)
    private let purple = Color(red: 0.56, green: 0.13, blue: 0.95)
    private let mutedText = Color(red: 0.39, green: 0.47, blue: 0.60)

    private let tests: [LaboratoryTest] = [
        LaboratoryTest(id: "cbc", title: "Complete Blood Count (CBC)", fastingText: "Fasting: No"),
        LaboratoryTest(id: "glucose", title: "Blood Glucose Test", fastingText: "Fasting: Yes (8 hours)"),
        LaboratoryTest(id: "lipid", title: "Lipid Profile", fastingText: "Fasting: Yes (12 hours)")
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

                        queueCard

                        Text("PRESCRIBED TESTS")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(red: 0.42, green: 0.51, blue: 0.64))
                            .tracking(0.6)

                        VStack(spacing: 14) {
                            ForEach(tests) { test in
                                testCard(test)
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

            Text("Laboratory")
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
                .fill(Color(red: 0.58, green: 0.67, blue: 0.79))
                .frame(width: 12, height: 12)

            Text("PENDING")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(red: 0.33, green: 0.41, blue: 0.54))
                .tracking(0.6)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .overlay(
            Capsule()
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .clipShape(Capsule())
    }

    private var queueCard: some View {
        VStack(spacing: 18) {
            Text("LAB QUEUE NUMBER")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(red: 0.42, green: 0.51, blue: 0.64))
                .tracking(0.8)

            RoundedRectangle(cornerRadius: 22)
                .stroke(purple, lineWidth: 5)
                .frame(width: 150, height: 150)
                .overlay(
                    Text("L12")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(purple)
                )

            VStack(spacing: 6) {
                Text("Laboratory Tests")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(navy)

                Text("Counter B • 2nd Floor")
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

    private func testCard(_ test: LaboratoryTest) -> some View {
        let isCompleted = completedTests.contains(test.id)

        return Button {
            if isCompleted {
                completedTests.remove(test.id)
            } else {
                completedTests.insert(test.id)
            }
        } label: {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(test.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(navy)
                        .multilineTextAlignment(.leading)

                    Text(test.fastingText)
                        .font(.system(size: 14))
                        .foregroundColor(mutedText)
                }

                Spacer(minLength: 12)

                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(.systemGray4), lineWidth: 2)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Group {
                            if isCompleted {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(deepBlue)
                            }
                        }
                    )
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
        .buttonStyle(.plain)
    }

    private var statsRow: some View {
        HStack(spacing: 14) {
            statCard(title: "POSITION", value: "5")
            statCard(title: "WAIT TIME", value: "20 min")
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
                Text("Get Directions to Lab")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(deepBlue)
                    .cornerRadius(18)
                    .shadow(color: deepBlue.opacity(0.2), radius: 8, y: 3)
            }

            Button(action: markAllTestsCompleted) {
                Text("Mark Test Completed")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(deepBlue)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .padding(.bottom, 10)
        .background(Color(.systemGroupedBackground))
    }

    private func markAllTestsCompleted() {
        completedTests = Set(tests.map(\.id))
        dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            onCompleteVisit?()
        }
    }
}

#Preview {
    NavigationStack {
        LaboratoryQueueView()
    }
}
