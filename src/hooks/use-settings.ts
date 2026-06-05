import { createContext, useContext, useState, useEffect } from "react";
import type { ReactNode } from "react";

interface AppSettings {
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

  // Load settings from localStorage on mount
  useEffect(() => {
    const savedSettings = localStorage.getItem("orientai_settings");
    if (savedSettings) {
      try {
        setSettings(JSON.parse(savedSettings));
      } catch (error) {
        console.error("Error loading settings:", error);
      }
    }
    setIsLoading(false);
  }, []);

  const updateSettings = (newSettings: Partial<AppSettings>) => {
    const updated = { ...settings, ...newSettings };
    setSettings(updated);
    // Save to localStorage for persistence
    localStorage.setItem("orientai_settings", JSON.stringify(updated));
  };

  return (
    <SettingsContext.Provider value={{ settings, updateSettings, isLoading }}>
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