const { google } = require('googleapis');
const axios = require('axios');

const oauth2Client = new google.auth.OAuth2(
  process.env.GOOGLE_CLIENT_ID,
  process.env.GOOGLE_CLIENT_SECRET,
  process.env.GOOGLE_REDIRECT_URI
);

async function getTokensFromCode(code) {
  try {
    const { tokens } = await oauth2Client.getToken(code);
    return tokens;
  } catch (error) {
    console.error('Error exchanging code for tokens:', error.message);
    throw new Error('Invalid authorization code');
  }
}

async function getGoogleUserInfo(accessToken) {
  try {
    const response = await axios.get('https://www.googleapis.com/oauth2/v2/userinfo', {
      headers: { Authorization: `Bearer ${accessToken}` }
    });
    
    return {
      googleId: response.data.id,
      email: response.data.email,
      nom: response.data.family_name || '',
      prenom: response.data.given_name || '',
      avatar_url: response.data.picture || null
    };
  } catch (error) {
    console.error('Error fetching Google user info:', error.message);
    throw new Error('Failed to fetch Google user information');
  }
}

async function completeOAuthFlow(code) {
  const tokens = await getTokensFromCode(code);
  const userInfo = await getGoogleUserInfo(tokens.access_token);
  return userInfo;
}

function getAuthorizationUrl(state = '') {
  return oauth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: ['profile', 'email'],
    state
  });
}

module.exports = {
  getTokensFromCode,
  getGoogleUserInfo,
  completeOAuthFlow,
  getAuthorizationUrl
};
