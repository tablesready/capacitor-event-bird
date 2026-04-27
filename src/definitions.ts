import { PluginListenerHandle } from '@capacitor/core';

export interface CapacitorEventBirdPlugin {
  signupWithGoogle(): Promise<{ displayName: string; email: string; firebaseToken: string }>;
  waitlistAfterInit(): Promise<void>;
  openHelpModal(): Promise<void>;
  getDeviceId(): Promise<{ value: string }>;
  getFCMToken(options: { value: string }): Promise<{ value: string }>;
  saveCredentials(options: { username: string; password: string }): Promise<{ isSuccess: boolean }>;
  addListener(
    eventName: 'fcmTokenRefreshed',
    listenerFunc: (data: { token: string }) => void,
  ): Promise<PluginListenerHandle>;
}
