import { useEffect, useState } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { Loader2 } from 'lucide-react';
import { setAuthToken, getRedirectPathByRole } from '@/lib/api';

export default function GoogleAuthCallback() {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const handleGoogleCallback = async () => {
      try {
        const code = searchParams.get('code');
        const state = searchParams.get('state');

        if (!code) {
          setError(t('auth.googleAuth.noCode') || 'Authorization code not found');
          setIsLoading(false);
          return;
        }

        // Verify state matches
        const savedState = sessionStorage.getItem('oauth_state');
        if (state !== savedState) {
          setError(t('auth.googleAuth.invalidState') || 'Invalid state parameter');
          setIsLoading(false);
          return;
        }

        const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';
        const response = await fetch(`${apiUrl}/oauth/google/callback`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ code })
        });

        const data = await response.json();

        if (!data.success) {
          setError(data.message || t('auth.googleAuth.error') || 'Authentication failed');
          setIsLoading(false);
          return;
        }

        // Store auth token and user
        setAuthToken(data.token, data.user);

        // Redirect based on user role and profile completion
        if (data.user?.role === 'admin') {
          navigate('/admin');
        } else if (data.isNewUser) {
          navigate('/dashboard/profile', { state: { message: data.message } });
        } else {
          navigate('/dashboard');
        }
      } catch (err: any) {
        console.error('Google callback error:', err);
        setError(err.message || t('auth.googleAuth.error') || 'Authentication failed');
        setIsLoading(false);
      }
    };

    handleGoogleCallback();
  }, [searchParams, navigate, t]);

  if (error) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">
            {t('auth.googleAuth.error') || 'Authentication Error'}
          </h1>
          <p className="text-gray-600 mb-6">{error}</p>
          <a
            href="/login"
            className="inline-block px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
          >
            {t('common.backToLogin') || 'Back to Login'}
          </a>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50">
      <div className="text-center">
        <Loader2 className="w-8 h-8 animate-spin text-blue-600 mx-auto mb-4" />
        <p className="text-gray-600">
          {t('auth.googleAuth.processing') || 'Processing authentication...'}
        </p>
      </div>
    </div>
  );
}
