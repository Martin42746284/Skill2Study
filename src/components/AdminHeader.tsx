import { useI18n } from "@/hooks/use-i18n";
import { useTheme } from "@/hooks/use-theme";
import { getCurrentUser, auth } from "@/lib/api";
import { useNavigate, useLocation, Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
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
import { adminPages } from "@/config/adminPages";

interface AdminHeaderProps {
  count?: number;
  countLabel?: string;
}

const AdminHeader = ({ count, countLabel }: AdminHeaderProps) => {
  const { currentLanguage, changeLanguage } = useI18n();
  const { theme, setTheme } = useTheme();
  const { t } = useTranslation();
  const navigate = useNavigate();
  const location = useLocation();
  const user = getCurrentUser();

  const pageConfig = adminPages[location.pathname] || {
    titleKey: "admin.administration",
    descriptionKey: "admin.administration",
  };

  const currentPage = {
    title: t(pageConfig.titleKey),
    description: t(pageConfig.descriptionKey),
  };

  const handleLogout = async () => {
    await auth.logout();
    navigate("/login");
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
          <h1 className="text-2xl font-bold text-foreground truncate">
            {currentPage.title}
          </h1>
          <p className="text-base text-muted-foreground truncate">
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

          {/* Profile Avatar */}
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button
                variant="ghost"
                className="h-12 px-3 hover:bg-accent transition-colors"
              >
                <Avatar className="h-9 w-9">
                  <AvatarImage
                    src={`${user?.email}`}
                    alt={`${user?.prenom} ${user?.nom}`}
                  />
                  <AvatarFallback className="bg-primary/20 text-primary text-sm font-semibold">
                    {getInitials(user?.nom, user?.prenom)}
                  </AvatarFallback>
                </Avatar>
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="end" className="w-56">
              <div className="flex items-center gap-3 px-4 py-3">
                <Avatar className="h-10 w-10">
                  <AvatarImage
                    src={`${user?.email}`}
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
    </header>
  );
};

export default AdminHeader;
