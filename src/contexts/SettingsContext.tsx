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
  email_notifications: true,
  moderation_alerts: true,
  weekly_reports: false,
  two_factor_auth: false,
  open_registration: true,
  email_verification: true,
  maintenance_mode: false,
};

const SettingsContext = createContext<SettingsContextType | undefined>(undefined);

export const SettingsProvider = ({ children }: { children: ReactNode }) => {
  const [settings, setSettings] = useState<AppSettings>(defaultSettings);
  const [isLoading, setIsLoading] = useState(true);

  // Load settings from backend on mount and set up auto-refresh
  useEffect(() => {
    loadSettingsFromBackend();

    // Set up polling to check for settings changes every 5 seconds
    const pollInterval = setInterval(() => {
      loadSettingsFromBackend();
    }, 5000);

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
      // Only load admin settings if the user is an admin
      const user = getCurrentUser();
      if (user?.role === "admin") {
        try {
          const response = await admin.getSettings() as any;
          const settingsData = response?.settings || response || defaultSettings;
          setSettings(settingsData);
          if (isLoading) setIsLoading(false);
          return;
        } catch (adminError) {
          console.debug("Error loading admin settings:", adminError);
        }
      }

      // For non-admin users or if admin call fails, use default settings
      setSettings(defaultSettings);
      if (isLoading) setIsLoading(false);
    } catch (error) {
      console.debug("Error loading settings from backend:", error);
      // Fall back to default settings if backend call fails
      if (isLoading) {
        setSettings(defaultSettings);
        setIsLoading(false);
      }
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
