import { Menu, X } from "lucide-react";
import { Link, useLocation } from "react-router-dom";
import { useState } from "react";
import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";
import { useSettings } from "@/contexts/SettingsContext";
import { useTheme } from "@/hooks/use-theme";
import { ThemeToggle } from "@/components/ThemeToggle";
import { LanguageToggle } from "@/components/LanguageToggle";
import NotificationDropdown from "@/components/NotificationDropdown";

interface NavItemProps {
  to: string;
  label: string;
  isActive?: boolean;
  onClick?: () => void;
  isMobile?: boolean;
}

const NavItem = ({ to, label, isActive, onClick, isMobile = false }: NavItemProps) => {
  return (
    <Link
      to={to}
      onClick={onClick}
      className={cn(
        "relative font-semibold transition-all duration-300",
        isMobile ? "block rounded-lg px-4 py-2.5 text-base" : "px-2 text-sm lg:text-base",
        isActive
          ? isMobile
            ? "bg-accent text-accent-foreground"
            : "text-foreground"
          : "text-muted-foreground hover:text-foreground"
      )}
    >
      {label}
      {isActive && !isMobile && (
        <div className="absolute bottom-0 left-0 right-0 h-0.5 bg-gradient-to-r from-primary to-accent rounded-full" />
      )}
    </Link>
  );
};

const Navbar = () => {
  const [mobileOpen, setMobileOpen] = useState(false);
  const { settings } = useSettings();
  const { theme } = useTheme();
  const location = useLocation();
  const { t } = useTranslation();

  const isActive = (path: string) => location.pathname === path;

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 glass border-b border-border/50">
      <div className="flex h-20 items-center justify-between px-3 sm:px-4 md:px-6 lg:px-8">
        <Link to="/" className="flex items-center gap-3 flex-shrink-0 hover:opacity-80 transition-opacity">
          <div className="flex items-center justify-center rounded-lg bg-white p-1.5 flex-shrink-0">
            <img
              src="/logo.png"
              alt={settings.platform_name}
              className="h-12 w-12 object-contain rounded-md"
            />
          </div>
          <span className={cn("text-xl font-bold hidden sm:inline", theme === "dark" ? "text-white" : "text-foreground")}>{settings.platform_name}</span>
        </Link>

        {/* Desktop nav */}
        <div className="hidden items-center gap-2 md:flex md:flex-1 md:justify-center">
          <NavItem to="/" label={t("nav.home")} isActive={isActive("/")} />
          <NavItem to="/about" label={t("nav.howItWorks")} isActive={isActive("/about")} />
          <NavItem to="/login" label={t("nav.login")} isActive={isActive("/login")} />
        </div>

        {/* Register button, language, theme toggle and notifications - Desktop */}
        <div className="hidden md:flex md:items-center md:gap-3">
          <NotificationDropdown />
          <LanguageToggle />
          <ThemeToggle />
          <Link to="/register">
            <button className="inline-flex h-12 items-center justify-center rounded-lg bg-gradient-to-r from-primary to-accent px-6 text-sm font-semibold text-primary-foreground shadow-sm hover:shadow-md hover:shadow-primary/50 transition-all duration-300 hover:scale-105">
              {t("nav.signup")}
            </button>
          </Link>
        </div>

        {/* Mobile toggles and hamburger */}
        <div className="flex items-center gap-2 md:hidden">
          <NotificationDropdown />
          <LanguageToggle />
          <ThemeToggle />
          <button
            onClick={() => setMobileOpen(!mobileOpen)}
            className="flex h-11 w-11 items-center justify-center rounded-lg text-foreground hover:bg-accent hover:text-accent-foreground transition-colors flex-shrink-0"
            aria-label="Menu"
          >
            {mobileOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
          </button>
        </div>
      </div>

      {/* Mobile menu */}
      <div
        className={cn(
          "md:hidden overflow-hidden transition-all duration-300 border-t bg-card/95 backdrop-blur-lg",
          mobileOpen ? "max-h-80 opacity-100" : "max-h-0 opacity-0 border-t-0"
        )}
      >
        <div className="flex flex-col gap-2 px-4 sm:px-6 lg:px-8 py-4">
          <NavItem
            to="/"
            label={t("nav.home")}
            isActive={isActive("/")}
            onClick={() => setMobileOpen(false)}
            isMobile
          />
          <NavItem
            to="/about"
            label={t("nav.howItWorks")}
            isActive={isActive("/about")}
            onClick={() => setMobileOpen(false)}
            isMobile
          />
          <NavItem
            to="/login"
            label={t("nav.login")}
            isActive={isActive("/login")}
            onClick={() => setMobileOpen(false)}
            isMobile
          />
          <Link to="/register" onClick={() => setMobileOpen(false)}>
            <button className="mt-3 w-full rounded-lg bg-gradient-to-r from-primary to-accent px-5 py-3 text-base font-semibold text-primary-foreground shadow-sm hover:shadow-md hover:shadow-primary/50 transition-all duration-300">
              {t("nav.signup")}
            </button>
          </Link>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
