import SwiftUI

struct GlassBackButtonLabel: View {
    let tint: Color

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "chevron.left")
            Text("Back")
        }
        .font(.system(size: 17, weight: .semibold))
        .foregroundColor(tint)
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial, in: Capsule())
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.7), lineWidth: 1)
        )
    }
}

struct GlassIconButtonLabel: View {
    let systemName: String
    let tint: Color

    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(tint)
            .frame(width: 44, height: 44)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
            )
    }
}
