import Navbar from "@/components/Navbar";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { GoogleSignInButton } from "@/components/GoogleSignInButton";
import { Link, useNavigate } from "react-router-dom";
import { Mail, Lock, ArrowRight, Eye, EyeOff } from "lucide-react";
import { useState } from "react";
import { useToast } from "@/hooks/use-toast";
import { useTranslation } from "react-i18next";
import { auth, setAuthToken, getRedirectPathByRole } from "@/lib/api";
import { useSettings } from "@/contexts/SettingsContext";
import Maintenance from "@/pages/Maintenance";

const Login = () => {
  const navigate = useNavigate();
  const { toast } = useToast();
  const { t } = useTranslation();
  const { settings } = useSettings();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email || !password) {
      toast({ title: t("common.error"), description: t("auth.login.errors.fillFields"), variant: "destructive" });
      return;
    }
    setLoading(true);
    try {
      const response = await auth.login(email, password) as any;
      if (response?.token) {
        // Check if maintenance mode is enabled and user is not admin
        if (settings.maintenance_mode && response.user?.role !== 'admin') {
          toast({
            title: t("common.error"),
            description: t("maintenance.title"),
            variant: "destructive",
          });
          // Redirect to maintenance page after short delay
          setTimeout(() => {
            navigate("/maintenance");
          }, 1000);
          setLoading(false);
          return;
        }

        setAuthToken(response.token, response.user);
        localStorage.setItem("orientai_user", JSON.stringify(response.user));
        toast({ title: t("auth.login.errors.success"), description: t("auth.login.errors.successMsg") });

        // Redirect based on user role
        const redirectPath = getRedirectPathByRole(response.user?.role);
        navigate(redirectPath);
      }
    } catch (error) {
      toast({
        title: t("auth.login.errors.error"),
        description: error instanceof Error ? error.message : t("auth.login.errors.errorMsg"),
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-background">
      <Navbar />
      <div className="flex min-h-screen items-center justify-center px-3 sm:px-4 pt-16">
        <div className="w-full max-w-md animate-fade-in">
          <div className="rounded-2xl border bg-card p-6 sm:p-8 shadow-card">
            <div className="mb-6 sm:mb-8 text-center">
              <div className="mx-auto mb-4 inline-flex items-center justify-center rounded-xl bg-white p-2">
                <img
                  src="/logo.png"
                  alt="Logo"
                  className="h-32 sm:h-40 w-32 sm:w-40 rounded-lg object-cover"
                  onError={(e) => {
                    (e.target as HTMLImageElement).style.display = 'none';
                  }}
                />
              </div>
              <h1 className="text-xl sm:text-2xl font-bold">{t("auth.login.title")}</h1>
              <p className="mt-2 text-xs sm:text-sm text-muted-foreground">
                {t("auth.login.subtitle")}
              </p>
            </div>

            <form className="space-y-4 sm:space-y-5" onSubmit={handleSubmit}>
              <div className="space-y-2">
                <Label htmlFor="email" className="text-sm">{t("auth.login.email")}</Label>
                <div className="relative">
                  <Mail className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                  <Input
                    id="email"
                    type="email"
                    placeholder={t("auth.login.emailPlaceholder")}
                    className="pl-10 text-sm"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                  />
                </div>
              </div>

              <div className="space-y-2">
                <div className="flex items-center justify-between">
                  <Label htmlFor="password" className="text-sm">{t("auth.login.password")}</Label>
                  <Link to="/forgot-password" className="text-xs text-primary hover:underline">
                    {t("auth.login.forgotPassword")}
                  </Link>
                </div>
                <div className="relative">
                  <Lock className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                  <Input
                    id="password"
                    type={showPassword ? "text" : "password"}
                    placeholder={t("auth.login.passwordPlaceholder")}
                    className="pl-10 pr-10 text-sm"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
                  >
                    {showPassword ? (
                      <EyeOff className="h-4 w-4" />
                    ) : (
                      <Eye className="h-4 w-4" />
                    )}
                  </button>
                </div>
              </div>

              <Button variant="hero" size="lg" className="w-full text-sm sm:text-base" disabled={loading}>
                {loading ? `${t("auth.login.signIn")}…` : t("auth.login.signIn")}
                {!loading && <ArrowRight className="ml-1 h-4 w-4" />}
              </Button>
            </form>

            <div className="mt-6 sm:mt-7">
              <div className="relative mb-6">
                <div className="absolute inset-0 flex items-center">
                  <div className="w-full border-t border-muted-foreground/20"></div>
                </div>
                <div className="relative flex justify-center text-xs sm:text-sm">
                  <span className="bg-card px-2 text-muted-foreground">{t("auth.login.or")}</span>
                </div>
              </div>
              <GoogleSignInButton />
            </div>

            <p className="mt-4 sm:mt-6 text-center text-xs sm:text-sm text-muted-foreground">
              {t("auth.login.noAccount")}{" "}
              <Link to="/register" className="font-medium text-primary hover:underline">
                {t("auth.login.signUpLink")}
              </Link>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Login;
