export interface CapacitorEventBirdPlugin {
  signupWithGoogle(): Promise<{ displayName: string; email: string; firebaseToken: string }>;
  waitlistAfterInit(): Promise<void>;
  openHelpModal(): Promise<void>;
  getDeviceId(): Promise<{ value: string }>;
  getFCMToken(options: { value: string }): Promise<{ value: string }>;
  saveCredentials(options: { username: string; password: string }): Promise<{ isSuccess: boolean }>;
}
