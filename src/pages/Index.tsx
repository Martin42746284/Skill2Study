import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import AnimatedSection from "@/components/AnimatedSection";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";
import { useSettings } from "@/contexts/SettingsContext";
import { useTranslation } from "react-i18next";
import {
  Brain,
  ClipboardCheck,
  BarChart3,
  GraduationCap,
  Target,
  Users,
  Sparkles,
  ArrowRight,
  CheckCircle2,
  Star,
  BookOpen,
  Lightbulb,
} from "lucide-react";
import heroImage from "@/assets/hero-illustration.png";
import { getApprovedTestimonials } from "@/data/testimonials";

const Index = () => {
  const { t } = useTranslation();
  const approvedTestimonials = getApprovedTestimonials();
  const { settings } = useSettings();

  const steps = [
    {
      icon: ClipboardCheck,
      title: t("home.howItWorks.step1.title"),
      description: t("home.howItWorks.step1.description"),
    },
    {
      icon: Brain,
      title: t("home.howItWorks.step2.title"),
      description: t("home.howItWorks.step2.description"),
    },
    {
      icon: Target,
      title: t("home.howItWorks.step3.title"),
      description: t("home.howItWorks.step3.description"),
    },
    {
      icon: BarChart3,
      title: t("home.howItWorks.step4.title"),
      description: t("home.howItWorks.step4.description"),
    },
  ];

  const benefits = [
    {
      icon: Sparkles,
      title: t("home.why.ai.title"),
      description: t("home.why.ai.description"),
    },
    {
      icon: BookOpen,
      title: t("home.why.database.title"),
      description: t("home.why.database.description"),
    },
    {
      icon: Lightbulb,
      title: t("home.why.personalized.title"),
      description: t("home.why.personalized.description"),
    },
    {
      icon: Users,
      title: t("home.why.support.title"),
      description: t("home.why.support.description"),
    },
  ];
  return (
    <div className="min-h-screen bg-background">
      <Navbar />

      {/* Hero Section */}
      <section className="relative pt-20 pb-16 sm:pt-28 sm:pb-18 lg:pt-32 lg:pb-20 overflow-hidden">
        {/* Éléments de fond animés */}
        <div className="absolute inset-0 bg-gradient-to-br from-accent/20 via-background to-background" />
        <div className="absolute top-20 right-10 w-72 h-72 bg-primary/10 rounded-full blur-3xl animate-pulse" />
        <div className="absolute bottom-0 left-10 w-72 h-72 bg-accent/10 rounded-full blur-3xl animate-pulse delay-700" />

        <div className="container relative mx-auto px-3 sm:px-4 md:px-6 lg:px-8">
          <div className="grid items-center gap-8 sm:gap-12 lg:gap-16 lg:grid-cols-2">
            <AnimatedSection direction="left">
              <h1 className="mb-6 text-3xl font-bold leading-tight tracking-tight sm:text-4xl md:text-5xl lg:text-6xl xl:text-7xl">
                {t("home.hero.title")} <span className="bg-gradient-to-r from-primary via-accent to-primary bg-clip-text text-transparent">{t("home.hero.titleHighlight")}</span>
              </h1>

              <p className="mb-6 sm:mb-8 max-w-lg text-base sm:text-lg text-muted-foreground leading-relaxed">
                {settings.platform_description}
              </p>

              <div className="flex flex-col sm:flex-row flex-wrap gap-3 sm:gap-4 mb-8 sm:mb-12">
                <Link to="/tests">
                  <Button variant="hero" size="xl" className="shadow-lg hover:shadow-xl hover:shadow-primary/50">
                    {t("home.heroButtons.startOrientation")}
                    <ArrowRight className="ml-2 h-5 w-5 transition-transform group-hover:translate-x-1" />
                  </Button>
                </Link>
                <Link to="/about">
                  <Button variant="hero-outline" size="xl" className="hover:bg-accent/10">
                    {t("home.heroButtons.learnMore")}
                  </Button>
                </Link>
              </div>

              <div className="space-y-3">
                <h3 className="text-xs sm:text-sm font-semibold text-muted-foreground uppercase tracking-wider">{t("home.whyChoose")}</h3>
                <div className="flex flex-col sm:flex-row flex-wrap items-start sm:items-center gap-3 sm:gap-4 lg:gap-6">
                  <div className="flex items-center gap-3">
                    <CheckCircle2 className="h-5 w-5 text-success flex-shrink-0" />
                    <span className="text-sm font-medium">{t("home.benefits.free")}</span>
                  </div>
                  <div className="flex items-center gap-3">
                    <CheckCircle2 className="h-5 w-5 text-success flex-shrink-0" />
                    <span className="text-sm font-medium">{t("home.benefits.instant")}</span>
                  </div>
                  <div className="flex items-center gap-3">
                    <CheckCircle2 className="h-5 w-5 text-success flex-shrink-0" />
                    <span className="text-sm font-medium">{t("home.benefits.personalized")}</span>
                  </div>
                </div>
              </div>
            </AnimatedSection>

            <AnimatedSection direction="right" delay={0.2}>
              <div className="relative">
                {/* Carré de fond avec gradient */}
                <div className="absolute inset-0 bg-gradient-to-br from-primary/5 to-accent/5 rounded-3xl blur-2xl" />
                {/* Image avec effet de card */}
                <div className="relative rounded-3xl overflow-hidden shadow-2xl border border-border/50 bg-card/50 backdrop-blur-sm p-3">
                  <img
                    src={heroImage}
                    alt="Illustration de l'orientation universitaire avec des étudiants et l'intelligence artificielle"
                    className="w-full rounded-2xl object-cover"
                  />
                  {/* Overlay subtle */}
                  <div className="absolute inset-0 rounded-2xl bg-gradient-to-t from-background/40 via-transparent to-transparent" />
                </div>
              </div>
            </AnimatedSection>
          </div>
        </div>
      </section>

      {/* How it Works */}
      <section className="py-12 sm:py-16 lg:py-20 bg-card">
        <div className="container mx-auto px-3 sm:px-4 md:px-6 lg:px-8">
          <AnimatedSection className="text-center mb-10 sm:mb-12 lg:mb-14">
            <h2 className="text-2xl sm:text-3xl lg:text-4xl font-bold mb-3 sm:mb-4">{t("home.howItWorks.title")}</h2>
            <p className="text-muted-foreground max-w-2xl mx-auto">
              {t("home.howItWorks.description")}
            </p>
          </AnimatedSection>

          <div className="grid gap-4 sm:gap-6 lg:gap-8 md:grid-cols-2 lg:grid-cols-4">
            {steps.map((step, i) => (
              <AnimatedSection key={step.title} delay={i * 0.1}>
                <div className="group relative rounded-xl border bg-background p-6 shadow-card transition-all duration-300 hover:shadow-card-hover hover:-translate-y-1 h-full">
                  <div className="mb-4 flex h-12 w-12 items-center justify-center rounded-lg bg-accent text-accent-foreground">
                    <step.icon className="h-6 w-6" />
                  </div>
                  <div className="absolute top-4 right-4 text-4xl font-bold text-muted/60">
                    {String(i + 1).padStart(2, "0")}
                  </div>
                  <h3 className="mb-2 text-lg font-semibold">{step.title}</h3>
                  <p className="text-sm text-muted-foreground leading-relaxed">{step.description}</p>
                </div>
              </AnimatedSection>
            ))}
          </div>
        </div>
      </section>

      {/* Benefits */}
      <section className="py-12 sm:py-16 lg:py-20">
        <div className="container mx-auto px-3 sm:px-4 md:px-6 lg:px-8">
          <AnimatedSection className="text-center mb-10 sm:mb-12 lg:mb-14">
            <h2 className="text-2xl sm:text-3xl lg:text-4xl font-bold mb-3 sm:mb-4">{t("home.why.title")}</h2>
            <p className="text-muted-foreground max-w-2xl mx-auto">
              {t("home.why.description")}
            </p>
          </AnimatedSection>

          <div className="grid gap-4 sm:gap-6 lg:gap-8 md:grid-cols-2">
            {benefits.map((benefit, i) => (
              <AnimatedSection key={benefit.title} delay={i * 0.1} direction={i % 2 === 0 ? "left" : "right"}>
                <div className="flex gap-5 rounded-xl border bg-card p-6 shadow-card transition-all duration-300 hover:shadow-card-hover h-full">
                  <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-secondary/10 text-secondary">
                    <benefit.icon className="h-6 w-6" />
                  </div>
                  <div>
                    <h3 className="mb-2 text-lg font-semibold">{benefit.title}</h3>
                    <p className="text-sm text-muted-foreground leading-relaxed">{benefit.description}</p>
                  </div>
                </div>
              </AnimatedSection>
            ))}
          </div>
        </div>
      </section>

      {/* Testimonials */}
      <section className="py-12 sm:py-16 lg:py-20 bg-card">
        <div className="container mx-auto px-3 sm:px-4 md:px-6 lg:px-8">
          <AnimatedSection className="text-center mb-10 sm:mb-12 lg:mb-14">
            <h2 className="text-2xl sm:text-3xl lg:text-4xl font-bold mb-3 sm:mb-4">{t("home.testimonials.title")}</h2>
            <p className="text-muted-foreground max-w-2xl mx-auto">
              {t("home.testimonials.description")}
            </p>
          </AnimatedSection>

          <div className="grid gap-4 sm:gap-6 lg:gap-8 md:grid-cols-2 lg:grid-cols-3">
            {approvedTestimonials.slice(0, 3).map((t, i) => (
              <AnimatedSection key={t.id} delay={i * 0.12}>
                <div className="rounded-xl border bg-background p-6 shadow-card h-full">
                  <div className="flex gap-1 mb-4">
                    {Array.from({ length: 5 }).map((_, si) => (
                      <Star
                        key={si}
                        className={`h-4 w-4 ${si < t.rating ? "fill-warning text-warning" : "text-muted"}`}
                      />
                    ))}
                  </div>
                  <p className="mb-4 text-sm text-muted-foreground leading-relaxed italic">"{t.text}"</p>
                  <div className="flex items-center gap-3">
                    <div className="flex h-10 w-10 items-center justify-center rounded-full bg-accent font-semibold text-accent-foreground">
                      {t.student_photo}
                    </div>
                    <div>
                      <p className="text-sm font-semibold">{t.student_name}</p>
                      <p className="text-xs text-muted-foreground">{t.course_name} - {t.university_name}</p>
                    </div>
                  </div>
                </div>
              </AnimatedSection>
            ))}
          </div>
        </div>
      </section>

      {/* CTA */}
      <AnimatedSection>
        <section className="py-12 sm:py-16 lg:py-20">
          <div className="container mx-auto px-3 sm:px-4 md:px-6 lg:px-8">
            <div className="rounded-2xl bg-primary p-6 sm:p-8 lg:p-12 text-center text-primary-foreground shadow-lg">
              <GraduationCap className="mx-auto mb-3 sm:mb-4 h-10 sm:h-12 w-10 sm:w-12" />
              <h2 className="text-2xl sm:text-3xl lg:text-4xl font-bold mb-3 sm:mb-4">{t("home.cta.title")}</h2>
              <p className="mb-6 sm:mb-8 max-w-xl mx-auto opacity-90 text-sm sm:text-base">
                {t("home.cta.description")}
              </p>
              <Link to="/register">
                <Button variant="secondary" size="xl">
                  {t("home.cta.button")}
                  <ArrowRight className="ml-1 h-5 w-5" />
                </Button>
              </Link>
            </div>
          </div>
        </section>
      </AnimatedSection>

      <Footer />
    </div>
  );
};

export default Index;
