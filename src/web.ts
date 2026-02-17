import { WebPlugin } from '@capacitor/core';

import type { CapacitorEventBirdPlugin } from './definitions';

export class CapacitorEventBirdWeb extends WebPlugin implements CapacitorEventBirdPlugin {
  async getFCMToken(options: { value: string }): Promise<{ value: string }> {
    console.log('getFCMToken', options);
    return options;
  }

  async signupWithGoogle(): Promise<{ displayName: string; email: string, firebaseToken: string }> {
    console.log('signupWithGoogle in web isnt really needed it already works');
    return {
      displayName: '',
      email: '',
      firebaseToken: '',
    };
  }

  async openHelpModal(): Promise<void> {
    console.log('openHelpModal in web isnt really needed it already works');
  }

  async waitlistAfterInit(): Promise<void> {
    console.log('waitlistAfterInit in web isnt really needed it already works');
  }

  async getDeviceId(): Promise<{ value: string }> {
    return { value: 'ios device id is not needed for web' };
  }
}
