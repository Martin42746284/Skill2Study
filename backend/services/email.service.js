const crypto = require('crypto');
const nodemailer = require('nodemailer');

/**
 * Initialiser le transport Nodemailer
 * Supporte Gmail, Outlook, SendGrid, ou n'importe quel SMTP
 */
const getEmailTransporter = () => {
  // Configuration pour Gmail (recommandé pour développement)
  if (process.env.EMAIL_SERVICE === 'gmail') {
    return nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASSWORD // Utiliser un mot de passe d'application
      }
    });
  }

  // Configuration SMTP générique
  return nodemailer.createTransport({
    host: process.env.EMAIL_HOST || 'localhost',
    port: process.env.EMAIL_PORT || 587,
    secure: process.env.EMAIL_SECURE === 'true', // true pour 465, false pour 587
    auth: process.env.EMAIL_USER ? {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASSWORD
    } : undefined
  });
};

/**
 * Génère un token de vérification unique
 */
const generateVerificationToken = () => {
  return crypto.randomBytes(32).toString('hex');
};

/**
 * Envoie un email de vérification
 */
const sendVerificationEmail = async (user, verificationToken) => {
  try {
    console.log(`[EMAIL] Email service: ${process.env.EMAIL_SERVICE || 'SMTP'}`);
    console.log(`[EMAIL] Email user: ${process.env.EMAIL_USER}`);

    const transporter = getEmailTransporter();

    const verificationLink = `${process.env.CLIENT_URL || 'http://localhost:8080'}/verify-email?token=${verificationToken}`;

    const mailOptions = {
      from: process.env.EMAIL_FROM || 'noreply@orientai.mg',               
      to: user.email,
      subject: 'Vérifiez votre adresse email - Skill2Study',
      html: `
        <h2>Bienvenue sur Skill2Study!</h2>
        <p>Merci de vous être inscrit(e). Pour compléter votre inscription, veuillez vérifier votre adresse email en cliquant sur le lien ci-dessous:</p>
        <p><a href="${verificationLink}" style="background-color: #3b82f6; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;">Vérifier mon email</a></p>
        <p>Ou copier ce lien: <a href="${verificationLink}">${verificationLink}</a></p>
        <p>Ce lien expire dans 24 heures.</p>
        <p>Si vous n'avez pas créé ce compte, veuillez ignorer cet email.</p>
      `
    };

    console.log(`[EMAIL] Attempting to send email to ${user.email}`);
    const info = await transporter.sendMail(mailOptions);
    console.log(`[EMAIL] ✓ Verification email sent to ${user.email}`);
    console.log(`[EMAIL] Message ID: ${info.messageId}`);
    console.log(`[EMAIL] Response: ${info.response}`);
    return true;
  } catch (error) {
    console.error(`[EMAIL] ✗ Error sending verification email:`, error);
    console.error(`[EMAIL] Error message: ${error.message}`);
    console.error(`[EMAIL] Error code: ${error.code}`);
    // En développement, afficher le token en console si l'email échoue
    console.log(`[EMAIL] ⚠️ FALLBACK - Verification token: ${verificationToken}`);
    console.log(`[EMAIL] ⚠️ FALLBACK - Verification link: ${process.env.CLIENT_URL || 'http://localhost:8080'}/verify-email?token=${verificationToken}`);
    return false;
  }
};

/**
 * Envoie un email de réinitialisation de mot de passe avec lien
 */
const sendPasswordResetEmail = async (user, resetToken) => {
  try {
    const transporter = getEmailTransporter();

    const resetLink = `${process.env.CLIENT_URL || 'http://localhost:8080'}/reset-password?token=${resetToken}`;

    const mailOptions = {
      from: process.env.EMAIL_FROM || 'noreply@orientai.mg',
      to: user.email,
      subject: 'Réinitialiser votre mot de passe - Skill2Study',
      html: `
        <h2>Réinitialisation de mot de passe</h2>
        <p>Bonjour ${user.prenom},</p>
        <p>Vous avez demandé une réinitialisation de mot de passe. Cliquez sur le lien ci-dessous pour réinitialiser votre mot de passe:</p>
        <p><a href="${resetLink}" style="background-color: #3b82f6; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;">Réinitialiser mon mot de passe</a></p>
        <p>Ou copier ce lien: <a href="${resetLink}">${resetLink}</a></p>
        <p>Ce lien expire dans 24 heures.</p>
        <p>Si vous n'avez pas demandé une réinitialisation, veuillez ignorer cet email.</p>
      `
    };

    console.log(`[EMAIL] Password reset email sent to ${user.email}`);
    const info = await transporter.sendMail(mailOptions);
    console.log(`[EMAIL] Message ID: ${info.messageId}`);
    return true;
  } catch (error) {
    console.error('Error sending password reset email:', error.message);
    // Fallback - afficher le token en console
    console.log(`[EMAIL FALLBACK] Reset token for ${user.email}: ${resetToken}`);
    console.log(`[EMAIL FALLBACK] Reset link: ${process.env.CLIENT_URL || 'http://localhost:8080'}/reset-password?token=${resetToken}`);
    return false;
  }
};

/**
 * Envoie un email de confirmation de mot de passe changé
 */
const sendPasswordChangeEmail = async (user) => {
  try {
    const transporter = getEmailTransporter();

    const mailOptions = {
      from: process.env.EMAIL_FROM || process.env.EMAIL_USER || 'noreply@orientai.mg',
      to: user.email,
      subject: 'Confirmation: Votre mot de passe a été changé - Skill2Study',
      html: `
        <h2>Votre mot de passe a été changé</h2>
        <p>Bonjour ${user.prenom},</p>
        <p>Nous vous confirmons que votre mot de passe a été modifié avec succès.</p>
        <p>Si vous n'avez pas effectué cette action, veuillez contacter le support immédiatement.</p>
      `
    };

    await transporter.sendMail(mailOptions);
    console.log(`[EMAIL] Password change confirmation sent to ${user.email}`);
    return true;
  } catch (error) {
    console.error('Error sending password change email:', error.message);
    return false;
  }
};

/**
 * Envoie un email de suppression de compte
 */
const sendAccountDeleteEmail = async (user) => {
  try {
    const transporter = getEmailTransporter();

    const mailOptions = {
      from: process.env.EMAIL_FROM || 'noreply@orientai.mg',
      to: user.email,
      subject: 'Confirmation: Votre compte a été supprimé - Skill2Study',
      html: `
        <h2>Votre compte a été supprimé</h2>
        <p>Bonjour ${user.prenom},</p>
        <p>Nous vous confirmons que votre compte Skill2Study a été supprimé définitivement.</p>
        <p>Vous ne pourrez plus accéder à aucune fonctionnalité de la plateforme.</p>
        <p>Si cette suppression a été faite par erreur, veuillez contacter le support.</p>
      `
    };

    await transporter.sendMail(mailOptions);
    console.log(`[EMAIL] Account deletion confirmation sent to ${user.email}`);
    return true;
  } catch (error) {
    console.error('Error sending account deletion email:', error.message);
    return false;
  }
};

module.exports = {
  generateVerificationToken,
  sendVerificationEmail,
  sendPasswordResetEmail,
  sendPasswordChangeEmail,
  sendAccountDeleteEmail,
};
