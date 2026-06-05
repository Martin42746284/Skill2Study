import DashboardLayout from "@/components/DashboardLayout";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { useTranslation } from "react-i18next";
import {
  Bell,
  CheckCircle2,
  ClipboardCheck,
  FileText,
  GraduationCap,
  Info,
  Check,
  Trash2,
  Loader2,
  AlertCircle,
} from "lucide-react";
import { useState, useEffect } from "react";
import { useToast } from "@/hooks/use-toast";
import { cn } from "@/lib/utils";
import { notifications as notificationsApi } from "@/lib/api";

interface Notification {
  id: number;
  title: string;
  message: string;
  type: "test" | "candidature" | "info" | "success" | "warning";
  createdAt: string;
  read: boolean;
  read_at?: string;
  data?: any;
}

const typeConfig = {
  test: { icon: ClipboardCheck, color: "bg-primary/10 text-primary" },
  candidature: { icon: FileText, color: "bg-warning/10 text-warning" },
  info: { icon: Info, color: "bg-info/10 text-info" },
  success: { icon: CheckCircle2, color: "bg-success/10 text-success" },
  warning: { icon: AlertCircle, color: "bg-destructive/10 text-destructive" },
};

const Notifications = () => {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);
  const [deletingId, setDeletingId] = useState<number | null>(null);
  const [deleting, setDeleting] = useState(false);
  const unreadCount = notifications.filter((n) => !n.read).length;

  useEffect(() => {
    const loadNotifications = async () => {
      try {
        setLoading(true);
        const response = await notificationsApi.getNotifications(50, 0) as any;
        setNotifications(response.notifications || []);
        setError(null);
      } catch (err) {
        const message = err instanceof Error ? err.message : t("notifications.errorLoading");
        setError(message);
        console.error('Error loading notifications:', err);
      } finally {
        setLoading(false);
      }
    };

    loadNotifications();
  }, [t]);

  const markAllRead = async () => {
    try {
      await notificationsApi.markAllRead();
      setNotifications((prev) => prev.map((n) => ({ ...n, read: true })));
      toast({ title: t("notifications.markedAsRead") });
    } catch (err) {
      const message = err instanceof Error ? err.message : t("common.error");
      toast({
        title: t("common.error"),
        description: message,
        variant: "destructive",
      });
    }
  };

  const markAsRead = async (id: number) => {
    try {
      await notificationsApi.markAsRead(id);
      setNotifications((prev) =>
        prev.map((n) => (n.id === id ? { ...n, read: true, read_at: new Date().toISOString() } : n))
      );
    } catch (err) {
      const message = err instanceof Error ? err.message : t("common.error");
      toast({
        title: t("common.error"),
        description: message,
        variant: "destructive",
      });
    }
  };

  const openDeleteConfirm = (id: number) => {
    setDeletingId(id);
    setShowDeleteConfirm(true);
  };

  const confirmDelete = async () => {
    if (!deletingId) return;
    try {
      setDeleting(true);
      await notificationsApi.deleteNotification(deletingId);
      setNotifications((prev) => prev.filter((n) => n.id !== deletingId));
      toast({ title: t("notifications.deleted") });
      setShowDeleteConfirm(false);
      setDeletingId(null);
    } catch (err) {
      const message = err instanceof Error ? err.message : t("common.error");
      toast({
        title: t("common.error"),
        description: message,
        variant: "destructive",
      });
    } finally {
      setDeleting(false);
    }
  };

  const formatDate = (dateStr: string) => {
    if (!dateStr) return "Date inconnue";

    const date = new Date(dateStr);

    // Check if date is valid
    if (isNaN(date.getTime())) {
      return "Date inconnue";
    }

    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
    const diffMinutes = Math.floor(diffMs / (1000 * 60));

    if (diffMinutes < 1) return "À l'instant";
    if (diffMinutes < 60) return `Il y a ${diffMinutes}m`;
    if (diffHours < 24) return `Il y a ${diffHours}h`;

    const diffDays = Math.floor(diffHours / 24);
    if (diffDays === 1) return "Hier";
    if (diffDays < 7) return `Il y a ${diffDays} jours`;

    return date.toLocaleDateString("fr-FR", { day: "numeric", month: "long" });
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
      <div className="animate-fade-in h-full flex flex-col px-3 sm:px-4 md:px-6 lg:px-8 py-4 sm:py-6">
        <div className="mb-4 sm:mb-6 flex flex-col sm:flex-row sm:items-center sm:justify-between shrink-0 gap-3">
          <div className="min-w-0">
            <h1 className="text-2xl sm:text-3xl font-bold flex items-center gap-2 flex-wrap">
              {t("notifications.title")}
              {unreadCount > 0 && (
                <Badge className="bg-primary text-primary-foreground text-xs">{unreadCount}</Badge>
              )}
            </h1>
            <p className="mt-1 text-xs sm:text-sm text-muted-foreground">
              {t("dashboard.sidebar.notifications")}
            </p>
          </div>
          {unreadCount > 0 && (
            <Button variant="outline" size="sm" onClick={markAllRead} className="text-xs">
              <Check className="h-3.5 sm:h-4 w-3.5 sm:w-4 mr-1" />
              {t("notifications.markAsRead")}
            </Button>
          )}
        </div>

        {error && (
          <div className="rounded-xl border border-destructive/50 bg-destructive/5 p-3 sm:p-4 flex items-start gap-2 sm:gap-3 mb-4 sm:mb-6 shrink-0">
            <AlertCircle className="h-4 sm:h-5 w-4 sm:w-5 text-destructive flex-shrink-0 mt-0.5" />
            <div className="min-w-0 flex-1">
              <p className="font-semibold text-destructive text-sm">{t("common.error")}</p>
              <p className="text-xs sm:text-sm text-destructive/80">{error}</p>
            </div>
          </div>
        )}

        {notifications.length === 0 ? (
          <div className="flex flex-col items-center justify-center flex-1">
            <div className="rounded-xl border bg-card p-8 sm:p-12 text-center shadow-card">
              <Bell className="h-10 sm:h-12 w-10 sm:w-12 text-muted-foreground mb-4 mx-auto" />
              <h3 className="text-base sm:text-lg font-semibold mb-2">{t("notifications.noNotifications")}</h3>
              <p className="text-xs sm:text-sm text-muted-foreground">
                {t("notifications.noNotifications")}
              </p>
            </div>
          </div>
        ) : (
          <div className="space-y-2 sm:space-y-3 overflow-y-auto flex-1 pr-2">
            {notifications.map((notif) => {
              const config = typeConfig[notif.type];
              const Icon = config.icon;
              return (
                <div
                  key={notif.id}
                  className={cn(
                    "rounded-xl border bg-card p-3 sm:p-4 shadow-card transition-all hover:shadow-card-hover cursor-pointer",
                    !notif.read && "border-primary/30 bg-accent/30"
                  )}
                  onClick={() => markAsRead(notif.id)}
                >
                  <div className="flex gap-2 sm:gap-4">
                    <div className={cn("flex h-9 sm:h-10 w-9 sm:w-10 shrink-0 items-center justify-center rounded-lg", config.color)}>
                      <Icon className="h-4 sm:h-5 w-4 sm:w-5" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-start justify-between gap-2">
                        <div className="min-w-0 flex-1">
                          <h3 className={cn("font-semibold text-xs sm:text-sm", !notif.read && "text-foreground")}>
                            {notif.title}
                            {!notif.read && (
                              <span className="ml-2 inline-block h-2 w-2 rounded-full bg-primary" />
                            )}
                          </h3>
                          <p className="text-xs sm:text-sm text-muted-foreground mt-1">{notif.message}</p>
                          <p className="text-xs text-muted-foreground mt-2">{formatDate(notif.createdAt)}</p>
                        </div>
                        <Button
                          variant="ghost"
                          size="icon"
                          className="shrink-0 h-7 sm:h-8 w-7 sm:w-8 text-muted-foreground hover:text-destructive"
                          onClick={(e) => {
                            e.stopPropagation();
                            openDeleteConfirm(notif.id);
                          }}
                        >
                          <Trash2 className="h-3.5 sm:h-4 w-3.5 sm:w-4" />
                        </Button>
                      </div>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>

      <AlertDialog open={showDeleteConfirm} onOpenChange={setShowDeleteConfirm}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>{t("notifications.deleteConfirmTitle")}</AlertDialogTitle>
            <AlertDialogDescription>
              {t("notifications.deleteConfirmDescription")}
            </AlertDialogDescription>
          </AlertDialogHeader>
          <div className="flex gap-3 justify-end">
            <AlertDialogCancel>{t("notifications.deleteCancel")}</AlertDialogCancel>
            <AlertDialogAction
              onClick={confirmDelete}
              disabled={deleting}
              className="bg-destructive hover:bg-destructive/90"
            >
              {deleting ? (
                <>
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                  {t("notifications.deleteDeleting")}
                </>
              ) : (
                t("notifications.deleteConfirm")
              )}
            </AlertDialogAction>
          </div>
        </AlertDialogContent>
      </AlertDialog>
    </DashboardLayout>
  );
};

export default Notifications;
