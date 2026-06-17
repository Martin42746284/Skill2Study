const { completeOAuthFlow, getAuthorizationUrl } = require('../services/oauth.service');
const User = require('../models/User.model');
const ProfilAcademique = require('../models/ProfilAcademique.model');
const { genererToken } = require('../utils/tokenUtils');

exports.getGoogleAuthUrl = (req, res) => {
  try {
    const state = req.query.state || Math.random().toString(36).substring(7);
    const authUrl = getAuthorizationUrl(state);
    res.json({ success: true, authorizationUrl: authUrl, state });
  } catch (error) {
    console.error('Error generating auth URL:', error.message);
    res.status(500).json({ success: false, message: 'Failed to generate authorization URL' });
  }
};

exports.googleCallback = async (req, res, next) => {
  try {
    const { code } = req.body;
    
    if (!code) {
      return res.status(400).json({ 
        success: false, 
        message: 'Authorization code is required' 
      });
    }

    const googleUserInfo = await completeOAuthFlow(code);

    // Check if user exists by google_id
    let user = await User.findOne({ where: { google_id: googleUserInfo.googleId } });

    if (!user) {
      // Check if email already exists
      user = await User.findOne({ where: { email: googleUserInfo.email } });
      
      if (user) {
        // Link Google account to existing user
        user.google_id = googleUserInfo.googleId;
        user.auth_provider = 'google';
        user.email_verified = true;
        if (!user.avatar_url && googleUserInfo.avatar_url) {
          user.avatar_url = googleUserInfo.avatar_url;
        }
        await user.save();
      } else {
        // Create new user - ALWAYS with role 'bachelier' for Google OAuth
        user = await User.create({
          nom: googleUserInfo.nom || '',
          prenom: googleUserInfo.prenom || '',
          email: googleUserInfo.email,
          google_id: googleUserInfo.googleId,
          auth_provider: 'google',
          email_verified: true,
          avatar_url: googleUserInfo.avatar_url,
          mot_de_passe: null,
          role: 'bachelier' // CONSTRAINT: Google users are always bacheliers
        });

        // Create academic profile for new user
        await ProfilAcademique.create({ 
          user_id: user.id, 
          serie_bac: '' 
        });
      }
    }

    const token = genererToken(user.id);
    
    // Check if user is new and needs profile completion
    const isNewUser = user.role === 'bachelier' && !user.serie_bac;

    res.json({
      success: true,
      token,
      user: user.toJSON(),
      isNewUser,
      message: isNewUser 
        ? 'Veuillez compléter votre profil académique.' 
        : 'Bienvenue!'
    });
  } catch (error) {
    console.error('Google callback error:', error.message);
    res.status(401).json({ 
      success: false, 
      message: error.message || 'Authentication failed'
    });
  }
};

exports.linkGoogleAccount = async (req, res, next) => {
  try {
    const { code } = req.body;
    const userId = req.user.id;

    if (!code) {
      return res.status(400).json({ 
        success: false, 
        message: 'Authorization code is required' 
      });
    }

    const googleUserInfo = await completeOAuthFlow(code);

    // Check if Google account is already linked
    const existingUser = await User.findOne({ 
      where: { google_id: googleUserInfo.googleId } 
    });

    if (existingUser && existingUser.id !== userId) {
      return res.status(409).json({ 
        success: false, 
        message: 'Google account is already linked to another user' 
      });
    }

    // Link Google account to current user
    const user = await User.findByPk(userId);
    user.google_id = googleUserInfo.googleId;
    user.auth_provider = 'google';
    if (!user.avatar_url && googleUserInfo.avatar_url) {
      user.avatar_url = googleUserInfo.avatar_url;
    }
    await user.save();

    res.json({ 
      success: true, 
      message: 'Google account linked successfully',
      user: user.toJSON()
    });
  } catch (error) {
    console.error('Link account error:', error.message);
    res.status(500).json({ 
      success: false, 
      message: error.message || 'Failed to link Google account'
    });
  }
};
