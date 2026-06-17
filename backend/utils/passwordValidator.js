/**
 * Validate password strength
 * Requirements:
 * - Minimum 6 characters
 * - At least one uppercase letter
 * - At least one lowercase letter
 * - At least one digit
 * - At least one special character (!@#$%^&*)
 */

const PASSWORD_REGEX = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])(?=.{6,})/;

function validatePassword(password) {
  if (!password || typeof password !== 'string') {
    return {
      valid: false,
      message: 'Le mot de passe est requis.'
    };
  }

  if (password.length < 6) {
    return {
      valid: false,
      message: 'Le mot de passe doit contenir au moins 6 caractères.'
    };
  }

  if (!/[A-Z]/.test(password)) {
    return {
      valid: false,
      message: 'Le mot de passe doit contenir au moins une majuscule.'
    };
  }

  if (!/[a-z]/.test(password)) {
    return {
      valid: false,
      message: 'Le mot de passe doit contenir au moins une minuscule.'
    };
  }

  if (!/\d/.test(password)) {
    return {
      valid: false,
      message: 'Le mot de passe doit contenir au moins un chiffre.'
    };
  }

  if (!/[!@#$%^&*]/.test(password)) {
    return {
      valid: false,
      message: 'Le mot de passe doit contenir au moins un caractère spécial (!@#$%^&*).'
    };
  }

  return {
    valid: true,
    message: 'Mot de passe valide.'
  };
}

module.exports = { validatePassword, PASSWORD_REGEX };
