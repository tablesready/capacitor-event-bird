export interface CapacitorEventBirdPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  logout(): Promise<void>;
}
