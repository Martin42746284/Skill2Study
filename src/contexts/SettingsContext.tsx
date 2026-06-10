import { createContext, useContext, useState, ReactNode, useEffect } from "react";
import { admin, getCurrentUser } from "@/lib/api";

export interface AppSettings {
  id?: number;
  platform_name: string;
  platform_description: string;
  contact_email: string;
  email_notifications: boolean;
  moderation_alerts: boolean;
  weekly_reports: boolean;
  two_factor_auth: boolean;
  open_registration: boolean;
  email_verification: boolean;
  maintenance_mode: boolean;
}

interface SettingsContextType {
  settings: AppSettings;
  updateSettings: (newSettings: Partial<AppSettings>) => void;
  isLoading: boolean;
  refreshSettings: () => Promise<void>;
}

const defaultSettings: AppSettings = {
  platform_name: "Skill2Study",
  platform_description: "Plateforme intelligente d'aide à la décision pour l'orientation universitaire post-bac à Madagascar",
  contact_email: "contact@orientai.mg",
  email_notifications: false,
  moderation_alerts: false,
  weekly_reports: false,
  two_factor_auth: false,
  open_registration: false,
  email_verification: false,
  maintenance_mode: false,
};

const SettingsContext = createContext<SettingsContextType | undefined>(undefined);

export const SettingsProvider = ({ children }: { children: ReactNode }) => {
  const [settings, setSettings] = useState<AppSettings>(defaultSettings);
  const [isLoading, setIsLoading] = useState(true);

  // Load settings from backend on mount and set up auto-refresh
  useEffect(() => {
    loadSettingsFromBackend();

    // Set up polling to check for settings changes every 2 seconds
    const pollInterval = setInterval(() => {
      loadSettingsFromBackend();
    }, 2000);

    // Listen for storage changes (logout from another tab)
    const handleStorageChange = () => {
      loadSettingsFromBackend();
    };
    window.addEventListener('storage', handleStorageChange);

    return () => {
      clearInterval(pollInterval);
      window.removeEventListener('storage', handleStorageChange);
    };
  }, []);

  const loadSettingsFromBackend = async () => {
    try {
      const user = getCurrentUser();

      // Try to load from admin API if user is admin
      if (user?.role === "admin") {
        try {
          const response = await admin.getSettings() as any;
          const settingsData = response?.settings || response || defaultSettings;
          setSettings(settingsData);
          // Cache in localStorage for persistence
          localStorage.setItem('appSettings', JSON.stringify(settingsData));
          if (isLoading) setIsLoading(false);
          return;
        } catch (adminError) {
          console.debug("Error loading admin settings:", adminError);
        }
      }

      // For non-admin users or if admin call fails, try to load from localStorage first
      const cachedSettings = localStorage.getItem('appSettings');
      if (cachedSettings) {
        try {
          const settingsData = JSON.parse(cachedSettings);
          setSettings(settingsData);
          if (isLoading) setIsLoading(false);
          return;
        } catch (parseError) {
          console.debug("Error parsing cached settings:", parseError);
        }
      }

      // If no cached settings, use defaults
      setSettings(defaultSettings);
      localStorage.setItem('appSettings', JSON.stringify(defaultSettings));
      if (isLoading) setIsLoading(false);
    } catch (error) {
      console.debug("Error loading settings:", error);
      // Load from localStorage as fallback
      const cachedSettings = localStorage.getItem('appSettings');
      if (cachedSettings) {
        try {
          setSettings(JSON.parse(cachedSettings));
        } catch {
          setSettings(defaultSettings);
        }
      } else {
        setSettings(defaultSettings);
      }
      if (isLoading) setIsLoading(false);
    }
  };

  const updateSettings = (newSettings: Partial<AppSettings>) => {
    const updated = { ...settings, ...newSettings };
    setSettings(updated);
  };

  const refreshSettings = async () => {
    await loadSettingsFromBackend();
  };

  return (
    <SettingsContext.Provider value={{ settings, updateSettings, isLoading, refreshSettings }}>
      {children}
    </SettingsContext.Provider>
  );
};

export const useSettings = () => {
  const context = useContext(SettingsContext);
  if (context === undefined) {
    throw new Error("useSettings must be used within a SettingsProvider");
  }
  return context;
};
