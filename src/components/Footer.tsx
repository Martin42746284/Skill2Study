import { Brain, Mail, Phone, MapPin } from "lucide-react";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";

const Footer = () => {
  const { t } = useTranslation();

  return (
    <footer className="border-t bg-card">
      <div className="container mx-auto px-3 sm:px-4 md:px-6 lg:px-8 py-8 sm:py-10 lg:py-12">
        <div className="grid gap-6 sm:gap-8 grid-cols-1 sm:grid-cols-2 lg:grid-cols-4">
          <div className="sm:col-span-2 lg:col-span-1">
            <div className="flex items-center gap-2 mb-4">
              <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-primary shrink-0">
                <Brain className="h-5 w-5 text-primary-foreground" />
              </div>
              <span className="text-base sm:text-lg font-bold">Skill2Study</span>
            </div>
            <p className="text-xs sm:text-sm text-muted-foreground leading-relaxed">
              {t("footer.description")}
            </p>
          </div>

          <div>
            <h4 className="text-sm sm:text-base font-semibold mb-3 sm:mb-4">{t("footer.platform.title")}</h4>
            <ul className="space-y-2 text-xs sm:text-sm text-muted-foreground">
              <li><Link to="/tests" className="hover:text-foreground transition-colors">{t("footer.platform.test")}</Link></li>
              <li><Link to="/recommendations" className="hover:text-foreground transition-colors">{t("footer.platform.recommendations")}</Link></li>
              <li><Link to="/compare" className="hover:text-foreground transition-colors">{t("footer.platform.compare")}</Link></li>
            </ul>
          </div>

          <div>
            <h4 className="text-sm sm:text-base font-semibold mb-3 sm:mb-4">{t("footer.resources.title")}</h4>
            <ul className="space-y-2 text-xs sm:text-sm text-muted-foreground">
              <li><Link to="/guide" className="hover:text-foreground transition-colors">{t("footer.resources.guide")}</Link></li>
              <li><Link to="/faq" className="hover:text-foreground transition-colors">{t("footer.resources.faq")}</Link></li>
              <li><Link to="/blog" className="hover:text-foreground transition-colors">{t("footer.resources.blog")}</Link></li>
            </ul>
          </div>

          <div>
            <h4 className="text-sm sm:text-base font-semibold mb-3 sm:mb-4">{t("footer.contact.title")}</h4>
            <ul className="space-y-2 text-xs sm:text-sm text-muted-foreground">
              <li className="flex items-center gap-2"><Mail className="h-4 w-4 shrink-0" /> <span>{t("footer.contact.email")}</span></li>
              <li className="flex items-center gap-2"><Phone className="h-4 w-4 shrink-0" /> <span>{t("footer.contact.phone")}</span></li>
              <li className="flex items-center gap-2"><MapPin className="h-4 w-4 shrink-0" /> <span>{t("footer.contact.location")}</span></li>
            </ul>
          </div>
        </div>

        <div className="mt-6 sm:mt-8 lg:mt-10 border-t pt-4 sm:pt-6 text-center text-xs sm:text-sm text-muted-foreground">
          <p>{t("footer.copyright")}</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
