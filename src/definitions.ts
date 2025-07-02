export interface AuthTokenReceivedData {
  token: string;
}

export interface CapacitorEventBirdPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  logout(): Promise<void>;
  addListener(
    eventName: 'authTokenReceived',
    listenerFunc: (data: AuthTokenReceivedData) => void
  ): Promise<{ remove: () => void }>;
}
