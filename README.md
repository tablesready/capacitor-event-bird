# capacitor-event-bird

returns events back to native env

## Install

```bash
npm install capacitor-event-bird
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`notifyNativeReady()`](#notifynativeready)
* [`logout()`](#logout)
* [`addListener('authTokenReceived', ...)`](#addlistenerauthtokenreceived-)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### notifyNativeReady()

```typescript
notifyNativeReady() => Promise<void>
```

--------------------


### logout()

```typescript
logout() => Promise<void>
```

--------------------


### addListener('authTokenReceived', ...)

```typescript
addListener(eventName: 'authTokenReceived', listenerFunc: (data: AuthTokenReceivedData) => void) => Promise<{ remove: () => void; }>
```

| Param              | Type                                                                                       |
| ------------------ | ------------------------------------------------------------------------------------------ |
| **`eventName`**    | <code>'authTokenReceived'</code>                                                           |
| **`listenerFunc`** | <code>(data: <a href="#authtokenreceiveddata">AuthTokenReceivedData</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;{ remove: () =&gt; void; }&gt;</code>

--------------------


### Interfaces


#### AuthTokenReceivedData

| Prop        | Type                |
| ----------- | ------------------- |
| **`token`** | <code>string</code> |

</docgen-api>
