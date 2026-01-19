export interface CapacitorEventBirdPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  logout(): Promise<void>;
  signupWithGoogle(): Promise<void>;
  waitlistAfterInit(): Promise<void>;
  openHelpModal(): Promise<void>;
  getDeviceId(): Promise<{ value: string }>;
  getGoogleData(): Promise<{ displayName: string; email: string, firebaseToken: string }>;
  getFCMToken(options: { value: string }): Promise<{ value: string }>;
}
