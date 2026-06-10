import { useI18n } from "@/hooks/use-i18n";
import { useTheme } from "@/hooks/use-theme";
import { getCurrentUser, auth } from "@/lib/api";
import { useNavigate, useLocation } from "react-router-dom";
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
import { Moon, Sun, Globe, LogOut } from "lucide-react";
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

  const getInitials = (firstName?: string, lastName?: string) => {
    const first = firstName?.[0] || "";
    const last = lastName?.[0] || "";
    return (first + last).toUpperCase();
  };

  return (
    <header className="sticky top-0 z-40 border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div className="flex h-16 items-center justify-between px-4 sm:px-6 lg:px-8 gap-6">
        {/* Left side - Page title & description */}
        <div className="hidden sm:flex flex-col min-w-0 flex-1">
          <h1 className="text-lg font-semibold text-foreground truncate">
            {currentPage.title}
          </h1>
          <p className="text-xs text-muted-foreground truncate">
            {currentPage.description}
          </p>
        </div>

        {/* Center - Counter badge (Desktop only) */}
        {count !== undefined && countLabel && (
          <div className="hidden md:flex items-center px-4 py-1.5 rounded-lg bg-accent/30 border border-accent/50">
            <span className="text-sm font-medium text-muted-foreground">
              {count} {countLabel}
            </span>
          </div>
        )}

        {/* Right side - Controls */}
        <div className="flex items-center gap-2 sm:gap-3">
          {/* Language Dropdown */}
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button
                variant="ghost"
                size="icon"
                className="h-10 w-10 hover:bg-accent transition-colors"
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
                className={cn(
                  "cursor-pointer",
                  currentLanguage === "fr" && "bg-accent"
                )}
              >
                <span className="text-sm">🇫🇷 {t("language.french")}</span>
              </DropdownMenuItem>
              <DropdownMenuItem
                onClick={() => changeLanguage("en")}
                className={cn(
                  "cursor-pointer",
                  currentLanguage === "en" && "bg-accent"
                )}
              >
                <span className="text-sm">🇬🇧 {t("language.english")}</span>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>

          {/* Theme Dropdown */}
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button
                variant="ghost"
                size="icon"
                className="h-10 w-10 hover:bg-accent transition-colors"
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
            <DropdownMenuContent align="end" className="w-48">
              <DropdownMenuLabel className="text-xs font-semibold">
                {t("theme.toggleTheme")}
              </DropdownMenuLabel>
              <DropdownMenuSeparator />
              <DropdownMenuItem
                onClick={() => setTheme("light")}
                className={cn(
                  "cursor-pointer",
                  theme === "light" && "bg-accent"
                )}
              >
                <Sun className="h-4 w-4 mr-2" />
                <span className="text-sm">{t("theme.light")}</span>
              </DropdownMenuItem>
              <DropdownMenuItem
                onClick={() => setTheme("dark")}
                className={cn("cursor-pointer", theme === "dark" && "bg-accent")}
              >
                <Moon className="h-4 w-4 mr-2" />
                <span className="text-sm">{t("theme.dark")}</span>
              </DropdownMenuItem>
              <DropdownMenuItem
                onClick={() => setTheme("system")}
                className={cn(
                  "cursor-pointer",
                  theme === "system" && "bg-accent"
                )}
              >
                <span className="text-sm mr-2">⚙️</span>
                <span className="text-sm">{t("theme.system")}</span>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>

          {/* Admin Profile Dropdown */}
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button
                variant="ghost"
                className="h-10 px-2 sm:px-3 flex items-center gap-2 hover:bg-accent transition-colors"
              >
                <Avatar className="h-8 w-8">
                  <AvatarImage
                    src={user?.avatar || `https://avatar.vercel.sh/${user?.email}`}
                    alt={`${user?.firstName} ${user?.lastName}`}
                  />
                  <AvatarFallback className="bg-primary/20 text-primary text-xs font-semibold">
                    {getInitials(user?.firstName, user?.lastName)}
                  </AvatarFallback>
                </Avatar>
                <div className="hidden sm:block text-left min-w-0">
                  <p className="text-sm font-medium leading-none truncate">
                    {user?.firstName}
                  </p>
                  <p className="text-xs text-muted-foreground truncate">
                    {user?.role ? user.role.charAt(0).toUpperCase() + user.role.slice(1) : ""}
                  </p>
                </div>
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="end" className="w-52">
              <DropdownMenuLabel className="text-xs font-semibold truncate">
                {user?.email}
              </DropdownMenuLabel>
            </DropdownMenuContent>
          </DropdownMenu>
        </div>
      </div>
    </header>
  );
};

export default AdminHeader;
