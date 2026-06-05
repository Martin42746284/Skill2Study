import { ReactNode } from "react";
import { Link, useLocation } from "react-router-dom";
import {
  LayoutDashboard,
  ClipboardCheck,
  Target,
  GitCompareArrows,
  History,
  User,
  Settings,
  MapPinned,
  LogOut,
  Menu,
  X,
  Bell,
  Search,
  Heart,
} from "lucide-react";
import { useState } from "react";
import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";
import { useTheme } from "@/hooks/use-theme";

const getNavItems = (t: any) => [
  { titleKey: "dashboard.sidebar.dashboard", icon: LayoutDashboard, url: "/dashboard" },
  { titleKey: "dashboard.sidebar.orientationTest", icon: ClipboardCheck, url: "/tests" },
  { titleKey: "dashboard.sidebar.recommendations", icon: Target, url: "/recommendations" },
  { titleKey: "dashboard.sidebar.compare", icon: GitCompareArrows, url: "/compare" },
  { titleKey: "dashboard.sidebar.search", icon: Search, url: "/dashboard/search" },
  { titleKey: "dashboard.sidebar.favorites", icon: Heart, url: "/dashboard/favorites" },
  { titleKey: "dashboard.sidebar.history", icon: History, url: "/dashboard/history" },
  { titleKey: "dashboard.sidebar.notifications", icon: Bell, url: "/dashboard/notifications" },
  { titleKey: "dashboard.sidebar.universityMap", icon: MapPinned, url: "/dashboard/map" },
];

const getBottomItems = (t: any) => [
  { titleKey: "dashboard.sidebar.profile", icon: User, url: "/dashboard/profile" },
  { titleKey: "dashboard.sidebar.settings", icon: Settings, url: "/dashboard/settings" },
];

interface DashboardLayoutProps {
  children: ReactNode;
}

const DashboardLayout = ({ children }: DashboardLayoutProps) => {
  const location = useLocation();
  const { theme } = useTheme();
  const { t } = useTranslation();
  const [collapsed, setCollapsed] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);

  const navItems = getNavItems(t);
  const bottomItems = getBottomItems(t);

  const sidebarContent = (
    <>
      {/* Logo */}
      <div className="flex h-16 items-center justify-between border-b px-4">
        <Link to="/dashboard" className="flex items-center gap-2">
          <div className="flex items-center justify-center rounded-lg bg-white p-1 shrink-0">
            <img
              src="/logo.png"
              alt="Skill2Study"
              className="h-12 w-12 object-contain rounded-md"
            />
          </div>
          {!collapsed && <span className={cn("font-bold", theme === "dark" ? "text-white" : "text-foreground")}>Skill2Study</span>}
        </Link>
        {/* Desktop collapse */}
        <button
          onClick={() => setCollapsed(!collapsed)}
          className="hidden rounded-md p-1.5 text-muted-foreground hover:bg-accent hover:text-accent-foreground transition-colors lg:block"
        >
          <Menu className="h-5 w-5" />
        </button>
        {/* Mobile close */}
        <button
          onClick={() => setMobileOpen(false)}
          className="rounded-md p-1.5 text-muted-foreground hover:bg-accent hover:text-accent-foreground transition-colors lg:hidden"
        >
          <X className="h-5 w-5" />
        </button>
      </div>

      {/* Navigation */}
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

      {/* Bottom */}
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
          {!collapsed && <span>{t("dashboard.sidebar.logout")}</span>}
        </Link>
      </div>
    </>
  );

  return (
    <div className="flex min-h-screen w-full bg-background">
      {/* Mobile top bar */}
      <div className="fixed left-0 right-0 top-0 z-50 flex h-14 items-center border-b bg-card px-4 lg:hidden">
        <button
          onClick={() => setMobileOpen(true)}
          className="rounded-md p-2 text-muted-foreground hover:bg-accent hover:text-accent-foreground transition-colors"
          aria-label="Ouvrir le menu"
        >
          <Menu className="h-5 w-5" />
        </button>
        <Link to="/dashboard" className="ml-3 flex items-center gap-2">
          <img
            src="/logo.png"
            alt="Skill2Study"
            className="h-10 w-10 object-contain rounded-lg"
          />
          <span className="font-bold text-sm">Skill2Study</span>
        </Link>
      </div>

      {/* Mobile overlay */}
      {mobileOpen && (
        <div
          className="fixed inset-0 z-40 bg-foreground/20 backdrop-blur-sm lg:hidden"
          onClick={() => setMobileOpen(false)}
        />
      )}

      {/* Sidebar */}
      <aside
        className={cn(
          "fixed left-0 top-0 z-50 flex h-full flex-col border-r bg-card transition-all duration-300",
          // Desktop
          "hidden lg:flex",
          collapsed ? "lg:w-[68px]" : "lg:w-64"
        )}
      >
        {sidebarContent}
      </aside>

      {/* Mobile sidebar drawer */}
      <aside
        className={cn(
          "fixed left-0 top-0 z-50 flex h-full w-64 flex-col border-r bg-card transition-transform duration-300 lg:hidden",
          mobileOpen ? "translate-x-0" : "-translate-x-full"
        )}
      >
        {sidebarContent}
      </aside>

      {/* Main content */}
      <main
        className={cn(
          "flex-1 transition-all duration-300 overflow-x-hidden",
          // Desktop margin
          collapsed ? "lg:ml-[68px]" : "lg:ml-64",
          // Mobile top padding for top bar
          "pt-14 lg:pt-0"
        )}
      >
        <div className="p-4 sm:p-6 lg:p-8 overflow-x-hidden w-full">{children}</div>
      </main>
    </div>
  );
};

export default DashboardLayout;
