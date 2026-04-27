import { PluginListenerHandle } from '@capacitor/core';

export interface CapacitorEventBirdPlugin {
  signupWithGoogle(): Promise<{ displayName: string; email: string; firebaseToken: string }>;
  waitlistAfterInit(): Promise<void>;
  openHelpModal(): Promise<void>;
  getDeviceId(): Promise<{ value: string }>;
  getFCMToken(options: { value: string }): Promise<{ value: string }>;
  saveCredentials(options: { username: string; password: string }): Promise<{ isSuccess: boolean }>;
  getFontScale(): Promise<{ scale: number; category: string }>;
  addListener(
    eventName: 'fcmTokenRefreshed',
    listenerFunc: (data: { token: string }) => void,
  ): Promise<PluginListenerHandle>;
  addListener(
    eventName: 'fontScaleChanged',
    listenerFunc: (data: { scale: number; category: string }) => void,
  ): Promise<PluginListenerHandle>;
}
