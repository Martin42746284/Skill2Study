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
  Moon,
  Sun,
  Globe,
} from "lucide-react";
import { useState } from "react";
import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";
import { useTheme } from "@/hooks/use-theme";
import { useSettings } from "@/contexts/SettingsContext";
import { useI18n } from "@/hooks/use-i18n";
import { getCurrentUser } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarImage, AvatarFallback } from "@/components/ui/avatar";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import DashboardHeader from "@/components/DashboardHeader";

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

interface MobileHeaderProps {
  mobileOpen: boolean;
  setMobileOpen: (open: boolean) => void;
  platformName: string;
}

const MobileHeaderDashboard = ({ mobileOpen, setMobileOpen, platformName }: MobileHeaderProps) => {
  const { currentLanguage, changeLanguage } = useI18n();
  const { theme, setTheme } = useTheme();
  const { t } = useTranslation();
  const user = getCurrentUser();

  const getInitials = (nom?: string, prenom?: string) => {
    const first = prenom?.[0] || "";
    const last = nom?.[0] || "";
    return (first + last).toUpperCase();
  };

  return (
    <div className="fixed left-0 right-0 top-0 z-50 flex h-20 items-center justify-between border-b bg-card px-4 lg:hidden">
      {/* Left - Hamburger */}
      <button
        onClick={() => setMobileOpen(true)}
        className="rounded-md p-2 text-muted-foreground hover:bg-accent hover:text-accent-foreground transition-colors"
      >
        <Menu className="h-6 w-6" />
      </button>

      {/* Center - Logo & Name */}
      <Link to="/dashboard" className="flex items-center gap-2 flex-1 ml-2">
        <img
          src="/logo.png"
          alt={platformName}
          className="h-12 w-12 object-contain rounded-lg"
        />
        <span className="font-bold text-base hidden sm:inline">{platformName}</span>
      </Link>

      {/* Right - Controls */}
      <div className="flex items-center gap-2">
        {/* Language */}
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button
              variant="ghost"
              size="icon"
              className="h-11 w-11 hover:bg-accent transition-colors"
              title={t("language.toggleLanguage")}
            >
              <Globe className="h-5 w-5" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end" className="w-40">
            <DropdownMenuLabel className="text-xs font-semibold">
              {t("language.toggleLanguage")}
            </DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem
              onClick={() => changeLanguage("fr")}
              className={cn(currentLanguage === "fr" && "bg-accent")}
            >
              <span className="text-sm">🇫🇷 {t("language.french")}</span>
            </DropdownMenuItem>
            <DropdownMenuItem
              onClick={() => changeLanguage("en")}
              className={cn(currentLanguage === "en" && "bg-accent")}
            >
              <span className="text-sm">🇬🇧 {t("language.english")}</span>
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>

        {/* Theme */}
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button
              variant="ghost"
              size="icon"
              className="h-11 w-11 hover:bg-accent transition-colors"
              title={t("theme.toggleTheme")}
            >
              {theme === "dark" ? (
                <Moon className="h-5 w-5" />
              ) : theme === "light" ? (
                <Sun className="h-5 w-5" />
              ) : (
                <Sun className="h-5 w-5 opacity-50" />
              )}
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end" className="w-40">
            <DropdownMenuLabel className="text-xs font-semibold">
              {t("theme.toggleTheme")}
            </DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem
              onClick={() => setTheme("light")}
              className={cn(theme === "light" && "bg-accent")}
            >
              <Sun className="h-4 w-4 mr-2" />
              <span className="text-sm">{t("theme.light")}</span>
            </DropdownMenuItem>
            <DropdownMenuItem
              onClick={() => setTheme("dark")}
              className={cn(theme === "dark" && "bg-accent")}
            >
              <Moon className="h-4 w-4 mr-2" />
              <span className="text-sm">{t("theme.dark")}</span>
            </DropdownMenuItem>
            <DropdownMenuItem
              onClick={() => setTheme("system")}
              className={cn(theme === "system" && "bg-accent")}
            >
              <span className="text-sm mr-2">⚙️</span>
              <span className="text-sm">{t("theme.system")}</span>
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>

        {/* Profile Avatar with Name */}
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button
              variant="ghost"
              className="h-11 px-2 hover:bg-accent transition-colors flex items-center gap-2"
            >
              <Avatar className="h-8 w-8">
                <AvatarImage
                  src={user?.photo || user?.avatar_url || `https://avatar.vercel.sh/${user?.email}`}
                  alt={`${user?.prenom} ${user?.nom}`}
                />
                <AvatarFallback className="bg-primary/20 text-primary text-xs font-semibold">
                  {getInitials(user?.nom, user?.prenom)}
                </AvatarFallback>
              </Avatar>
              <span className="text-sm font-medium hidden sm:inline">{user?.prenom}</span>
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end" className="w-auto">
            <div className="flex items-center gap-3 px-4 py-3">
              <Avatar className="h-10 w-10 shrink-0">
                <AvatarImage
                  src={user?.photo || user?.avatar_url || `https://avatar.vercel.sh/${user?.email}`}
                  alt={`${user?.prenom} ${user?.nom}`}
                />
                <AvatarFallback className="bg-primary/20 text-primary font-semibold">
                  {getInitials(user?.nom, user?.prenom)}
                </AvatarFallback>
              </Avatar>
              <div className="flex flex-col">
                <p className="text-sm font-semibold">
                  {user?.prenom} {user?.nom}
                </p>
                <p className="text-xs text-muted-foreground">
                  {user?.email}
                </p>
              </div>
            </div>
            <DropdownMenuSeparator />
            <Link to="/dashboard/profile">
              <DropdownMenuItem className="cursor-pointer">
                <div className="w-full flex items-center justify-center gap-2">
                  <User className="h-4 w-4" />
                  <span>{t("dashboard.sidebar.profile")}</span>
                </div>
              </DropdownMenuItem>
            </Link>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>
    </div>
  );
};

const DashboardLayout = ({ children }: DashboardLayoutProps) => {
  const location = useLocation();
  const { theme } = useTheme();
  const { t } = useTranslation();
  const { settings } = useSettings();
  const [collapsed, setCollapsed] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);

  const navItems = getNavItems(t);
  const bottomItems = getBottomItems(t);

  const sidebarContent = (
    <div className="flex flex-col h-full">
      {/* Logo */}
      <div className="flex h-20 items-center justify-between border-b px-4 shrink-0">
        <Link to="/dashboard" className="flex items-center gap-2">
          <div className="flex items-center justify-center rounded-lg bg-white p-1 shrink-0">
            <img
              src="/logo.png"
              alt={settings.platform_name}
              className="h-12 w-12 object-contain rounded-md"
            />
          </div>
          {!collapsed && <span className={cn("font-bold text-sm", theme === "dark" ? "text-white" : "text-foreground")}>{settings.platform_name}</span>}
        </Link>
        {/* Desktop collapse */}
        <button
          onClick={() => setCollapsed(!collapsed)}
          className="hidden rounded-md p-1.5 text-muted-foreground hover:bg-accent hover:text-accent-foreground transition-colors lg:block"
        >
          <Menu className="h-6 w-6" />
        </button>
        {/* Mobile close */}
        <button
          onClick={() => setMobileOpen(false)}
          className="rounded-md p-1.5 text-muted-foreground hover:bg-accent hover:text-accent-foreground transition-colors lg:hidden"
        >
          <X className="h-6 w-6" />
        </button>
      </div>

      {/* Navigation */}
      <nav className="flex-1 overflow-y-auto space-y-1 p-3">
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
      <div className="border-t p-3 space-y-1 shrink-0">
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
    </div>
  );

  const sidebarWidth = collapsed ? 68 : 256;

  return (
    <div className="flex min-h-screen w-full bg-background" style={{ '--sidebar-width': `${sidebarWidth}px` } as React.CSSProperties}>
      {/* Mobile Header with Controls */}
      <MobileHeaderDashboard
        mobileOpen={mobileOpen}
        setMobileOpen={setMobileOpen}
        platformName={settings.platform_name}
      />

      {/* Mobile overlay */}
      {mobileOpen && (
        <div
          className="fixed inset-0 z-40 bg-foreground/20 backdrop-blur-sm lg:hidden"
          onClick={() => setMobileOpen(false)}
        />
      )}

      {/* Desktop Sidebar */}
      <aside
        className={cn(
          "hidden lg:flex fixed left-0 top-0 z-50 h-full flex-col border-r bg-card transition-all duration-300",
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
          "flex-1 flex flex-col transition-all duration-300 overflow-hidden",
          collapsed ? "lg:ml-[68px]" : "lg:ml-64",
          "pt-20"
        )}
      >
        <DashboardHeader />
        <div className="flex-1 overflow-y-auto p-4 sm:p-6 lg:p-8">{children}</div>
      </main>
    </div>
  );
};

export default DashboardLayout;
