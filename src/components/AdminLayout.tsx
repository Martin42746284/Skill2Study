import { ReactNode, useState } from "react";
import { Link, useLocation } from "react-router-dom";
import {
  LayoutDashboard,
  Users,
  GraduationCap,
  ClipboardCheck,
  Settings,
  LogOut,
  Menu,
  X,
  Building2,
  MessageSquare,
  Sliders,
  BookOpen,
  Layers,
  BarChart3,
} from "lucide-react";
import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";
import { useSettings } from "@/contexts/SettingsContext";
import { useTheme } from "@/hooks/use-theme";
import AdminHeader from "@/components/AdminHeader";

const getNavItems = (t: any) => [
  { titleKey: "admin.sidebar.overview", icon: LayoutDashboard, url: "/admin" },
  { titleKey: "admin.sidebar.users", icon: Users, url: "/admin/users" },
  { titleKey: "admin.sidebar.universities", icon: Building2, url: "/admin/universities" },
  { titleKey: "admin.sidebar.fields", icon: BookOpen, url: "/admin/filieres" },
  //{ titleKey: "admin.sidebar.programs", icon: Layers, url: "/admin/parcours" },
  { titleKey: "admin.sidebar.tests", icon: ClipboardCheck, url: "/admin/tests" },
  { titleKey: "admin.sidebar.testimonials", icon: MessageSquare, url: "/admin/testimonials" },
];

const getBottomItems = (t: any) => [
  { titleKey: "admin.sidebar.settings", icon: Settings, url: "/admin/settings" },
];

interface AdminLayoutProps {
  children: ReactNode;
}

const AdminLayout = ({ children }: AdminLayoutProps) => {
  const location = useLocation();
  const { settings } = useSettings();
  const { theme } = useTheme();
  const { t } = useTranslation();
  const [collapsed, setCollapsed] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);

  const navItems = getNavItems(t);
  const bottomItems = getBottomItems(t);

  const sidebarContent = (
    <>
      <div className="flex h-16 items-center justify-between border-b px-4">
        <Link to="/admin" className="flex items-center gap-2">
          <div className="flex items-center justify-center rounded-lg bg-white p-1 shrink-0">
            <img
              src="/logo.png"
              alt={settings.platform_name}
              className="h-12 w-12 object-contain rounded-md"
            />
          </div>
          {!collapsed && (
            <div className="flex flex-col">
              <span className={cn("font-bold text-sm", theme === "dark" ? "text-white" : "text-foreground")}>{settings.platform_name}</span>
              <span className="text-[10px] text-muted-foreground font-medium">{t("admin.administration")}</span>
            </div>
          )}
        </Link>
        <button
          onClick={() => setCollapsed(!collapsed)}
          className="hidden rounded-md p-1.5 text-muted-foreground hover:bg-accent hover:text-accent-foreground transition-colors lg:block"
        >
          <Menu className="h-5 w-5" />
        </button>
        <button
          onClick={() => setMobileOpen(false)}
          className="rounded-md p-1.5 text-muted-foreground hover:bg-accent hover:text-accent-foreground transition-colors lg:hidden"
        >
          <X className="h-5 w-5" />
        </button>
      </div>

      <nav className="flex-1 space-y-1 p-3">
        {navItems.map((item) => {
          const active = location.pathname === item.url;
          return (
            <Link
              key={item.titleKey}
              to={item.url}
              onClick={() => setMobileOpen(false)}
              className={cn(
                "flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition-all",
                active
                  ? "bg-accent text-accent-foreground"
                  : "text-muted-foreground hover:bg-accent/50 hover:text-foreground"
              )}
            >
              <item.icon className="h-5 w-5 shrink-0" />
              {!collapsed && <span>{t(item.titleKey)}</span>}
            </Link>
          );
        })}
      </nav>

      <div className="border-t p-3 space-y-1">
        {bottomItems.map((item) => {
          const active = location.pathname === item.url;
          return (
            <Link
              key={item.titleKey}
              to={item.url}
              onClick={() => setMobileOpen(false)}
              className={cn(
                "flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition-all",
                active
                  ? "bg-accent text-accent-foreground"
                  : "text-muted-foreground hover:bg-accent/50 hover:text-foreground"
              )}
            >
              <item.icon className="h-5 w-5 shrink-0" />
              {!collapsed && <span>{t(item.titleKey)}</span>}
            </Link>
          );
        })}
        <Link
          to="/logout"
          className="flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium text-destructive hover:bg-destructive/10 transition-all"
        >
          <LogOut className="h-5 w-5 shrink-0" />
          {!collapsed && <span>{t("admin.sidebar.logout")}</span>}
        </Link>
      </div>
    </>
  );

  return (
    <div className="flex min-h-screen w-full bg-background">
      <div className="fixed left-0 right-0 top-0 z-50 flex h-14 items-center border-b bg-card px-4 lg:hidden">
        <button
          onClick={() => setMobileOpen(true)}
          className="rounded-md p-2 text-muted-foreground hover:bg-accent hover:text-accent-foreground transition-colors"
        >
          <Menu className="h-5 w-5" />
        </button>
        <Link to="/admin" className="ml-3 flex items-center gap-2">
          <img
            src="/logo.png"
            alt={settings.platform_name}
            className="h-10 w-10 object-contain rounded-lg"
          />
          <span className="font-bold text-sm">{settings.platform_name}</span>
        </Link>
      </div>

      {mobileOpen && (
        <div
          className="fixed inset-0 z-40 bg-foreground/20 backdrop-blur-sm lg:hidden"
          onClick={() => setMobileOpen(false)}
        />
      )}

      <aside
        className={cn(
          "fixed left-0 top-0 z-50 flex h-full flex-col border-r bg-card transition-all duration-300 lg:flex",
          collapsed ? "lg:w-[68px]" : "lg:w-64"
        )}
      >
        {sidebarContent}
      </aside>

      <aside
        className={cn(
          "fixed left-0 top-0 z-50 flex h-full w-64 flex-col border-r bg-card transition-transform duration-300 lg:hidden",
          mobileOpen ? "translate-x-0" : "-translate-x-full"
        )}
      >
        {sidebarContent}
      </aside>

      <main
        className={cn(
          "flex-1 flex flex-col transition-all duration-300",
          collapsed ? "lg:ml-[68px]" : "lg:ml-64",
          "pt-14 lg:pt-0"
        )}
      >
        <AdminHeader />
        <div className="flex-1 overflow-y-auto p-4 sm:p-6 lg:p-8">{children}</div>
      </main>
    </div>
  );
};

export default AdminLayout;
