import SwiftUI

struct AppointmentLoginView: View {
    @State private var appointmentNumber: String = ""
    @State private var navigateToOTP: Bool = false
    @State private var navigateToSignUp: Bool = false
    @State private var navigateToPatientIDLogin: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    private let primaryColor = Color(red: 0.13, green: 0.27, blue: 0.40)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome Back")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("Sign in to continue your visit")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 32)
                .padding(.bottom, 32)
                
                // Appointment Number Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("APPOINTMENT NUMBER")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primary)
                        .tracking(0.5)
                    
                    TextField("Enter your appointment number", text: $appointmentNumber)
                        .textFieldStyle(.plain)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .autocapitalization(.none)
                    
                    Text("We'll send a verification code to your registered phone number")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
                .padding(.bottom, 28)
                
                // Continue Button
                Button {
                    if !appointmentNumber.isEmpty {
                        navigateToOTP = true
                    }
                } label: {
                    Text("Continue")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(!appointmentNumber.isEmpty ? primaryColor : primaryColor.opacity(0.5))
                        .cornerRadius(14)
                }
                .disabled(appointmentNumber.isEmpty)
                .padding(.bottom, 24)
                
                // OR Divider
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.systemGray4))
                    Text("OR")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 12)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.systemGray4))
                }
                .padding(.bottom, 24)
                
                // Sign in Using Patient ID Button
                Button {
                    dismiss()
                } label: {
                    Text("Sign in Using Patient ID")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.white)
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                .padding(.bottom, 32)
                
                // Footer Links
                VStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .foregroundColor(.secondary)
                        Button("Sign Up") {
                            navigateToSignUp = true
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(primaryColor)
                    }
                    .font(.system(size: 15))
                    
                    HStack(spacing: 4) {
                        Text("Need assistance?")
                            .foregroundColor(.secondary)
                        Button("Contact reception") {
                            // Handle contact
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(primaryColor)
                    }
                    .font(.system(size: 15))
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 24)
        }
        .navigationTitle("Sign In")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToOTP) {
            OTPVerifyView(phoneNumber: "+1 (555) 123-4567")
        }
        .navigationDestination(isPresented: $navigateToSignUp) {
            SignUpView()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(primaryColor)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppointmentLoginView()
    }
}
