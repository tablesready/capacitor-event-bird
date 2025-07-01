import { registerPlugin } from '@capacitor/core';

import type { CapacitorEventBirdPlugin } from './definitions';

const CapacitorEventBird = registerPlugin<CapacitorEventBirdPlugin>('CapacitorEventBird', {
  web: () => import('./web').then((m) => new m.CapacitorEventBirdWeb()),
});

export * from './definitions';
export { CapacitorEventBird };
