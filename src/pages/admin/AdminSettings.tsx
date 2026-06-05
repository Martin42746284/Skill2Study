import AdminLayout from "@/components/AdminLayout";
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
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import {
  Globe,
  Bell,
  Shield,
  Database,
  Loader2,
} from "lucide-react";
import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { useToast } from "@/hooks/use-toast";
import { useSettings } from "@/contexts/SettingsContext";
import { admin } from "@/lib/api";

const AdminSettings = () => {
  const { t } = useTranslation();
  const { toast } = useToast();
  const { settings, updateSettings, isLoading, refreshSettings } = useSettings();
  const [platformName, setPlatformName] = useState(settings.platform_name);
  const [platformDesc, setPlatformDesc] = useState(settings.platform_description);
  const [contactEmail, setContactEmail] = useState(settings.contact_email);
  const [emailNotif, setEmailNotif] = useState(settings.email_notifications);
  const [moderationAlert, setModerationAlert] = useState(settings.moderation_alerts);
  const [weeklyReport, setWeeklyReport] = useState(settings.weekly_reports);
  const [twoFA, setTwoFA] = useState(settings.two_factor_auth);
  const [openRegistration, setOpenRegistration] = useState(settings.open_registration);
  const [emailVerification, setEmailVerification] = useState(settings.email_verification);
  const [maintenanceMode, setMaintenanceMode] = useState(settings.maintenance_mode);
  const [resetDialogOpen, setResetDialogOpen] = useState(false);
  const [loading, setLoading] = useState(isLoading);
  const [saving, setSaving] = useState(false);
  const [hasInitialized, setHasInitialized] = useState(false);

  // Only initialize once when settings are first loaded
  useEffect(() => {
    if (!hasInitialized && !isLoading) {
      setPlatformName(settings.platform_name);
      setPlatformDesc(settings.platform_description);
      setContactEmail(settings.contact_email);
      setEmailNotif(settings.email_notifications);
      setModerationAlert(settings.moderation_alerts);
      setWeeklyReport(settings.weekly_reports);
      setTwoFA(settings.two_factor_auth);
      setOpenRegistration(settings.open_registration);
      setEmailVerification(settings.email_verification);
      setMaintenanceMode(settings.maintenance_mode);
      setHasInitialized(true);
      setLoading(false);
    }
  }, [isLoading, hasInitialized]);

  const handleSave = async () => {
    try {
      setSaving(true);
      const newSettings = {
        platform_name: platformName,
        platform_description: platformDesc,
        contact_email: contactEmail,
        email_notifications: emailNotif,
        moderation_alerts: moderationAlert,
        weekly_reports: weeklyReport,
        two_factor_auth: twoFA,
        open_registration: openRegistration,
        email_verification: emailVerification,
        maintenance_mode: maintenanceMode,
      };

      // Update API
      await admin.updateSettings(newSettings);

      // Refresh settings from backend to ensure consistency
      if (refreshSettings) {
        await refreshSettings();
      }

      toast({ title: t("admin.pages.settings.settingsSaved"), description: t("admin.pages.settings.settingsSavedDesc") });
    } catch (error) {
      toast({ title: t("admin.pages.settings.errorSaving"), description: t("admin.pages.settings.errorSavingDesc"), variant: "destructive" });
      console.error('Error saving settings:', error);
    } finally {
      setSaving(false);
    }
  };

  const handleExport = () => {
    toast({
      title: t("admin.pages.settings.exportStarted"),
      description: t("admin.pages.settings.exportStartedDesc")
    });
  };

  const handleClearCache = () => {
    toast({
      title: t("admin.pages.settings.cacheCleared"),
      description: t("admin.pages.settings.cacheClearedDesc")
    });
  };

  const handleResetStats = () => {
    setResetDialogOpen(false);
    toast({
      title: t("admin.pages.settings.statsReset"),
      description: t("admin.pages.settings.statsResetDesc"),
      variant: "destructive"
    });
  };

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-screen">
          <p className="text-muted-foreground">{t("common.loading")}</p>
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout>
      <div className="animate-fade-in h-full flex flex-col">
        <div className="mb-6 shrink-0">
          <h1 className="text-3xl font-bold">{t("admin.pages.settings.title")}</h1>
          <p className="mt-1 text-muted-foreground">{t("admin.pages.settings.description")}</p>
        </div>

        <div className="flex-1 overflow-y-auto pr-2 space-y-4">

          {/* General Settings */}
          <section className="rounded-xl border bg-card p-6 shadow-card">
            <h2 className="text-lg font-semibold flex items-center gap-2 mb-4">
              <Globe className="h-5 w-5 text-primary" /> {t("admin.pages.settings.generalInfo")}
            </h2>
            <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
              <div className="grid gap-2">
                <Label htmlFor="platform-name">{t("admin.pages.settings.platformName")}</Label>
                <Input id="platform-name" value={platformName} onChange={(e) => setPlatformName(e.target.value)} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="contact-email">{t("admin.pages.settings.contactEmail")}</Label>
                <Input id="contact-email" type="email" value={contactEmail} onChange={(e) => setContactEmail(e.target.value)} />
              </div>
              <div className="grid gap-2 sm:col-span-2 lg:col-span-1">
                <Label htmlFor="platform-desc">{t("admin.pages.settings.platformDescription")}</Label>
                <Input id="platform-desc" value={platformDesc} onChange={(e) => setPlatformDesc(e.target.value)} />
              </div>
            </div>
          </section>

          {/* Notifications & Security */}
          <div className="grid gap-4 lg:grid-cols-2">
            {/* Notifications */}
            <section className="rounded-xl border bg-card p-6 shadow-card">
              <h2 className="text-lg font-semibold flex items-center gap-2 mb-4">
                <Bell className="h-5 w-5 text-primary" /> {t("admin.pages.settings.notifications")}
              </h2>
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium">{t("admin.pages.settings.emailNotifications")}</p>
                    <p className="text-xs text-muted-foreground">{t("admin.pages.settings.emailNotificationsDesc")}</p>
                  </div>
                  <Switch checked={emailNotif} onCheckedChange={setEmailNotif} />
                </div>
                <Separator />
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium">{t("admin.pages.settings.moderationAlerts")}</p>
                    <p className="text-xs text-muted-foreground">{t("admin.pages.settings.moderationAlertsDesc")}</p>
                  </div>
                  <Switch checked={moderationAlert} onCheckedChange={setModerationAlert} />
                </div>
                <Separator />
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium">{t("admin.pages.settings.weeklyReports")}</p>
                    <p className="text-xs text-muted-foreground">{t("admin.pages.settings.weeklyReportsDesc")}</p>
                  </div>
                  <Switch checked={weeklyReport} onCheckedChange={setWeeklyReport} />
                </div>
              </div>
            </section>

            {/* Security */}
            <section className="rounded-xl border bg-card p-6 shadow-card">
              <h2 className="text-lg font-semibold flex items-center gap-2 mb-4">
                <Shield className="h-5 w-5 text-primary" /> {t("admin.pages.settings.security")}
              </h2>
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium">{t("admin.pages.settings.twoFactor")}</p>
                    <p className="text-xs text-muted-foreground">{t("admin.pages.settings.twoFactorDesc")}</p>
                  </div>
                  <Switch checked={twoFA} onCheckedChange={setTwoFA} />
                </div>
                <Separator />
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium">{t("admin.pages.settings.openRegistration")}</p>
                    <p className="text-xs text-muted-foreground">{t("admin.pages.settings.openRegistrationDesc")}</p>
                  </div>
                  <Switch checked={openRegistration} onCheckedChange={setOpenRegistration} />
                </div>
                <Separator />
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium">{t("admin.pages.settings.emailVerification")}</p>
                    <p className="text-xs text-muted-foreground">{t("admin.pages.settings.emailVerificationDesc")}</p>
                  </div>
                  <Switch checked={emailVerification} onCheckedChange={setEmailVerification} />
                </div>
              </div>
            </section>
          </div>

          {/* Maintenance */}
          <section className="rounded-xl border bg-card p-6 shadow-card">
          <h2 className="text-lg font-semibold flex items-center gap-2 mb-4">
            <Database className="h-5 w-5 text-primary" /> {t("admin.pages.settings.maintenance")}
          </h2>
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium">{t("admin.pages.settings.maintenanceMode")}</p>
                <p className="text-xs text-muted-foreground">{t("admin.pages.settings.maintenanceModeDesc")}</p>
              </div>
              <Switch checked={maintenanceMode} onCheckedChange={(v) => {
                setMaintenanceMode(v);
                toast({ title: v ? t("admin.pages.settings.maintenanceEnabled") : t("admin.pages.settings.maintenanceDisabled") });
              }} />
            </div>
            <Separator />
            <div className="flex flex-col sm:flex-row gap-3">
              <Button variant="outline" size="sm" onClick={handleExport}>{t("admin.pages.settings.exportData")}</Button>
              <Button variant="outline" size="sm" onClick={handleClearCache}>{t("admin.pages.settings.clearCache")}</Button>
              <Button variant="destructive" size="sm" onClick={() => setResetDialogOpen(true)}>{t("admin.pages.settings.resetStats")}</Button>
            </div>
          </div>
        </section>

        </div>

        <div className="flex justify-end gap-3 mt-6 shrink-0 pt-6 border-t">
          <Button variant="outline" disabled={saving} onClick={() => toast({ title: t("admin.pages.settings.cancelled"), description: t("admin.pages.settings.cancelledDesc") })}>{t("admin.pages.settings.cancel")}</Button>
          <Button onClick={handleSave} disabled={saving}>
            {saving ? (
              <>
                <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                {t("common.saving")}
              </>
            ) : (
              t("admin.pages.settings.saveChanges")
            )}
          </Button>
        </div>

        {/* Reset Stats Confirmation */}
        <AlertDialog open={resetDialogOpen} onOpenChange={setResetDialogOpen}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.pages.settings.confirmReset")}</AlertDialogTitle>
              <AlertDialogDescription>
                {t("admin.pages.settings.confirmResetDesc")}
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>{t("admin.pages.settings.cancel")}</AlertDialogCancel>
              <AlertDialogAction onClick={handleResetStats} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
                {t("admin.pages.settings.resetStats")}
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </AdminLayout>
  );
};

export default AdminSettings;
