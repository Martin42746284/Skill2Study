import { useEffect, useState } from "react";
import { useSearchParams, useNavigate } from "react-router-dom";
import { useToast } from "@/hooks/use-toast";
import { useTranslation } from "react-i18next";
import { Loader2, CheckCircle, XCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import Navbar from "@/components/Navbar";
import { auth } from "@/lib/api";

const VerifyEmail = () => {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const { toast } = useToast();
  const { t } = useTranslation();
  const [verifying, setVerifying] = useState(true);
  const [success, setSuccess] = useState(false);
  const [alreadyVerified, setAlreadyVerified] = useState(false);
  const token = searchParams.get("token");

  useEffect(() => {
    const verifyEmail = async () => {
      if (!token) {
        setVerifying(false);
        setSuccess(false);
        return;
      }

      try {
        await auth.verifyEmail(token);
        setSuccess(true);
        toast({
          title: t("common.success"),
          description: t("auth.verifyEmail.success"),
        });
        // Redirect to login after 2 seconds
        setTimeout(() => {
          navigate("/login");
        }, 2000);
      } catch (error) {
        const errorMsg = error instanceof Error ? error.message : t("auth.verifyEmail.error");

        // Check if error is "Token invalid" which might mean already verified
        if (errorMsg.includes("invalide") || errorMsg.includes("invalid")) {
          setAlreadyVerified(true);
        } else {
          setSuccess(false);
        }

        // Only show error toast if not already verified
        if (!alreadyVerified) {
          toast({
            title: t("common.error"),
            description: errorMsg,
            variant: "destructive",
          });
        }
      } finally {
        setVerifying(false);
      }
    };

    verifyEmail();
  }, [token, navigate, toast, t]);

  return (
    <div className="min-h-screen bg-background">
      <Navbar />
      <div className="flex min-h-screen items-center justify-center px-4 pt-16">
        <div className="w-full max-w-md animate-fade-in text-center">
          {verifying ? (
            <div className="space-y-4">
              <Loader2 className="h-16 w-16 animate-spin text-primary mx-auto" />
              <h1 className="text-2xl font-bold">{t("common.loading")}</h1>
              <p className="text-muted-foreground">
                {t("auth.verifyEmail.description")}
              </p>
            </div>
          ) : success ? (
            <div className="space-y-4">
              <CheckCircle className="h-16 w-16 text-green-500 mx-auto" />
              <h1 className="text-2xl font-bold">{t("auth.verifyEmail.successTitle")}</h1>
              <p className="text-muted-foreground">
                {t("auth.verifyEmail.successDesc")}
              </p>
              <p className="text-sm text-muted-foreground">
                Redirection vers la connexion...
              </p>
            </div>
          ) : alreadyVerified ? (
            <div className="space-y-4">
              <CheckCircle className="h-16 w-16 text-green-500 mx-auto" />
              <h1 className="text-2xl font-bold">{t("auth.verifyEmail.successTitle")}</h1>
              <p className="text-muted-foreground">
                {t("auth.verifyEmail.successDesc")}
              </p>
              <Button onClick={() => navigate("/login")}>
                {t("auth.verifyEmail.backToLogin")}
              </Button>
            </div>
          ) : (
            <div className="space-y-4">
              <XCircle className="h-16 w-16 text-destructive mx-auto" />
              <h1 className="text-2xl font-bold">{t("common.error")}</h1>
              <p className="text-muted-foreground">
                {t("auth.verifyEmail.invalidToken")}
              </p>
              <Button onClick={() => navigate("/login")}>
                {t("auth.verifyEmail.backToLogin")}
              </Button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default VerifyEmail;
