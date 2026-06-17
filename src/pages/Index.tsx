import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import AnimatedSection from "@/components/AnimatedSection";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";
import { useSettings } from "@/contexts/SettingsContext";
import { useTheme } from "@/hooks/use-theme";
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
import heroImageSombre from "@/assets/hero-illustrationSombre.png";
import heroImageClair from "@/assets/hero-illustrationClair.png";
import { useState, useEffect } from "react";

interface Testimonial {
  id: number;
  student_name: string;
  student_serie: string;
  student_photo?: string;
  university_name: string;
  course_name: string;
  rating: number;
  text: string;
  date?: string;
  status: "Approuvé" | "En attente" | "Rejeté";
}

const Index = () => {
  const { t } = useTranslation();
  const { theme } = useTheme();
  const [approvedTestimonials, setApprovedTestimonials] = useState<Testimonial[]>([]);
  const [loading, setLoading] = useState(true);
  const { settings } = useSettings();

  useEffect(() => {
    const fetchApprovedTestimonials = async () => {
      try {
        setLoading(true);
        const response = await fetch(
          `${import.meta.env.VITE_API_URL || "http://localhost:3000/api"}/testimonials/approved?limit=100`
        );
        const data = await response.json();
        setApprovedTestimonials(data.testimonials || []);
      } catch (error) {
        console.error("Erreur lors de la récupération des témoignages:", error);
        setApprovedTestimonials([]);
      } finally {
        setLoading(false);
      }
    };

    fetchApprovedTestimonials();
  }, []);

  const heroImage = theme === "dark" ? heroImageSombre : heroImageClair;

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
      <section className="relative pt-24 pb-16 sm:pt-32 sm:pb-20 lg:pt-40 lg:pb-24 overflow-hidden">
        {/* Animated Background */}
        <div className="absolute inset-0 bg-gradient-to-br from-accent/20 via-background to-background" />

        {/* Floating gradient orbs */}
        <div className="absolute top-20 right-10 w-72 h-72 bg-primary/10 rounded-full blur-3xl animate-pulse" />
        <div className="absolute bottom-0 left-10 w-72 h-72 bg-accent/10 rounded-full blur-3xl animate-pulse delay-700" />

        {/* Animated floating icons */}
        <style>{`
          @keyframes float {
            0%, 100% { transform: translateY(0px); opacity: 0.5; }
            50% { transform: translateY(-10px); opacity: 0.65; }
          }
          @keyframes float-reverse {
            0%, 100% { transform: translateY(0px); opacity: 0.5; }
            50% { transform: translateY(10px); opacity: 0.65; }
          }
          .float-icon { animation: float 6s ease-in-out infinite; }
          .float-icon-reverse { animation: float-reverse 7s ease-in-out infinite; }
          .floating-img { filter: drop-shadow(0 4px 12px rgba(0, 0, 0, 0.15)); }
        `}</style>

        {/* Top left icon - Graduation Cap 1 */}
        <div className="absolute top-32 sm:top-40 left-2 sm:left-6 float-icon text-primary/60">
          <GraduationCap className="h-12 w-12 sm:h-14 sm:w-14" />
        </div>

        {/* Top right icon - Lightbulb */}
        <div className="absolute top-36 sm:top-44 right-2 sm:right-8 float-icon-reverse text-accent/60">
          <Lightbulb className="h-11 w-11 sm:h-13 sm:w-13" />
        </div>

        {/* Bottom left icon - Book */}
        <div className="absolute bottom-32 left-1 sm:left-4 float-icon-reverse text-primary/50">
          <BookOpen className="h-12 w-12 sm:h-14 sm:w-14" />
        </div>

        {/* Middle left icon - Brain */}
        <div className="absolute top-1/2 left-1/4 float-icon text-primary/55">
          <Brain className="h-10 w-10 sm:h-12 sm:w-12" />
        </div>

        {/* Middle right icon - Users */}
        <div className="absolute top-1/3 right-1/3 float-icon-reverse text-accent/55">
          <Users className="h-10 w-10 sm:h-12 sm:w-12" />
        </div>

        {/* Top center icon - Sparkles */}
        <div className="absolute top-1/4 left-1/2 float-icon text-primary/45">
          <Sparkles className="h-9 w-9 sm:h-11 sm:w-11" />
        </div>

        {/* Bottom center icon - ClipboardCheck */}
        <div className="absolute bottom-1/3 right-1/4 float-icon-reverse text-accent/45">
          <ClipboardCheck className="h-9 w-9 sm:h-11 sm:w-11" />
        </div>

        <div className="container relative mx-auto px-3 sm:px-4 md:px-6 lg:px-8">
          <div className="grid items-stretch gap-4 sm:gap-6 lg:gap-8 lg:grid-cols-2">
            <AnimatedSection direction="left" className="flex flex-col justify-center">
              <h1 className="mb-8 text-4xl font-bold leading-tight tracking-tight sm:text-5xl md:text-6xl lg:text-7xl">
                {t("home.hero.title")} <span className="bg-gradient-to-r from-primary via-accent to-primary bg-clip-text text-transparent">{t("home.hero.titleHighlight")}</span>
              </h1>

              <p className="mb-8 sm:mb-10 max-w-lg text-lg sm:text-xl text-muted-foreground leading-relaxed">
                {t("home.hero.platformDescription", { description: settings.platform_description })}
              </p>

              <div className="flex flex-col sm:flex-row flex-wrap gap-4 sm:gap-5 mb-10 sm:mb-14">
                <Link to="/tests">
                  <Button variant="hero" size="xl" className="shadow-lg hover:shadow-xl hover:shadow-primary/50 h-14 px-8 text-base font-semibold">
                    {t("home.heroButtons.startOrientation")}
                    <ArrowRight className="ml-2 h-5 w-5 transition-transform group-hover:translate-x-1" />
                  </Button>
                </Link>
                <Link to="/about">
                  <Button variant="hero-outline" size="xl" className="hover:bg-accent/10 h-14 px-8 text-base font-semibold">
                    {t("home.heroButtons.learnMore")}
                  </Button>
                </Link>
              </div>

              <div className="space-y-4">
                <h3 className="text-sm sm:text-base font-semibold text-muted-foreground uppercase tracking-wider">{t("home.whyChoose")}</h3>
                <div className="flex flex-col sm:flex-row flex-wrap items-start sm:items-center gap-4 sm:gap-5 lg:gap-8">
                  <div className="flex items-center gap-3">
                    <CheckCircle2 className="h-6 w-6 text-success flex-shrink-0" />
                    <span className="text-base font-medium">{t("home.benefits.free")}</span>
                  </div>
                  <div className="flex items-center gap-3">
                    <CheckCircle2 className="h-6 w-6 text-success flex-shrink-0" />
                    <span className="text-base font-medium">{t("home.benefits.instant")}</span>
                  </div>
                  <div className="flex items-center gap-3">
                    <CheckCircle2 className="h-6 w-6 text-success flex-shrink-0" />
                    <span className="text-base font-medium">{t("home.benefits.personalized")}</span>
                  </div>
                </div>
              </div>
            </AnimatedSection>

            <AnimatedSection direction="right" delay={0.2} className="flex items-center justify-center">
              <div className="relative w-full flex items-center justify-center">
                {/* Large background gradient blob */}
                <div className="absolute -inset-4 bg-gradient-to-br from-primary/15 to-accent/15 rounded-3xl blur-3xl" />

                {/* Image container with full image visible */}
                <div className="relative w-full rounded-3xl overflow-hidden shadow-2xl border-2 border-border/60 bg-background">
                  <img
                    src={heroImage}
                    alt="Illustration de l'orientation universitaire"
                    className="w-full h-auto object-contain"
                  />
                  {/* Gradient overlay for enhanced contrast */}
                  <div className="absolute inset-0 bg-gradient-to-t from-black/15 via-transparent to-transparent rounded-2xl" />
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
            {loading ? (
              <div className="col-span-full text-center py-8">
                <p className="text-muted-foreground">{t("common.loading") || "Chargement..."}</p>
              </div>
            ) : approvedTestimonials.length === 0 ? (
              <div className="col-span-full text-center py-8">
                <p className="text-muted-foreground">{t("home.testimonials.empty") || "Aucun témoignage approuvé pour le moment."}</p>
              </div>
            ) : (
              approvedTestimonials.map((test, i) => (
                <AnimatedSection key={test.id} delay={(i % 3) * 0.12}>
                  <div className="rounded-xl border bg-background p-6 shadow-card h-full">
                    <div className="flex gap-1 mb-4">
                      {Array.from({ length: 5 }).map((_, si) => (
                        <Star
                          key={si}
                          className={`h-4 w-4 ${si < test.rating ? "fill-warning text-warning" : "text-muted"}`}
                        />
                      ))}
                    </div>
                    <p className="mb-4 text-sm text-muted-foreground leading-relaxed italic">"{test.text}"</p>
                    <div className="flex items-center gap-3">
                      <div className="flex h-10 w-10 items-center justify-center rounded-full bg-accent font-semibold text-accent-foreground">
                        {test.student_photo || test.student_name.charAt(0)}
                      </div>
                      <div>
                        <p className="text-sm font-semibold">{test.student_name}</p>
                        <p className="text-xs text-muted-foreground">{test.course_name} - {test.university_name}</p>
                      </div>
                    </div>
                  </div>
                </AnimatedSection>
              ))
            )}
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
