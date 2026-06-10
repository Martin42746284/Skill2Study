import { ReactNode, useState } from "react";
import { Link, useLocation } from "react-router-dom";
import {
  LayoutDashboard,
  Users,
  ClipboardCheck,
  Settings,
  LogOut,
  Menu,
  X,
  Building2,
  MessageSquare,
  BookOpen,
  Moon,
  Sun,
  Globe,
} from "lucide-react";
import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";
import { useSettings } from "@/contexts/SettingsContext";
import { useTheme } from "@/hooks/use-theme";
import { useI18n } from "@/hooks/use-i18n";
import AdminHeader from "@/components/AdminHeader";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Avatar, AvatarImage, AvatarFallback } from "@/components/ui/avatar";
import { getCurrentUser, auth } from "@/lib/api";

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

interface MobileHeaderProps {
  mobileOpen: boolean;
  setMobileOpen: (open: boolean) => void;
  platformName: string;
}

const MobileHeader = ({ mobileOpen, setMobileOpen, platformName }: MobileHeaderProps) => {
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
      <Link to="/admin" className="flex items-center gap-2 flex-1 ml-2">
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

        {/* Profile Avatar */}
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button
              variant="ghost"
              className="h-11 px-2 hover:bg-accent transition-colors"
            >
              <Avatar className="h-8 w-8">
                <AvatarImage
                  src={`https://avatar.vercel.sh/${user?.email}`}
                  alt={`${user?.prenom} ${user?.nom}`}
                />
                <AvatarFallback className="bg-primary/20 text-primary text-xs font-semibold">
                  {getInitials(user?.nom, user?.prenom)}
                </AvatarFallback>
              </Avatar>
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end" className="w-56">
            <div className="flex items-center gap-3 px-4 py-3">
              <Avatar className="h-10 w-10">
                <AvatarImage
                  src={`https://avatar.vercel.sh/${user?.email}`}
                  alt={`${user?.prenom} ${user?.nom}`}
                />
                <AvatarFallback className="bg-primary/20 text-primary font-semibold">
                  {getInitials(user?.nom, user?.prenom)}
                </AvatarFallback>
              </Avatar>
              <div className="min-w-0 flex-1">
                <p className="text-sm font-semibold truncate">
                  {user?.prenom} {user?.nom}
                </p>
                <p className="text-xs text-muted-foreground truncate">
                  {user?.email}
                </p>
              </div>
            </div>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>
    </div>
  );
};

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
    <div className="flex flex-col h-full">
      <div className="flex h-20 items-center justify-between border-b px-4 shrink-0">
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
              <span className="text-xs text-muted-foreground font-medium">{t("admin.administration")}</span>
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
          {!collapsed && <span>{t("admin.sidebar.logout")}</span>}
        </Link>
      </div>
    </div>
  );

  return (
    <div className="flex min-h-screen w-full bg-background">
      {/* Mobile Header with Controls */}
      <MobileHeader
        mobileOpen={mobileOpen}
        setMobileOpen={setMobileOpen}
        platformName={settings.platform_name}
      />

      {mobileOpen && (
        <div
          className="fixed inset-0 z-40 bg-foreground/20 backdrop-blur-sm lg:hidden"
          onClick={() => setMobileOpen(false)}
        />
      )}

      <aside
        className={cn(
          "hidden lg:flex fixed left-0 top-0 z-50 h-full flex-col border-r bg-card transition-all duration-300",
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
          "pt-20"
        )}
      >
        <AdminHeader />
        <div className="flex-1 overflow-y-auto p-4 sm:p-6 lg:p-8">{children}</div>
      </main>
    </div>
  );
};

export default AdminLayout;
