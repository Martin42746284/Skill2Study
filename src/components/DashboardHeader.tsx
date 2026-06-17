import { useI18n } from "@/hooks/use-i18n";
import { useTheme } from "@/hooks/use-theme";
import { useCurrentUser } from "@/hooks/use-current-user";
import { useLocation, Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarImage, AvatarFallback } from "@/components/ui/avatar";
import { Moon, Sun, Globe, User } from "lucide-react";
import { cn } from "@/lib/utils";
import { dashboardPages } from "@/config/dashboardPages";

interface DashboardHeaderProps {
  count?: number;
  countLabel?: string;
}

const DashboardHeader = ({ count, countLabel }: DashboardHeaderProps) => {
  const { currentLanguage, changeLanguage } = useI18n();
  const { theme, setTheme } = useTheme();
  const { t } = useTranslation();
  const location = useLocation();
  const user = useCurrentUser();

  const pageConfig = dashboardPages[location.pathname] || {
    titleKey: "dashboard.pages.dashboard.title",
    descriptionKey: "dashboard.pages.dashboard.description",
  };

  const currentPage = {
    title: t(pageConfig.titleKey),
    description: t(pageConfig.descriptionKey),
  };

  const getInitials = (nom?: string, prenom?: string) => {
    const first = prenom?.[0] || "";
    const last = nom?.[0] || "";
    return (first + last).toUpperCase();
  };

  return (
    <header className="hidden lg:block fixed top-0 z-40 border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60 right-0" style={{ left: 'var(--sidebar-width, 0)' }}>
      <div className="flex h-20 items-center justify-between px-4 sm:px-6 lg:px-8 gap-6 w-full">
        {/* Left side - Page title & description */}
        <div className="hidden sm:flex flex-col min-w-0 flex-1">
          <h1 className="text-xl font-semibold text-foreground truncate">
            {currentPage.title}
          </h1>
          <p className="text-sm text-muted-foreground truncate">
            {currentPage.description}
          </p>
        </div>

        {/* Center - Counter badge (Desktop only) */}
        {count !== undefined && countLabel && (
          <div className="hidden md:flex items-center px-6 py-2.5 rounded-lg bg-accent/30 border border-accent/50">
            <span className="text-base font-semibold text-foreground">
              {count} {countLabel}
            </span>
          </div>
        )}

        {/* Right side - Controls */}
        <div className="flex items-center gap-3">
          {/* Language */}
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button
                variant="ghost"
                size="icon"
                className="h-12 w-12 hover:bg-accent transition-colors"
                title={t("language.toggleLanguage")}
              >
                <Globe className="h-6 w-6" />
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
                className="h-12 w-12 hover:bg-accent transition-colors"
                title={t("theme.toggleTheme")}
              >
                {theme === "dark" ? (
                  <Moon className="h-6 w-6" />
                ) : theme === "light" ? (
                  <Sun className="h-6 w-6" />
                ) : (
                  <Sun className="h-6 w-6 opacity-50" />
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
                className="h-12 px-3 hover:bg-accent transition-colors flex items-center gap-3"
              >
                {user?.avatar_url ? (
                  <img
                    src={user.avatar_url}
                    alt={`${user?.prenom} ${user?.nom}`}
                    className="h-9 w-9 rounded-full object-cover"
                  />
                ) : (
                  <Avatar className="h-9 w-9">
                    <AvatarFallback className="bg-primary/20 text-primary text-sm font-semibold">
                      {getInitials(user?.nom, user?.prenom)}
                    </AvatarFallback>
                  </Avatar>
                )}
                <div className="hidden sm:flex flex-col text-left">
                  <span className="text-xs font-medium text-muted-foreground">Connecté</span>
                  <span className="text-sm font-semibold">{user?.prenom}</span>
                </div>
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="end" className="w-56">
              <div className="flex items-center gap-3 px-4 py-3">
                {user?.avatar_url ? (
                  <img
                    src={user.avatar_url}
                    alt={`${user?.prenom} ${user?.nom}`}
                    className="h-12 w-12 rounded-full object-cover shrink-0"
                  />
                ) : (
                  <Avatar className="h-12 w-12 shrink-0">
                    <AvatarFallback className="bg-primary/20 text-primary font-semibold text-lg">
                      {getInitials(user?.nom, user?.prenom)}
                    </AvatarFallback>
                  </Avatar>
                )}
                <div className="flex flex-col min-w-0">
                  <p className="text-sm font-bold text-foreground">
                    {user?.prenom} {user?.nom}
                  </p>
                  <p className="text-xs text-muted-foreground truncate">
                    {user?.email}
                  </p>
                </div>
              </div>
              <DropdownMenuSeparator />
              <DropdownMenuItem asChild>
                <Link to="/dashboard/profile" className="cursor-pointer">
                  <div className="w-full flex items-center gap-2">
                    <User className="h-4 w-4" />
                    <span>{t("dashboard.sidebar.profile")}</span>
                  </div>
                </Link>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </div>
      </div>
    </header>
  );
};

export default DashboardHeader;
