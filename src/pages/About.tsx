import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import AnimatedSection from "@/components/AnimatedSection";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import {
  Brain,
  Target,
  GraduationCap,
  CheckCircle2,
  ArrowRight,
  Globe,
  Shield,
  Lightbulb,
  Sparkles,
} from "lucide-react";

const About = () => {
  const { t } = useTranslation();

  const values = [
    {
      icon: Target,
      title: t("about.valueAccuracy"),
      description: t("about.valueAccuracyDesc"),
    },
    {
      icon: Shield,
      title: t("about.valuePrivacy"),
      description: t("about.valuePrivacyDesc"),
    },
    {
      icon: Globe,
      title: t("about.valueAccessibility"),
      description: t("about.valueAccessibilityDesc"),
    },
    {
      icon: Lightbulb,
      title: t("about.valueInnovation"),
      description: t("about.valueInnovationDesc"),
    },
  ];

  const stats = [
    { value: "10+", label: t("about.statsUniversities") },
    { value: "50+", label: t("about.statsFields") },
    { value: "2 000+", label: t("about.statsStudents") },
    { value: "94%", label: t("about.statsSatisfaction") },
  ];
  return (
    <div className="min-h-screen bg-background">
      <Navbar />

      {/* Hero */}
      <section className="relative pt-32 pb-20 overflow-hidden">
        <div className="absolute top-20 right-10 w-72 h-72 bg-primary/10 rounded-full blur-3xl animate-pulse" />
        <div className="absolute bottom-0 left-10 w-72 h-72 bg-accent/10 rounded-full blur-3xl animate-pulse delay-700" />

        <div className="container relative mx-auto px-4 text-center">
          <AnimatedSection>
            <div className="mx-auto mb-6 inline-flex h-16 w-16 items-center justify-center rounded-2xl bg-gradient-to-br from-primary to-accent shadow-lg">
              <Brain className="h-8 w-8 text-primary-foreground" />
            </div>
            <h1 className="text-5xl md:text-6xl font-bold mb-6">
              {t("about.title").split("d'")[0]}d'<span className="bg-gradient-to-r from-primary via-accent to-primary bg-clip-text text-transparent">Skill2Study</span>
            </h1>
            <p className="max-w-3xl mx-auto text-xl text-muted-foreground leading-relaxed">
              {t("about.description")}
            </p>
          </AnimatedSection>
        </div>
      </section>

      {/* Stats */}
      <section className="py-20 bg-gradient-to-br from-card via-background to-card border-y border-border/50">
        <div className="container mx-auto px-4">
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            {stats.map((s, i) => (
              <AnimatedSection key={s.label} delay={i * 0.1}>
                <div className="relative group">
                  <div className="absolute inset-0 bg-gradient-to-r from-primary/10 to-accent/10 rounded-xl opacity-0 group-hover:opacity-100 transition-opacity duration-300 blur-lg" />
                  <div className="relative text-center p-8 rounded-xl border bg-background/50 backdrop-blur-sm shadow-card hover:shadow-lg transition-all duration-300">
                    <p className="text-4xl md:text-5xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">{s.value}</p>
                    <p className="mt-2 text-sm font-medium text-muted-foreground">{s.label}</p>
                  </div>
                </div>
              </AnimatedSection>
            ))}
          </div>
        </div>
      </section>

      {/* Mission */}
      <section className="py-24">
        <div className="container mx-auto px-4">
          <div className="grid gap-16 lg:grid-cols-2 items-center">
            <AnimatedSection direction="left">
              <div className="mb-6 inline-flex items-center gap-2 rounded-full bg-accent/20 border border-accent/30 px-4 py-2 text-sm font-semibold text-foreground">
                <Sparkles className="h-4 w-4" />
                {t("about.missionLabel")}
              </div>

              <h2 className="text-4xl md:text-5xl font-bold mb-6">{t("about.missionTitle")}</h2>

              <p className="text-lg text-muted-foreground leading-relaxed mb-8">
                {t("about.missionDescription")}
              </p>

              <ul className="space-y-4">
                {[
                  t("about.missionItem1"),
                  t("about.missionItem2"),
                  t("about.missionItem3"),
                  t("about.missionItem4"),
                ].map((item) => (
                  <li key={item} className="flex items-start gap-3 text-base text-muted-foreground">
                    <CheckCircle2 className="h-5 w-5 text-success shrink-0 mt-1" />
                    <span className="font-medium">{item}</span>
                  </li>
                ))}
              </ul>
            </AnimatedSection>

            <AnimatedSection direction="right" delay={0.2}>
              <div className="grid gap-5 sm:grid-cols-2">
                {values.map((v, i) => (
                  <div
                    key={v.title}
                    className="group relative rounded-2xl border bg-card/50 backdrop-blur-sm p-7 shadow-card hover:shadow-lg transition-all duration-300 overflow-hidden"
                  >
                    <div className="absolute inset-0 bg-gradient-to-br from-primary/5 to-accent/5 opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
                    <div className="relative">
                      <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-primary/20 to-accent/20 mb-4">
                        <v.icon className="h-6 w-6 text-primary" />
                      </div>
                      <h3 className="font-bold text-lg mb-2">{v.title}</h3>
                      <p className="text-sm text-muted-foreground leading-relaxed">
                        {v.description}
                      </p>
                    </div>
                  </div>
                ))}
              </div>
            </AnimatedSection>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-24 relative overflow-hidden">
        <div className="absolute top-0 right-0 w-96 h-96 bg-primary/10 rounded-full blur-3xl -z-10" />
        <div className="absolute bottom-0 left-0 w-96 h-96 bg-accent/10 rounded-full blur-3xl -z-10" />

        <div className="container mx-auto px-4">
          <AnimatedSection>
            <div className="rounded-3xl bg-gradient-to-br from-primary via-primary/90 to-accent p-12 md:p-16 text-center text-primary-foreground shadow-2xl border border-primary/50">
              <div className="mx-auto mb-6 inline-flex h-16 w-16 items-center justify-center rounded-2xl bg-primary-foreground/20 backdrop-blur-sm">
                <GraduationCap className="h-8 w-8" />
              </div>

              <h2 className="text-4xl md:text-5xl font-bold mb-6">
                {t("about.ctaTitle")}
              </h2>

              <p className="mb-10 max-w-2xl mx-auto text-lg opacity-95 leading-relaxed">
                {t("about.ctaDescription")}
              </p>

              <Link to="/register">
                <Button variant="secondary" size="xl" className="shadow-lg hover:shadow-xl">
                  {t("about.ctaButton")}
                  <ArrowRight className="ml-2 h-5 w-5 transition-transform group-hover:translate-x-1" />
                </Button>
              </Link>
            </div>
          </AnimatedSection>
        </div>
      </section>

      <Footer />
    </div>
  );
};

export default About;
