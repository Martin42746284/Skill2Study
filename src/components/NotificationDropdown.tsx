import { useEffect, useState } from "react";
import { Bell, X, CheckCheck } from "lucide-react";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { useToast } from "@/hooks/use-toast";
import { notifications as notificationsApi, isAuthenticated } from "@/lib/api";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

interface Notification {
  id: number;
  title: string;
  message: string;
  type: string;
  read: boolean;
  createdAt: string;
}

const NotificationDropdown = () => {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [unreadCount, setUnreadCount] = useState(0);
  const [loading, setLoading] = useState(true);
  const [open, setOpen] = useState(false);

  // Only show for authenticated users
  if (!isAuthenticated()) {
    return null;
  }

  // Load notifications
  useEffect(() => {
    const loadNotifications = async () => {
      try {
        const response = await notificationsApi.getNotifications(5, 0) as any;
        const notifs = response.notifications || [];
        setNotifications(notifs);

        // Count unread
        const unread = notifs.filter((n: Notification) => !n.read).length;
        setUnreadCount(unread);
      } catch (error) {
        console.debug("Error loading notifications:", error);
      } finally {
        setLoading(false);
      }
    };

    loadNotifications();

    // Refresh every 10 seconds
    const interval = setInterval(loadNotifications, 10000);
    return () => clearInterval(interval);
  }, []);

  const handleMarkAsRead = async (id: number, e: React.MouseEvent) => {
    e.preventDefault();
    try {
      await notificationsApi.markAsRead(id);
      setNotifications((prev) =>
        prev.map((n) => (n.id === id ? { ...n, read: true } : n))
      );
      setUnreadCount((prev) => Math.max(0, prev - 1));
    } catch (error) {
      console.error("Error marking notification as read:", error);
    }
  };

  const handleDelete = async (id: number, e: React.MouseEvent) => {
    e.preventDefault();
    try {
      await notificationsApi.deleteNotification(id);
      setNotifications((prev) => prev.filter((n) => n.id !== id));
    } catch (error) {
      console.error("Error deleting notification:", error);
    }
  };

  return (
    <DropdownMenu open={open} onOpenChange={setOpen}>
      <DropdownMenuTrigger asChild>
        <button className="relative p-2 hover:bg-accent rounded-lg transition-colors">
          <Bell className="h-5 w-5" />
          {unreadCount > 0 && (
            <span className="absolute top-0 right-0 h-5 w-5 rounded-full bg-destructive text-white text-xs flex items-center justify-center font-bold">
              {unreadCount > 9 ? "9+" : unreadCount}
            </span>
          )}
        </button>
      </DropdownMenuTrigger>

      <DropdownMenuContent align="end" className="w-80 p-0">
        {/* Header */}
        <div className="px-4 py-3 border-b flex items-center justify-between">
          <h3 className="font-semibold text-sm">{t("notifications.title")}</h3>
          {unreadCount > 0 && (
            <span className="text-xs bg-primary text-primary-foreground px-2 py-1 rounded-full">
              {unreadCount} {t("notifications.new")}
            </span>
          )}
        </div>

        {/* Notifications list */}
        <div className="max-h-96 overflow-y-auto">
          {loading ? (
            <div className="px-4 py-8 text-center text-muted-foreground text-sm">
              {t("common.loading")}
            </div>
          ) : notifications.length === 0 ? (
            <div className="px-4 py-8 text-center text-muted-foreground text-sm">
              {t("notifications.empty")}
            </div>
          ) : (
            notifications.map((notif) => (
              <div
                key={notif.id}
                className={`px-4 py-3 border-b last:border-0 hover:bg-muted/50 transition-colors ${
                  !notif.read ? "bg-muted/30" : ""
                }`}
              >
                <div className="flex gap-2">
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium line-clamp-2">{notif.title}</p>
                    <p className="text-xs text-muted-foreground mt-1 line-clamp-2">
                      {notif.message}
                    </p>
                    <p className="text-xs text-muted-foreground mt-2">
                      {new Date(notif.createdAt).toLocaleDateString("fr-FR")}
                    </p>
                  </div>
                  <div className="flex gap-1 shrink-0">
                    {!notif.read && (
                      <button
                        onClick={(e) => handleMarkAsRead(notif.id, e)}
                        className="p-1 hover:bg-accent rounded transition-colors"
                        title="Mark as read"
                      >
                        <CheckCheck className="h-4 w-4 text-muted-foreground hover:text-foreground" />
                      </button>
                    )}
                    <button
                      onClick={(e) => handleDelete(notif.id, e)}
                      className="p-1 hover:bg-destructive/10 rounded transition-colors"
                      title="Delete"
                    >
                      <X className="h-4 w-4 text-muted-foreground hover:text-destructive" />
                    </button>
                  </div>
                </div>
              </div>
            ))
          )}
        </div>

        {/* Footer - Link to full notifications page */}
        {notifications.length > 0 && (
          <Link
            to="/dashboard/notifications"
            onClick={() => setOpen(false)}
            className="block px-4 py-3 text-center text-sm text-primary hover:bg-muted/50 border-t transition-colors"
          >
            {t("notifications.viewAll")}
          </Link>
        )}
      </DropdownMenuContent>
    </DropdownMenu>
  );
};

export default NotificationDropdown;
