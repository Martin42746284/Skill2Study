import DashboardLayout from "@/components/DashboardLayout";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Separator } from "@/components/ui/separator";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Settings as SettingsIcon,
  Bell,
  Shield,
  Palette,
  Globe,
  Lock,
  Save,
  Trash2,
  Loader2,
  AlertCircle,
} from "lucide-react";
import { useState, useEffect, useCallback } from "react";
import { useToast } from "@/hooks/use-toast";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";
import { users as usersApi, auth } from "@/lib/api";
import { useTheme } from "@/hooks/use-theme";
import { useI18n } from "@/hooks/use-i18n";

interface UserSettings {
  id: number;
  email_notifications: boolean;
  new_university_notifications: boolean;
  test_updates_notifications: boolean;
  recommendations_notifications: boolean;
  theme: 'light' | 'dark' | 'system';
  language: string;
  profile_visibility: 'public' | 'private';
}

const Settings = () => {
  const { toast } = useToast();
  const { t, i18n } = useTranslation();
  const navigate = useNavigate();
  const { setTheme } = useTheme();
  const { changeLanguage } = useI18n();
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);
  const [deletePassword, setDeletePassword] = useState("");
  const [languageChanged, setLanguageChanged] = useState(0);
  const [passwordData, setPasswordData] = useState({
    current_password: "",
    new_password: "",
    confirm_password: "",
  });

  const [settings, setSettings] = useState<UserSettings>({
    id: 0,
    email_notifications: true,
    new_university_notifications: true,
    test_updates_notifications: true,
    recommendations_notifications: true,
    theme: 'system',
    language: 'fr',
    profile_visibility: 'private'
  });

  useEffect(() => {
    const loadSettings = async () => {
      try {
        setLoading(true);
        const response = await usersApi.getSettings() as any;
        setSettings(response);
        setError(null);
      } catch (err) {
        const message = err instanceof Error ? err.message : t("settings.errorLoading");
        setError(message);
        toast({
          title: t("common.error"),
          description: message,
          variant: "destructive",
        });
      } finally {
        setLoading(false);
      }
    };

    loadSettings();
  }, [toast, t]);

  // Keep language in sync with i18n
  useEffect(() => {
    setSettings(prev => ({ ...prev, language: i18n.language }));
  }, [i18n.language]);

  // Listen for i18n language changes and force component re-render
  useEffect(() => {
    const handleLanguageChanged = () => {
      console.log('Language changed event detected, current language:', i18n.language);
      setLanguageChanged(prev => prev + 1);
    };

    i18n.on('languageChanged', handleLanguageChanged);
    return () => {
      i18n.off('languageChanged', handleLanguageChanged);
    };
  }, [i18n]);

  const handleSettingChange = (key: keyof UserSettings, value: any) => {
    setSettings((prev) => ({ ...prev, [key]: value }));

    // Apply theme and language changes immediately
    if (key === 'theme') {
      setTheme(value);
    } else if (key === 'language') {
      changeLanguage(value);
      // Force component re-render by triggering state update
      setLanguageChanged(prev => prev + 1);
    }
  };

  const handleSave = async () => {
    try {
      setSaving(true);
      await usersApi.updateSettings({
        email_notifications: settings.email_notifications,
        new_university_notifications: settings.new_university_notifications,
        test_updates_notifications: settings.test_updates_notifications,
        recommendations_notifications: settings.recommendations_notifications,
        theme: settings.theme,
        language: settings.language,
        profile_visibility: settings.profile_visibility,
      });

      // Apply theme and language changes immediately
      setTheme(settings.theme);
      changeLanguage(settings.language);
      setLanguageChanged(prev => prev + 1);

      toast({
        title: t("settings.saved"),
        description: t("admin.pages.settings.settingsSavedDesc"),
      });
    } catch (err) {
      const message = err instanceof Error ? err.message : t("common.error");
      toast({
        title: t("common.error"),
        description: message,
        variant: "destructive",
      });
    } finally {
      setSaving(false);
    }
  };

  const handleChangePassword = async () => {
    if (!passwordData.current_password || !passwordData.new_password || !passwordData.confirm_password) {
      toast({
        title: t("common.error"),
        description: "Tous les champs sont obligatoires",
        variant: "destructive",
      });
      return;
    }

    if (passwordData.new_password !== passwordData.confirm_password) {
      toast({
        title: t("common.error"),
        description: "Les mots de passe ne correspondent pas",
        variant: "destructive",
      });
      return;
    }

    try {
      setSaving(true);
      await usersApi.changePassword(passwordData);
      toast({
        title: "Succès",
        description: "Votre mot de passe a été changé avec succès",
      });
      setPasswordData({ current_password: "", new_password: "", confirm_password: "" });
    } catch (err) {
      const message = err instanceof Error ? err.message : t("common.error");
      toast({
        title: t("common.error"),
        description: message,
        variant: "destructive",
      });
    } finally {
      setSaving(false);
    }
  };

  const handleDeleteAccount = async () => {
    if (!deletePassword) {
      toast({
        title: t("common.error"),
        description: "Le mot de passe est requis",
        variant: "destructive",
      });
      return;
    }

    try {
      setSaving(true);
      await usersApi.deleteAccount(deletePassword);
      toast({
        title: "Compte supprimé",
        description: "Votre compte a été supprimé avec succès",
      });
      // Logout and redirect
      auth.logout();
      setTimeout(() => {
        navigate("/login");
      }, 1000);
    } catch (err) {
      const message = err instanceof Error ? err.message : t("common.error");
      toast({
        title: t("common.error"),
        description: message,
        variant: "destructive",
      });
    } finally {
      setSaving(false);
      setShowDeleteDialog(false);
      setDeletePassword("");
    }
  };

  if (loading) {
    return (
      <DashboardLayout>
        <div className="flex items-center justify-center py-20">
          <div className="text-center">
            <Loader2 className="h-8 w-8 animate-spin mx-auto mb-3 text-primary" />
            <p className="text-muted-foreground">{t("common.loading")}</p>
          </div>
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout>
      <div className="animate-fade-in h-full flex flex-col px-4 sm:px-6 lg:px-8 py-6 overflow-hidden">
        <div className="mb-6 shrink-0">
          <h1 className="text-3xl font-bold flex items-center gap-2">
            <SettingsIcon className="h-7 w-7 text-primary" />
            {t("settings.title")}
          </h1>
          <p className="mt-1 text-muted-foreground">
            {t("dashboard.sidebar.settings")}
          </p>
        </div>

        {error && (
          <div className="rounded-xl border border-destructive/50 bg-destructive/5 p-4 flex items-start gap-3 mb-6 shrink-0">
            <AlertCircle className="h-5 w-5 text-destructive flex-shrink-0 mt-0.5" />
            <div>
              <p className="font-semibold text-destructive">{t("common.error")}</p>
              <p className="text-sm text-destructive/80">{error}</p>
            </div>
          </div>
        )}

        <div className="flex-1 overflow-y-auto pr-2 space-y-6">
          {/* Notifications */}
          <section className="rounded-xl border bg-card p-6 shadow-card">
            <h2 className="text-lg font-semibold flex items-center gap-2 mb-4">
              <Bell className="h-5 w-5 text-primary" />
              {t("settings.notifications")}
            </h2>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium">{t("settings.emailNotifications")}</p>
                  <p className="text-xs text-muted-foreground">
                    {t("admin.pages.settings.emailNotificationsDesc")}
                  </p>
                </div>
                <Switch
                  checked={settings.email_notifications}
                  onCheckedChange={(checked) => handleSettingChange('email_notifications', checked)}
                />
              </div>
              <Separator />
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium">{t("notifications.newUniversity")}</p>
                  <p className="text-xs text-muted-foreground">
                    {t("admin.pages.settings.emailNotificationsDesc")}
                  </p>
                </div>
                <Switch
                  checked={settings.new_university_notifications}
                  onCheckedChange={(checked) => handleSettingChange('new_university_notifications', checked)}
                />
              </div>
              <Separator />
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium">{t("orientationTest.testInProgress")}</p>
                  <p className="text-xs text-muted-foreground">
                    {t("orientationTest.selectAnswer")}
                  </p>
                </div>
                <Switch
                  checked={settings.test_updates_notifications}
                  onCheckedChange={(checked) => handleSettingChange('test_updates_notifications', checked)}
                />
              </div>
              <Separator />
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium">Recommandations</p>
                  <p className="text-xs text-muted-foreground">
                    Recevoir des notifications sur les recommandations
                  </p>
                </div>
                <Switch
                  checked={settings.recommendations_notifications}
                  onCheckedChange={(checked) => handleSettingChange('recommendations_notifications', checked)}
                />
              </div>
            </div>
          </section>

          {/* Apparence */}
          <section className="rounded-xl border bg-card p-6 shadow-card">
            <h2 className="text-lg font-semibold flex items-center gap-2 mb-4">
              <Palette className="h-5 w-5 text-primary" />
              {t("settings.general")}
            </h2>
            <div className="grid gap-5 sm:grid-cols-2">
              <div className="space-y-2">
                <Label>{t("settings.theme")}</Label>
                <Select value={settings.theme} onValueChange={(value) => handleSettingChange('theme', value as any)}>
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="light">{t("theme.light")}</SelectItem>
                    <SelectItem value="dark">{t("theme.dark")}</SelectItem>
                    <SelectItem value="system">{t("theme.system")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>{t("settings.language")}</Label>
                <Select
                  value={i18n.language}
                  onValueChange={(value) => {
                    console.log('Language selection changed to:', value);
                    // Change language
                    i18n.changeLanguage(value).then(() => {
                      // Update localStorage
                      localStorage.setItem('i18nextLng', value);
                      // Update settings state - this will trigger re-render via useEffect
                      setSettings(prev => ({ ...prev, language: value }));
                      // Force re-render
                      setLanguageChanged(prev => prev + 1);
                    });
                  }}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="fr">{t("language.french")}</SelectItem>
                    <SelectItem value="en">{t("language.english")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </section>

          {/* Sécurité */}
          <section className="rounded-xl border bg-card p-6 shadow-card">
            <h2 className="text-lg font-semibold flex items-center gap-2 mb-4">
              <Shield className="h-5 w-5 text-primary" />
              {t("settings.accountSecurity")}
            </h2>
            <div className="space-y-5">
              <div className="grid gap-5 sm:grid-cols-2">
                <div className="space-y-2">
                  <Label htmlFor="currentPassword">Mot de passe actuel</Label>
                  <div className="relative">
                    <Lock className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                    <Input
                      id="currentPassword"
                      type="password"
                      placeholder="••••••••"
                      className="pl-10"
                      value={passwordData.current_password}
                      onChange={(e) => setPasswordData({ ...passwordData, current_password: e.target.value })}
                    />
                  </div>
                </div>
              </div>
              <div className="grid gap-5 sm:grid-cols-2">
                <div className="space-y-2">
                  <Label htmlFor="newPassword">Nouveau mot de passe</Label>
                  <div className="relative">
                    <Lock className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                    <Input
                      id="newPassword"
                      type="password"
                      placeholder="••••••••"
                      className="pl-10"
                      value={passwordData.new_password}
                      onChange={(e) => setPasswordData({ ...passwordData, new_password: e.target.value })}
                    />
                  </div>
                </div>
                <div className="space-y-2">
                  <Label htmlFor="confirmPassword">Confirmer le mot de passe</Label>
                  <div className="relative">
                    <Lock className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                    <Input
                      id="confirmPassword"
                      type="password"
                      placeholder="••••••••"
                      className="pl-10"
                      value={passwordData.confirm_password}
                      onChange={(e) => setPasswordData({ ...passwordData, confirm_password: e.target.value })}
                    />
                  </div>
                </div>
              </div>
              <Button variant="outline" size="sm" onClick={handleChangePassword} disabled={saving}>
                {saving ? (
                  <>
                    <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                    {t("common.saving")}
                  </>
                ) : (
                  t("settings.changePassword")
                )}
              </Button>
            </div>
          </section>

          {/* Danger zone */}
          <section className="rounded-xl border border-destructive/30 bg-card p-6 shadow-card">
            <h2 className="text-lg font-semibold flex items-center gap-2 mb-4 text-destructive">
              <Trash2 className="h-5 w-5" />
              {t("settings.deleteAccount")}
            </h2>
            <p className="text-sm text-muted-foreground mb-4">
              {t("settings.deleteConfirm")}
            </p>
            <Button variant="destructive" size="sm" onClick={() => setShowDeleteDialog(true)}>
              {t("settings.deleteAccount")}
            </Button>
          </section>
        </div>

        <div className="flex justify-end gap-3 mt-6 shrink-0 pt-6 border-t">
          <Button variant="outline" size="lg" disabled={saving}>
            {t("common.cancel")}
          </Button>
          <Button variant="hero" size="lg" onClick={handleSave} disabled={saving}>
            {saving ? (
              <>
                <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                {t("common.saving")}
              </>
            ) : (
              <>
                <Save className="h-4 w-4 mr-2" />
                {t("settings.saveSettings")}
              </>
            )}
          </Button>
        </div>

        <AlertDialog open={showDeleteDialog} onOpenChange={setShowDeleteDialog}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle className="text-destructive">
                Supprimer le compte
              </AlertDialogTitle>
              <AlertDialogDescription>
                Cette action est irréversible. Tous vos données seront supprimées définitivement.
              </AlertDialogDescription>
            </AlertDialogHeader>
            <div className="space-y-4 py-4">
              <div className="space-y-2">
                <Label htmlFor="deletePassword">Confirmer avec votre mot de passe</Label>
                <Input
                  id="deletePassword"
                  type="password"
                  placeholder="••••••••"
                  value={deletePassword}
                  onChange={(e) => setDeletePassword(e.target.value)}
                />
              </div>
            </div>
            <div className="flex gap-3 justify-end">
              <AlertDialogCancel>Annuler</AlertDialogCancel>
              <AlertDialogAction
                onClick={handleDeleteAccount}
                disabled={saving}
                className="bg-destructive hover:bg-destructive/90"
              >
                {saving ? (
                  <>
                    <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                    Suppression...
                  </>
                ) : (
                  "Supprimer définitivement"
                )}
              </AlertDialogAction>
            </div>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </DashboardLayout>
  );
};

export default Settings;
