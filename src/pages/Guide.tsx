import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import { Card, CardContent } from "@/components/ui/card";
import { UserPlus, ClipboardList, BarChart3, MapPin, GitCompare, GraduationCap } from "lucide-react";
import { useTranslation } from "react-i18next";
import { Link } from "react-router-dom";

const iconMap = {
  UserPlus,
  ClipboardList,
  BarChart3,
  GraduationCap,
  GitCompare,
  MapPin,
};

const Guide = () => {
  const { t } = useTranslation();

  const steps = t("guide.steps", { returnObjects: true }) as Array<{
    title: string;
    description: string;
  }>;

  const stepIcons = [UserPlus, ClipboardList, BarChart3, GraduationCap, GitCompare, MapPin];

  return (
    <div className="min-h-screen bg-background">
      <Navbar />
      <main className="container mx-auto px-4 pt-24 pb-16">
        <div className="max-w-4xl mx-auto">
          <div className="text-center mb-12">
            <h1 className="text-4xl font-bold mb-4">{t("guide.title")}</h1>
            <p className="text-lg text-muted-foreground">
              {t("guide.description")}
            </p>
          </div>

          <div className="space-y-6">
            {steps.map((step, index) => {
              const IconComponent = stepIcons[index];
              return (
                <Card key={index} className="overflow-hidden">
                  <CardContent className="p-6 flex gap-5 items-start">
                    <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-primary/10 text-primary">
                      <IconComponent className="h-6 w-6" />
                    </div>
                    <div>
                      <h3 className="text-lg font-semibold mb-1">{step.title}</h3>
                      <p className="text-muted-foreground leading-relaxed">{step.description}</p>
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>

          <Card className="mt-12 bg-primary/5 border-primary/20">
            <CardContent className="p-6 text-center">
              <h3 className="text-lg font-semibold mb-2">{t("guide.needHelp")}</h3>
              <p className="text-muted-foreground">
                {t("common.consultOur") || "Consult our"} <Link to="/faq" className="text-primary hover:underline font-medium">{t("guide.faqLink")}</Link> {t("common.or") || "or contact us at"} <span className="text-primary font-medium">{t("guide.contactEmail")}</span>
              </p>
            </CardContent>
          </Card>
        </div>
      </main>
      <Footer />
    </div>
  );
};

export default Guide;
