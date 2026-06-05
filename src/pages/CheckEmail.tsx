import { Mail, ArrowRight } from "lucide-react";
import { Button } from "@/components/ui/button";
import Navbar from "@/components/Navbar";
import { useNavigate } from "react-router-dom";
import { useTranslation } from "react-i18next";

const CheckEmail = () => {
  const navigate = useNavigate();
  const { t } = useTranslation();

  return (
    <div className="min-h-screen bg-background">
      <Navbar />
      <div className="flex min-h-screen items-center justify-center px-4 pt-16">
        <div className="w-full max-w-md animate-fade-in">
          <div className="rounded-2xl border bg-card p-8 shadow-card">
            <div className="mb-8 text-center">
              <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-xl bg-primary">
                <Mail className="h-7 w-7 text-primary-foreground" />
              </div>
              <h1 className="text-2xl font-bold">{t("auth.checkEmail.title")}</h1>
              <p className="mt-4 text-muted-foreground">
                {t("auth.checkEmail.description")}
              </p>
            </div>

            <div className="space-y-4">
              <div className="rounded-lg bg-blue-50 p-4 text-sm text-blue-800 dark:bg-blue-900 dark:text-blue-200">
                {t("auth.checkEmail.hint")}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CheckEmail;
