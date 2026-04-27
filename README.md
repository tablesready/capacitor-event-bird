# capacitor-event-bird

returns events back to native env

## Install

```bash
npm install capacitor-event-bird
npx cap sync
```

## API

<docgen-index>

* [`signupWithGoogle()`](#signupwithgoogle)
* [`waitlistAfterInit()`](#waitlistafterinit)
* [`openHelpModal()`](#openhelpmodal)
* [`getDeviceId()`](#getdeviceid)
* [`getFCMToken(...)`](#getfcmtoken)
* [`saveCredentials(...)`](#savecredentials)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### signupWithGoogle()

```typescript
signupWithGoogle() => Promise<{ displayName: string; email: string; firebaseToken: string; }>
```

**Returns:** <code>Promise&lt;{ displayName: string; email: string; firebaseToken: string; }&gt;</code>

--------------------


### waitlistAfterInit()

```typescript
waitlistAfterInit() => Promise<void>
```

--------------------


### openHelpModal()

```typescript
openHelpModal() => Promise<void>
```

--------------------


### getDeviceId()

```typescript
getDeviceId() => Promise<{ value: string; }>
```

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### getFCMToken(...)

```typescript
getFCMToken(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### saveCredentials(...)

```typescript
saveCredentials(options: { username: string; password: string; }) => Promise<{ isSuccess: boolean; }>
```

| Param         | Type                                                 |
| ------------- | ---------------------------------------------------- |
| **`options`** | <code>{ username: string; password: string; }</code> |

**Returns:** <code>Promise&lt;{ isSuccess: boolean; }&gt;</code>

--------------------

</docgen-api>
