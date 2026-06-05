import { useTranslation } from 'react-i18next';
import { useEffect, useState } from 'react';

export function useI18n() {
  const { t, i18n } = useTranslation();
  const [, setLanguageChanged] = useState(0);

  useEffect(() => {
    const handleLanguageChanged = () => {
      setLanguageChanged(prev => prev + 1);
    };

    i18n.on('languageChanged', handleLanguageChanged);
    return () => {
      i18n.off('languageChanged', handleLanguageChanged);
    };
  }, [i18n]);

  const currentLanguage = i18n.language || 'en';
  const isRTL = false;

  const changeLanguage = (lng: string) => {
    // Change language in i18n
    i18n.changeLanguage(lng);
    // Also persist to localStorage so it persists across page reloads
    localStorage.setItem('i18nextLng', lng);
  };

  return {
    t,
    currentLanguage,
    changeLanguage,
    isRTL,
    languages: ['en', 'fr'],
  };
}
