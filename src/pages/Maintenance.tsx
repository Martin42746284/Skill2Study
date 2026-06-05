import { useSettings } from "@/contexts/SettingsContext";
import { useNavigate } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { Wrench, AlertTriangle, ArrowLeft } from "lucide-react";
import { Button } from "@/components/ui/button";

const Maintenance = () => {
  const { settings } = useSettings();
  const navigate = useNavigate();
  const { t } = useTranslation();

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 flex items-center justify-center px-4">
      <div className="max-w-md w-full text-center">
        {/* Icon */}
        <div className="flex justify-center mb-6">
          <div className="relative">
            <div className="absolute inset-0 animate-spin" style={{ animationDuration: '3s' }}>
              <div className="h-24 w-24 rounded-full border-4 border-transparent border-t-blue-500 border-r-blue-500"></div>
            </div>
            <div className="h-24 w-24 rounded-full flex items-center justify-center bg-slate-800">
              <Wrench className="h-12 w-12 text-blue-500" />
            </div>
          </div>
        </div>

        {/* Title */}
        <h1 className="text-4xl font-bold text-white mb-4">
          {t("maintenance.title")}
        </h1>

        {/* Description */}
        <p className="text-slate-300 text-lg mb-6">
          {settings.maintenance_message || t("maintenance.description")}
        </p>

        {/* Alert */}
        <div className="bg-blue-900/20 border border-blue-500/30 rounded-lg p-4 mb-8">
          <div className="flex items-start gap-3">
            <AlertTriangle className="h-5 w-5 text-blue-400 flex-shrink-0 mt-0.5" />
            <div className="text-left">
              <p className="text-blue-300 text-sm font-medium">
                {t("maintenance.message")}
              </p>
              <p className="text-blue-200 text-xs mt-1">
                {t("maintenance.thankYou")}
              </p>
            </div>
          </div>
        </div>

        {/* Platform Info */}
        <div className="text-slate-400 text-sm mb-8">
          <p className="font-semibold text-white mb-2">{settings.platform_name}</p>
          <p>{settings.platform_description}</p>
        </div>

        {/* Return Home Button */}
        <Button
          onClick={() => navigate("/")}
          className="w-full mb-6 bg-blue-600 hover:bg-blue-700 text-white"
        >
          <ArrowLeft className="h-4 w-4 mr-2" />
          {t("maintenance.returnHome")}
        </Button>

        {/* Footer */}
        <div className="pt-6 border-t border-slate-700/50">
          <p className="text-slate-500 text-xs">
            {t("maintenance.contact")}{" "}
            <a href={`mailto:${settings.contact_email}`} className="text-blue-400 hover:text-blue-300 underline">
              {settings.contact_email}
            </a>
          </p>
        </div>
      </div>
    </div>
  );
};

export default Maintenance;
