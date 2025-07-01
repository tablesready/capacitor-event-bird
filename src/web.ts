import { WebPlugin } from '@capacitor/core';

import type { CapacitorEventBirdPlugin } from './definitions';

export class CapacitorEventBirdWeb extends WebPlugin implements CapacitorEventBirdPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async logout(): Promise<void> {
    console.log('logout in web isnt really needed it already works')
  }
}
