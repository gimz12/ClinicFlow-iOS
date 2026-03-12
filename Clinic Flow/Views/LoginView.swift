import SwiftUI

struct LoginView: View {
    @State private var patientID: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var showPassword: Bool = false
    @State private var navigateToSignUp: Bool = false
    @State private var navigateToAppointmentLogin: Bool = false
    @State private var navigateToDashboard: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    private let primaryColor = Color(red: 0.13, green: 0.27, blue: 0.40)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Logo Icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(primaryColor)
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 28, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 24)
                    
                    // Header
                    VStack(spacing: 8) {
                        Text("Welcome Back")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("Sign in to access your account")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 32)
                    
                    // Form Fields
                    VStack(alignment: .leading, spacing: 20) {
                        // Patient ID Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("PATIENT ID")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.primary)
                                .tracking(0.5)
                            
                            TextField("Enter your patient ID", text: $patientID)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .autocapitalization(.none)
                        }
                        
                        // Password Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("PASSWORD")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.primary)
                                .tracking(0.5)
                            
                            HStack {
                                if showPassword {
                                    TextField("Enter your password", text: $password)
                                } else {
                                    SecureField("Enter your password", text: $password)
                                }
                                
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(systemName: showPassword ? "eye.slash" : "eye")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .textFieldStyle(.plain)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        // Remember Me & Forgot Password Row
                        HStack {
                            Button {
                                rememberMe.toggle()
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                        .foregroundColor(rememberMe ? primaryColor : .secondary)
                                    Text("Remember me")
                                        .foregroundColor(.secondary)
                                }
                                .font(.system(size: 14))
                            }
                            
                            Spacer()
                            
                            Button("Forgot Password?") {
                                // Handle forgot password
                            }
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(primaryColor)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    
                    // Sign In Button
                    Button {
                        handleSignIn()
                    } label: {
                        Text("Sign In")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(primaryColor)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 24)
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
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    
                    // Sign in Using Appointment Number Button
                    Button {
                        navigateToAppointmentLogin = true
                    } label: {
                        Text("Sign in using Appointment Number")
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
                    .padding(.horizontal, 24)
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
                    .padding(.bottom, 32)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToSignUp) {
                SignUpView()
            }
            .navigationDestination(isPresented: $navigateToDashboard) {
                DashboardView()
            }
            .navigationDestination(isPresented: $navigateToAppointmentLogin) {
                AppointmentLoginView()
            }
        }
    }
    
    private func handleSignIn() {
        // Handle sign in logic
        if !patientID.isEmpty && !password.isEmpty {
            navigateToDashboard = true
        }
    }
}

#Preview {
    LoginView()
}
