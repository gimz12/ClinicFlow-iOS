import SwiftUI

struct AccessibilitySettingsView: View {
    @Environment(\.dismiss) private var dismiss

    @AppStorage("access_textSize") private var textSize: Double = 1
    @AppStorage("access_highContrast") private var highContrast: Bool = false
    @AppStorage("access_reduceMotion") private var reduceMotion: Bool = false
    @AppStorage("access_screenReaderHints") private var screenReaderHints: Bool = true
    @AppStorage("access_haptics") private var haptics: Bool = true

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)
    private let lightCard = Color(.systemBackground)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        infoCard

                        sectionTitle("Display")
                        displaySection

                        sectionTitle("Interaction")
                        interactionSection

                        sectionTitle("Audio")
                        audioSection
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 28)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private var header: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(navy)
            }

            Spacer()

            Text("Accessibility")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "circle")
                .font(.system(size: 10))
                .opacity(0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var infoCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(navy.opacity(0.12))
                    .frame(width: 52, height: 52)
                Image(systemName: "accessibility")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(navy)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Make Clinic Flow easier to use")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                Text("Adjust text size, contrast, and interaction preferences.")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var displaySection: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Text Size")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                    Spacer()
                    Text(textScaleLabel)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(navy)
                }

                Slider(value: $textSize, in: 0...2, step: 1)
                    .tint(navy)

                HStack {
                    Text("Small")
                    Spacer()
                    Text("Default")
                    Spacer()
                    Text("Large")
                }
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.secondary)
            }
            .padding(16)

            Divider().padding(.leading, 16)

            toggleRow(
                title: "High Contrast",
                subtitle: "Increase contrast for text and icons",
                isOn: $highContrast
            )
            .padding(16)
        }
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var interactionSection: some View {
        VStack(spacing: 0) {
            toggleRow(
                title: "Reduce Motion",
                subtitle: "Minimize animations and transitions",
                isOn: $reduceMotion
            )
            .padding(16)

            Divider().padding(.leading, 16)

            toggleRow(
                title: "Screen Reader Hints",
                subtitle: "Add spoken hints for buttons and fields",
                isOn: $screenReaderHints
            )
            .padding(16)
        }
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var audioSection: some View {
        VStack(spacing: 0) {
            toggleRow(
                title: "Haptics",
                subtitle: "Vibration feedback for actions",
                isOn: $haptics
            )
            .padding(16)

            Divider().padding(.leading, 16)

            settingsRow(title: "Voice Guidance", value: "English")
                .padding(16)
        }
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private func toggleRow(title: String, subtitle: String, isOn: Binding<Bool>) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }

            Spacer()

            Toggle("", isOn: isOn)
                .labelsHidden()
        }
    }

    private func settingsRow(title: String, value: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                Text("Customize spoken guidance")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }

            Spacer()

            HStack(spacing: 6) {
                Text(value)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(navy)
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
            }
        }
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text.uppercased())
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.secondary)
            .tracking(0.6)
            .padding(.horizontal, 2)
    }

    private var textScaleLabel: String {
        switch Int(textSize) {
        case 0: return "Small"
        case 2: return "Large"
        default: return "Default"
        }
    }
}

#Preview {
    NavigationStack {
        AccessibilitySettingsView()
    }
}
