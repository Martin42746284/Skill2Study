import Navbar from "@/components/Navbar";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Link, useNavigate } from "react-router-dom";
import { Mail, Lock, User, ArrowRight, GraduationCap, Eye, EyeOff } from "lucide-react";
import { useState } from "react";
import { useToast } from "@/hooks/use-toast";
import { useTranslation } from "react-i18next";
import { auth, setAuthToken, getRedirectPathByRole } from "@/lib/api";
import { useSettings } from "@/contexts/SettingsContext";
import Maintenance from "@/pages/Maintenance";

const Register = () => {
  const navigate = useNavigate();
  const { toast } = useToast();
  const { t } = useTranslation();
  const { settings } = useSettings();
  const [form, setForm] = useState({
    firstName: "",
    lastName: "",
    email: "",
    password: "",
    confirmPassword: "",
  });
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [loading, setLoading] = useState(false);

  const handleChange = (field: string, value: string) => {
    setForm((prev) => ({ ...prev, [field]: value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    // Block registration if maintenance mode is enabled
    if (settings.maintenance_mode) {
      toast({
        title: t("common.error"),
        description: "La plateforme est actuellement en maintenance. Les inscriptions sont fermées.",
        variant: "destructive",
      });
      return;
    }

    // Block registration if open_registration is disabled
    if (settings.open_registration === false) {
      toast({
        title: t("common.error"),
        description: "Les inscriptions sont actuellement fermées. Veuillez réessayer plus tard.",
        variant: "destructive",
      });
      return;
    }

    if (!form.firstName || !form.lastName || !form.email || !form.password) {
      toast({ title: t("common.error"), description: t("auth.register.errors.fillFields"), variant: "destructive" });
      return;
    }
    if (form.password !== form.confirmPassword) {
      toast({ title: t("common.error"), description: t("auth.register.errors.passwordMismatch"), variant: "destructive" });
      return;
    }
    if (form.password.length < 6) {
      toast({ title: t("common.error"), description: t("auth.register.errors.passwordTooShort"), variant: "destructive" });
      return;
    }
    setLoading(true);
    try {
      const response = await auth.register({
        nom: form.lastName,
        prenom: form.firstName,
        email: form.email,
        mot_de_passe: form.password,
      }) as any;
      if (response?.token) {
        // Check if email verification is required
        if (response.emailVerificationRequired) {
          toast({
            title: t("common.success"),
            description: t("auth.register.emailVerificationRequired"),
            variant: "default"
          });
          // Don't auto-login, user needs to verify email first
          // Reset form
          setForm({ firstName: "", lastName: "", email: "", password: "", confirmPassword: "" });
          // Redirect to check email page
          navigate("/check-email");
          return;
        }

        setAuthToken(response.token, response.user);
        localStorage.setItem("orientai_user", JSON.stringify(response.user));
        toast({ title: t("auth.register.errors.success"), description: t("auth.register.errors.successMsg") });

        // Redirect based on user role
        const redirectPath = getRedirectPathByRole(response.user?.role);
        navigate(redirectPath);
      }
    } catch (error) {
      toast({
        title: t("auth.register.errors.error"),
        description: error instanceof Error ? error.message : t("auth.register.errors.errorMsg"),
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex flex-col min-h-screen bg-background">
      <Navbar />
      <div className="flex-1 flex items-center justify-center px-3 sm:px-4 pt-20 sm:pt-24 pb-6 sm:pb-8">
        <div className="w-full max-w-md animate-fade-in">
          <div className="rounded-2xl border bg-card p-5 sm:p-6 shadow-card">
            <div className="mb-4 text-center">
              <div className="mx-auto mb-3 inline-flex items-center justify-center rounded-lg bg-white p-1.5">
                <img
                  src="/logo.png"
                  alt="Logo"
                  className="h-14 w-14 rounded-md object-cover"
                  onError={(e) => {
                    (e.target as HTMLImageElement).style.display = 'none';
                  }}
                />
              </div>
              <h1 className="text-lg font-bold">{t("auth.register.title")}</h1>
              <p className="mt-1 text-xs text-muted-foreground">
                {t("auth.register.subtitle")}
              </p>
            </div>

            <form className="space-y-3" onSubmit={handleSubmit}>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div className="space-y-1.5">
                  <Label htmlFor="firstName" className="text-xs">{t("auth.register.firstName")}</Label>
                  <div className="relative">
                    <User className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                    <Input id="firstName" placeholder={t("auth.register.firstNamePlaceholder")} className="pl-10 h-9 text-xs" value={form.firstName} onChange={(e) => handleChange("firstName", e.target.value)} />
                  </div>
                </div>
                <div className="space-y-1.5">
                  <Label htmlFor="lastName" className="text-xs">{t("auth.register.lastName")}</Label>
                  <Input id="lastName" placeholder={t("auth.register.lastNamePlaceholder")} className="h-9 text-xs" value={form.lastName} onChange={(e) => handleChange("lastName", e.target.value)} />
                </div>
              </div>

              <div className="space-y-1.5">
                <Label htmlFor="email" className="text-xs">{t("auth.register.email")}</Label>
                <div className="relative">
                  <Mail className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                  <Input id="email" type="email" placeholder={t("auth.register.emailPlaceholder")} className="pl-10 h-9 text-xs" value={form.email} onChange={(e) => handleChange("email", e.target.value)} />
                </div>
              </div>

              <div className="space-y-1.5">
                <Label htmlFor="password" className="text-xs">{t("auth.register.password")}</Label>
                <div className="relative">
                  <Lock className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                  <Input
                    id="password"
                    type={showPassword ? "text" : "password"}
                    placeholder={t("auth.register.passwordPlaceholder")}
                    className="pl-10 pr-10 h-9 text-xs"
                    value={form.password}
                    onChange={(e) => handleChange("password", e.target.value)}
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

              <div className="space-y-1.5">
                <Label htmlFor="confirmPassword" className="text-xs">{t("auth.register.confirmPassword")}</Label>
                <div className="relative">
                  <Lock className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                  <Input
                    id="confirmPassword"
                    type={showConfirmPassword ? "text" : "password"}
                    placeholder={t("auth.register.confirmPasswordPlaceholder")}
                    className="pl-10 pr-10 h-9 text-xs"
                    value={form.confirmPassword}
                    onChange={(e) => handleChange("confirmPassword", e.target.value)}
                  />
                  <button
                    type="button"
                    onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
                  >
                    {showConfirmPassword ? (
                      <EyeOff className="h-4 w-4" />
                    ) : (
                      <Eye className="h-4 w-4" />
                    )}
                  </button>
                </div>
              </div>

              <Button variant="hero" size="sm" className="w-full text-xs mt-1.5" disabled={loading}>
                {loading ? `${t("auth.register.signUp")}…` : t("auth.register.signUp")}
                {!loading && <ArrowRight className="ml-1 h-4 w-4" />}
              </Button>
            </form>

            <p className="mt-2 text-center text-xs text-muted-foreground">
              {t("auth.register.haveAccount")}{" "}
              <Link to="/login" className="font-medium text-primary hover:underline">
                {t("auth.register.loginLink")}
              </Link>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Register;
