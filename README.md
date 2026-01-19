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
* [`logout()`](#logout)
* [`signupWithGoogle()`](#signupwithgoogle)
* [`waitlistAfterInit()`](#waitlistafterinit)
* [`openHelpModal()`](#openhelpmodal)
* [`getDeviceId()`](#getdeviceid)
* [`getGoogleData()`](#getgoogledata)
* [`getFCMToken(...)`](#getfcmtoken)

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


### logout()

```typescript
logout() => Promise<void>
```

--------------------


### signupWithGoogle()

```typescript
signupWithGoogle() => Promise<void>
```

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


### getGoogleData()

```typescript
getGoogleData() => Promise<{ displayName: string; email: string; firebaseToken: string; }>
```

**Returns:** <code>Promise&lt;{ displayName: string; email: string; firebaseToken: string; }&gt;</code>

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

</docgen-api>
