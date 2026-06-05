const jwt = require('jsonwebtoken');
const { User, ProfilAcademique, Settings } = require('../models');
const { generateVerificationToken, sendVerificationEmail } = require('../services/email.service');

const genererToken = (id) => jwt.sign({ id }, process.env.JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES_IN || '7d' });

// POST /api/auth/register
exports.inscrire = async (req, res, next) => {
  try {
    const { nom, prenom, email, mot_de_passe, serie_bac } = req.body;
    const existant = await User.findOne({ where: { email } });
    if (existant) return res.status(409).json({ success: false, message: 'Email déjà utilisé.' });

    // Create user
    const user = await User.create({ nom, prenom, email, mot_de_passe, serie_bac });
    await ProfilAcademique.create({ user_id: user.id, serie_bac: serie_bac || '' });

    // Check if email verification is required
    const settings = await Settings.findOne();
    const requireEmailVerification = settings?.email_verification || false;

    console.log(`[AUTH] Email verification required: ${requireEmailVerification}`);

    if (requireEmailVerification) {
      // Generate email verification token
      const { generateVerificationToken, sendVerificationEmail } = require('../services/email.service');
      const emailToken = generateVerificationToken();
      user.email_verification_token = emailToken;
      user.email_verification_token_expires = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 heures
      await user.save();

      console.log(`[AUTH] Generated email verification token for ${email}: ${emailToken.substring(0, 10)}...`);
      console.log(`[AUTH] Token saved to database`);

      // Send verification email
      await sendVerificationEmail(user, emailToken);
      console.log(`[AUTH] Verification email sent to ${email}`);
    }

    const token = genererToken(user.id);
    res.status(201).json({
      success: true,
      token,
      user: user.toJSON(),
      emailVerificationRequired: requireEmailVerification
    });
  } catch (err) { next(err); }
};

// POST /api/auth/login
exports.connexion = async (req, res, next) => {
  try {
    const { email, mot_de_passe } = req.body;
    const user = await User.findOne({ where: { email } });
    if (!user || !(await user.verifierMotDePasse(mot_de_passe))) {
      return res.status(401).json({ success: false, message: 'Email ou mot de passe incorrect.' });
    }
    if (!user.actif) return res.status(403).json({ success: false, message: 'Compte désactivé.' });

    // Check if email verification is required and user hasn't verified
    const settings = await Settings.findOne();
    if (settings?.email_verification && !user.email_verified) {
      console.log(`[AUTH] User ${email} tried to login without verifying email`);
      return res.status(403).json({
        success: false,
        message: 'Veuillez vérifier votre email avant de vous connecter.',
        emailVerificationRequired: true
      });
    }

    const token = genererToken(user.id);
    res.json({ success: true, token, user: user.toJSON() });
  } catch (err) { next(err); }
};

// GET /api/auth/me
exports.moi = async (req, res) => {
  const user = await User.findByPk(req.user.id, { include: [{ association: 'profil' }] });
  res.json({ success: true, user });
};

// POST /api/auth/verify-email
exports.verifierEmail = async (req, res, next) => {
  try {
    console.log(`[AUTH] POST /auth/verify-email received`);
    console.log(`[AUTH] Request body:`, req.body);

    const { token } = req.body;
    if (!token) {
      console.log(`[AUTH] No token provided`);
      return res.status(400).json({ success: false, message: 'Token de vérification requis.' });
    }

    console.log(`[AUTH] Verifying email with token: ${token.substring(0, 10)}...`);

    const user = await User.findOne({
      where: { email_verification_token: token },
    });

    if (!user) {
      console.log(`[AUTH] User not found for email_verification_token: ${token.substring(0, 10)}...`);
      console.log(`[AUTH] Searching for ANY user with this token...`);
      // Debug: show all users with any verification token
      const allUsers = await User.findAll({
        attributes: ['id', 'email', 'email_verification_token', 'email_verification_token_expires']
      });
      console.log(`[AUTH] Users in database:`, allUsers.map(u => ({
        email: u.email,
        hasToken: !!u.email_verification_token
      })));
      return res.status(404).json({ success: false, message: 'Token invalide ou expiré.' });
    }

    console.log(`[AUTH] User found: ${user.email}, checking expiration...`);
    console.log(`[AUTH] Token expires at: ${user.email_verification_token_expires}`);
    console.log(`[AUTH] Current time: ${new Date()}`);

    // Check if token has expired
    if (user.email_verification_token_expires < new Date()) {
      console.log(`[AUTH] Token expired for ${user.email}`);
      return res.status(400).json({ success: false, message: 'Token expiré.' });
    }

    // Mark email as verified
    user.email_verified = true;
    user.email_verification_token = null;
    user.email_verification_token_expires = null;
    await user.save();

    console.log(`[AUTH] Email verified successfully for ${user.email}`);
    res.json({ success: true, message: 'Email vérifié avec succès.' });
  } catch (err) { next(err); }
};

// POST /api/auth/forgot-password - Demander une réinitialisation
exports.forgotPassword = async (req, res, next) => {
  try {
    const { email } = req.body;
    const user = await User.findOne({ where: { email } });
    if (!user) {
      // Pour la sécurité, ne pas révéler si l'email existe
      return res.status(404).json({ success: false, message: 'Aucun compte associé à cet email.' });
    }

    // Générer un token unique pour la réinitialisation de mot de passe
    const { generateVerificationToken } = require('../services/email.service');
    const resetToken = generateVerificationToken();
    user.password_reset_token = resetToken;
    user.password_reset_token_expires = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 heures
    await user.save();

    console.log(`[AUTH] Generated password reset token for ${email}: ${resetToken.substring(0, 10)}...`);

    // Envoyer l'email avec le lien
    const { sendPasswordResetEmail } = require('../services/email.service');
    await sendPasswordResetEmail(user, resetToken);

    res.json({ success: true, message: 'Un email de réinitialisation a été envoyé.' });
  } catch (err) { next(err); }
};

// POST /api/auth/reset-password - Réinitialiser le mot de passe
exports.resetPassword = async (req, res, next) => {
  try {
    const { token, nouveau_mot_de_passe } = req.body;

    const user = await User.findOne({ where: { password_reset_token: token } });
    if (!user) {
      console.log(`[AUTH] Password reset token not found: ${token.substring(0, 10)}...`);
      return res.status(400).json({ success: false, message: 'Token invalide.' });
    }

    // Vérifier l'expiration
    if (user.password_reset_token_expires < new Date()) {
      console.log(`[AUTH] Password reset token expired for ${user.email}`);
      return res.status(400).json({ success: false, message: 'Token expiré.' });
    }

    // Mettre à jour le mot de passe
    user.mot_de_passe = nouveau_mot_de_passe;
    user.password_reset_token = null;
    user.password_reset_token_expires = null;
    await user.save();

    console.log(`[AUTH] Password reset successfully for ${user.email}`);
    res.json({ success: true, message: 'Mot de passe réinitialisé avec succès.' });
  } catch (err) { next(err); }
};

// POST /api/auth/mot-de-passe/reinitialiser (legacy)
exports.reinitialiserMotDePasse = async (req, res, next) => {
  try {
    const { email, nouveau_mot_de_passe } = req.body;
    const user = await User.findOne({ where: { email } });
    if (!user) return res.status(404).json({ success: false, message: 'Aucun compte associé à cet email.' });
    user.mot_de_passe = nouveau_mot_de_passe;
    await user.save();
    res.json({ success: true, message: 'Mot de passe réinitialisé avec succès.' });
  } catch (err) { next(err); }
};
