# Password Requirements

## Minimum Requirements

All passwords in Skill2Study must meet the following criteria:

### ✅ Mandatory Rules

1. **Minimum Length:** 6 characters
2. **Uppercase Letter:** At least 1 uppercase letter (A-Z)
3. **Lowercase Letter:** At least 1 lowercase letter (a-z)
4. **Digit:** At least 1 number (0-9)
5. **Special Character:** At least 1 special character from: `!@#$%^&*`

### Example Valid Passwords
- ✅ `MyPass123!`
- ✅ `SecureP@ssw0rd`
- ✅ `Test1234!`
- ✅ `Admin@123`

### Example Invalid Passwords
- ❌ `password` (no uppercase, no digit, no special char)
- ❌ `Pass123` (no special character)
- ❌ `Pass!` (too short, no digit)
- ❌ `PASS123!` (no lowercase)
- ❌ `pass123!` (no uppercase)

## Where This Applies

### Registration
- When creating a new account via `/api/auth/register`
- Users see error message in real-time as they type

### Password Reset
- When resetting forgotten password via `/api/auth/reset-password`
- Helps prevent weak password choices

### Password Change
- When authenticated users change their password via `/api/users/change-password`
- Ensures ongoing security

### Admin User Creation
- When admins create users via `/api/admin/users`
- Ensures all accounts meet security standards

## Frontend Integration

The frontend should:
1. Show password strength indicator
2. Display requirement checklist in real-time
3. Show which requirements are met/unmet
4. Only enable submit button when all requirements are met
5. Display server error message if validation fails

## Backend Implementation

### Files Modified
- `backend/utils/passwordValidator.js` - Core validation logic
- `backend/middlewares/validatePassword.middleware.js` - Express middleware
- `backend/controllers/auth.controller.js` - Registration, reset password
- `backend/controllers/settings.controller.js` - Password change
- `backend/controllers/admin.controller.js` - Admin user creation
- `backend/routes/auth.routes.js` - Auth route middleware
- `backend/routes/user.routes.js` - User route middleware

### Validation Function
```javascript
const { validatePassword } = require('../utils/passwordValidator');

const result = validatePassword('MyPass123!');
// Returns: { valid: true, message: 'Mot de passe valide.' }

const result = validatePassword('weak');
// Returns: { valid: false, message: 'Le mot de passe doit contenir au least une majuscule.' }
```

## Security Benefits

1. **Prevents Brute Force:** Complex passwords take longer to crack
2. **Reduces Dictionary Attacks:** Special chars & numbers limit dictionary matches
3. **Meets OWASP Standards:** Aligns with industry security guidelines
4. **Protects User Data:** Strong passwords protect against account compromise

## Testing

### Manual Testing Endpoints

```bash
# Test registration with weak password
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "nom": "Test",
    "prenom": "User",
    "email": "test@example.com",
    "mot_de_passe": "weak"
  }'

# Expected error:
# "Le mot de passe doit contenir au moins une majuscule."

# Test with valid password
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "nom": "Test",
    "prenom": "User",
    "email": "test@example.com",
    "mot_de_passe": "MyPass123!"
  }'

# Expected success:
# {"success": true, "token": "...", "user": {...}}
```

---
**Status:** ✅ Implemented
**Version:** 1.0
**Last Updated:** 2026-06-17
