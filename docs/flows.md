# Application Flows

## Send Transaction Flow

1. User inputs address and amount
2. Validation
3. Build preview (gas + fee)
4. Confirm dialog
5. Send transaction
6. Store locally
7. Track receipt

## Auto Refresh Flow

Timer (Home)
→ invalidate providers
→ UI rebuild

## Lifecycle Flow

App background
→ lock()
→ redirect to LockScreen
→ unlock()
→ restart refresh
