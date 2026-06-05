import { useEffect, useMemo, useState, useRef, useCallback } from "react";
import DashboardLayout from "@/components/DashboardLayout";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import {
  CheckCircle2,
  XCircle,
  MapPin,
  Clock,
  DollarSign,
  Briefcase,
  GraduationCap,
  ArrowRight,
  Star,
  Building2,
  AlertCircle,
  Sparkles,
} from "lucide-react";
import { cn } from "@/lib/utils";
import { comparator as comparatorApi, filieres as filieresApi, recommendations as recommendationsApi } from "@/lib/api";
import { useTestCompletion } from "@/hooks/use-test-completion";

interface ComparisonItem {
  id: number;
  nom: string;
  universite: string;
  universite_id?: number;
  type_universite?: string;
  ville?: string;
  domaine?: string;
  niveaux?: string[];
  duree_annees?: string | null;
  cout_annuel?: number | null;
  cout_description?: string | null;
  langue?: string | null;
  moyenne_min_requise?: number | null;
  difficulte?: string | null;
  taux_emploi?: number | null;
  salaire_moyen_debutant?: number | null;
  debouches?: string[] | null;
  competences_requises?: string[] | null;
  centres_interet?: string[] | null;
  score_retour_investissement?: number | null;
  score_compatibilite?: number | null;
  avantages?: string[];
  inconvenients?: string[];
}

const formatType = (value?: string) => {
  if (!value) return "—";
  if (value === "publique") return "Public";
  if (value === "privee") return "Privé";
  return value;
};

const formatMoney = (value?: number | null) => {
  if (value == null) return "—";
  return `${new Intl.NumberFormat("fr-FR").format(value)} Ar`;
};

const scoreColor = (score?: number | null) => {
  if (score == null) return "bg-muted";
  if (score >= 1.5) return "bg-success";
  if (score >= 1) return "bg-info";
  return "bg-warning";
};

const compatibilityScoreColor = (score?: number | null) => {
  if (score == null) return "hsl(var(--muted-foreground))";
  if (score >= 80) return "hsl(var(--success))"; // vert
  if (score >= 60) return "hsl(var(--info))"; // bleu
  if (score >= 40) return "hsl(var(--warning))"; // orange
  return "hsl(var(--destructive))"; // rouge
};

const Compare = () => {
  const { t } = useTranslation();
  const { hasCompletedTest, testLoading, testError } = useTestCompletion();
  const [comparisons, setComparisons] = useState<ComparisonItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const pageVisitedRef = useRef(false);

  const loadComparison = useCallback(async () => {
    try {
      setLoading(true);
      // Petit délai pour que les données soient à jour sur le serveur
      await new Promise(resolve => setTimeout(resolve, 300));

      const recommendationsResponse = await recommendationsApi.getMine() as any;
      const recommendedIds = Array.isArray(recommendationsResponse?.recommendations)
        ? recommendationsResponse.recommendations
            .map((rec: any) => Number(rec.filiere?.id || rec.filiere_id))
            .filter((value: number) => Number.isFinite(value))
        : [];

      let filiereIds = recommendedIds;

      // Si pas de recommandations personnalisées, utiliser les filières les plus populaires
      if (filiereIds.length === 0) {
        const filieresResponse = await filieresApi.getAll(1, 10000) as any;
        filiereIds = Array.isArray(filieresResponse?.filieres)
          ? filieresResponse.filieres.map((filiere: any) => Number(filiere.id)).filter((value: number) => Number.isFinite(value))
          : [];
      }

      if (filiereIds.length < 2) {
        throw new Error(t("compare.unavailableDesc"));
      }

      // Limiter à 50 filières pour l'API (contrainte du backend)
      const filiereIdsToCompare = filiereIds.slice(0, 50);
      console.log(`Envoi de ${filiereIdsToCompare.length} filières pour comparaison:`, filiereIdsToCompare);

      const comparisonResponse = await comparatorApi.compare(filiereIdsToCompare) as any;
      console.log('Réponse complète du comparateur:', comparisonResponse);
      const items = Array.isArray(comparisonResponse?.comparaison) ? comparisonResponse.comparaison : [];

      console.log(`Réponse de comparaison: ${items.length} filières`, items);

      setComparisons(items);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : t("common.error"));
    } finally {
      setLoading(false);
    }
  }, [t]);

  useEffect(() => {
    if (!hasCompletedTest) {
      setLoading(false);
      return;
    }

    loadComparison();
  }, [hasCompletedTest, loadComparison]);

  // Recharge la comparaison quand la page devient visible
  useEffect(() => {
    const handleVisibilityChange = () => {
      if (!document.hidden && pageVisitedRef.current && hasCompletedTest) {
        // Recharge les données sans rafraîchir toute la page
        loadComparison();
      }
      if (!document.hidden) {
        pageVisitedRef.current = true;
      }
    };

    document.addEventListener('visibilitychange', handleVisibilityChange);
    return () => document.removeEventListener('visibilitychange', handleVisibilityChange);
  }, [hasCompletedTest, loadComparison]);

  const rows = useMemo(
    () => [
      {
        label: t("compare.university"),
        icon: Building2,
        render: (c: ComparisonItem) => (
          <div>
            <p className="text-sm font-semibold text-foreground">{c.universite}</p>
            <p className="text-xs text-muted-foreground">{c.ville || "—"}</p>
          </div>
        ),
      },
      {
        label: t("compare.compatibility"),
        icon: Sparkles,
        render: (c: ComparisonItem) => {
          const score = c.score_compatibilite;
          if (score === null || score === undefined) {
            return <span className="text-sm text-muted-foreground">—</span>;
          }
          const scoreColorClass = score >= 80 ? "text-success" : score >= 60 ? "text-info" : score >= 40 ? "text-warning" : "text-destructive";
          const progressColorClass = score >= 80 ? "bg-success" : score >= 60 ? "bg-info" : score >= 40 ? "bg-warning" : "bg-destructive";
          return (
            <div className="flex items-center gap-2">
              <div className="flex-1">
                <div className="h-2 rounded-full bg-muted overflow-hidden">
                  <div
                    className={cn("h-full rounded-full transition-all", progressColorClass)}
                    style={{ width: `${score}%` }}
                  />
                </div>
              </div>
              <span className={cn("text-sm font-bold min-w-[40px] text-right", scoreColorClass)}>
                {score}%
              </span>
            </div>
          );
        },
      },
      {
        label: t("compare.type"),
        icon: Building2,
        render: (c: ComparisonItem) => (
          <span
            className={cn(
              "inline-flex items-center rounded-full px-3 py-1 text-xs font-semibold",
              c.type_universite === "publique"
                ? "bg-success/20 text-success border border-success/30"
                : "bg-info/20 text-info border border-info/30"
            )}
          >
            {formatType(c.type_universite)}
          </span>
        ),
      },
      {
        label: t("compare.level"),
        icon: GraduationCap,
        render: (c: ComparisonItem) => (
          <div className="flex flex-wrap gap-1">
            {c.niveaux && c.niveaux.length > 0 ? (
              c.niveaux.map(n => (
                <span key={n} className="text-xs font-medium bg-primary/10 text-primary px-2 py-1 rounded">
                  {n}
                </span>
              ))
            ) : (
              <span className="text-sm font-medium text-foreground">—</span>
            )}
          </div>
        ),
      },
      {
        label: t("compare.duration"),
        icon: Clock,
        render: (c: ComparisonItem) => (
          <span className="text-sm font-medium text-foreground">
            {c.duree_annees ? `${c.duree_annees} ans` : "—"}
          </span>
        ),
      },
      {
        label: t("compare.difficulty"),
        icon: Briefcase,
        render: (c: ComparisonItem) => (
          <span className="text-sm font-medium text-foreground">{c.difficulte || "—"}</span>
        ),
      },
      {
        label: t("compare.annualCost"),
        icon: DollarSign,
        render: (c: ComparisonItem) => (
          <div>
            <p className="text-sm font-medium text-foreground">{formatMoney(c.cout_annuel)}</p>
            {c.cout_description && (
              <p className="text-xs text-muted-foreground mt-0.5">{c.cout_description}</p>
            )}
          </div>
        ),
      },
    ],
    [t]
  );

  if (testLoading || loading) {
    return (
      <DashboardLayout>
        <div className="mx-auto max-w-6xl text-center py-20 text-muted-foreground">{t("compare.loading")}</div>
      </DashboardLayout>
    );
  }

  if (!hasCompletedTest) {
    return (
      <DashboardLayout>
        <div className="animate-fade-in">
          <div className="mb-6 sm:mb-8">
            <div className="mb-2 flex items-center gap-2">
              <Sparkles className="h-4 sm:h-5 w-4 sm:w-5 text-primary shrink-0" />
              <h1 className="text-2xl sm:text-3xl font-bold">{t("compare.title")}</h1>
            </div>
            <p className="text-xs sm:text-sm text-muted-foreground">
              {t("compare.description")}
            </p>
          </div>

          <div className="rounded-xl border border-amber-200 bg-amber-50/50 p-4 sm:p-6 flex items-start gap-3 sm:gap-4">
            <AlertCircle className="h-5 sm:h-6 w-5 sm:w-6 text-amber-600 shrink-0 mt-0.5" />
            <div className="min-w-0 flex-1">
              <h3 className="font-semibold text-amber-900 mb-2 text-sm sm:text-base">
                {t("compare.testRequired")}
              </h3>
              <p className="text-xs sm:text-sm text-amber-800 mb-3 sm:mb-4">
                {t("compare.testRequiredDesc")}
              </p>
              <Link to="/tests">
                <Button className="bg-amber-600 hover:bg-amber-700 text-sm">
                  <Sparkles className="mr-2 h-3.5 sm:h-4 w-3.5 sm:w-4" />
                  {t("compare.testButton")}
                </Button>
              </Link>
            </div>
          </div>
        </div>
      </DashboardLayout>
    );
  }

  if (error || comparisons.length === 0) {
    return (
      <DashboardLayout>
        <div className="mx-auto max-w-6xl text-center py-12 sm:py-20 px-4">
          <h1 className="text-xl sm:text-2xl font-bold mb-2">{t("compare.unavailable")}</h1>
          <p className="text-xs sm:text-sm text-muted-foreground mb-4 sm:mb-6">{error || t("compare.unavailableDesc")}</p>
          <Link to="/dashboard/search">
            <Button variant="outline" className="bg-transparent text-sm">
              <Briefcase className="mr-2 h-3.5 sm:h-4 w-3.5 sm:w-4" /> {t("compare.searchButton")}
            </Button>
          </Link>
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout>
      <div className="animate-fade-in pb-[280px]">
        <div className="mb-6 px-4 sm:px-6 lg:px-8 max-w-full">
          <h1 className="text-2xl font-bold text-foreground mb-1">{t("compare.title")}</h1>
          <p className="text-muted-foreground text-sm">
            {t("compare.description")}
          </p>
        </div>

        {/* Desktop Table - Horizontally Scrollable */}
        <div className="hidden lg:flex lg:flex-col rounded-2xl border border-border bg-card shadow-card overflow-hidden mx-4 sm:mx-6 lg:mx-8 flex-1 min-h-0">
          <div className="flex items-center justify-between px-5 py-3 border-b border-border bg-muted shrink-0">
            <span className="text-xs font-semibold text-muted-foreground uppercase tracking-wider">
              {comparisons.length} {t("search.fields")}{comparisons.length > 1 ? "s" : ""}
            </span>
            <span className="text-xs text-muted-foreground/60">← {t("compare.description")} →</span>
          </div>

          <div className="overflow-x-auto overflow-y-auto flex-1">
            {/* Header with filiere names */}
            <div
              className="grid border-b border-border bg-muted"
              style={{ gridTemplateColumns: `180px repeat(${comparisons.length}, minmax(240px, 1fr))` }}
            >
              <div className="p-5 flex items-end sticky left-0 bg-muted z-10">
                <span className="text-xs font-semibold text-muted-foreground uppercase tracking-wider">{t("search.fields")}</span>
              </div>
              {comparisons.map((c) => (
                <Link key={c.id} to={c.universite_id ? `/university/${c.universite_id}` : "/dashboard/search"}>
                  <div className="p-5 border-l border-border hover:bg-card transition-colors cursor-pointer group">
                    <div className="flex flex-col items-center text-center gap-2">
                      {/* Compatibility Score Badge */}
                      {c.score_compatibilite !== null && c.score_compatibilite !== undefined ? (
                        <div className="flex items-center gap-1 mb-1">
                          <div className="relative">
                            <svg className="w-12 h-12" viewBox="0 0 100 100">
                              <circle
                                cx="50"
                                cy="50"
                                r="45"
                                fill="none"
                                stroke={compatibilityScoreColor(0)}
                                strokeWidth="4"
                              />
                              <circle
                                cx="50"
                                cy="50"
                                r="45"
                                fill="none"
                                stroke={compatibilityScoreColor(c.score_compatibilite)}
                                strokeWidth="4"
                                strokeDasharray={`${(c.score_compatibilite / 100) * 283} 283`}
                                strokeLinecap="round"
                                style={{ transition: "stroke-dasharray 0.3s ease" }}
                                transform="rotate(-90 50 50)"
                              />
                            </svg>
                            <div className="absolute inset-0 flex items-center justify-center">
                              <span className="text-xs font-bold text-foreground">{c.score_compatibilite}%</span>
                            </div>
                          </div>
                        </div>
                      ) : (
                        <div className="h-12 flex items-center justify-center mb-1">
                          <span className="text-xs text-muted-foreground">—</span>
                        </div>
                      )}
                      <div>
                        <h3 className="font-semibold text-sm text-foreground group-hover:text-primary transition-colors leading-snug">
                          {c.nom}
                        </h3>
                        <p className="text-xs text-muted-foreground mt-0.5">{c.universite}</p>
                      </div>
                    </div>
                  </div>
                </Link>
              ))}
            </div>

            {/* Data Rows */}
            {rows.map((row, rowIdx) => (
              <div
                key={row.label}
                className={cn(
                  "grid border-b border-border",
                  rowIdx % 2 === 0 ? "bg-card" : "bg-muted/30"
                )}
                style={{ gridTemplateColumns: `180px repeat(${comparisons.length}, minmax(240px, 1fr))` }}
              >
                <div className="flex items-center gap-2.5 p-4 border-r border-border sticky left-0 bg-inherit z-10">
                  <row.icon className="h-4 w-4 text-muted-foreground shrink-0" />
                  <span className="text-sm font-medium text-muted-foreground">{row.label}</span>
                </div>
                {comparisons.map((c) => (
                  <div key={c.id} className="flex items-center p-4 border-l border-border">
                    {row.render(c)}
                  </div>
                ))}
              </div>
            ))}

            {/* Avantages Section */}
            <div
              className="grid border-b border-border bg-card"
              style={{ gridTemplateColumns: `180px repeat(${comparisons.length}, minmax(240px, 1fr))` }}
            >
              <div className="flex items-start gap-2.5 p-4 border-r border-border pt-5 sticky left-0 bg-card z-10">
                <CheckCircle2 className="h-4 w-4 text-success shrink-0 mt-0.5" />
                <span className="text-sm font-medium text-muted-foreground">Avantages</span>
              </div>
              {comparisons.map((c) => (
                <div key={c.id} className="p-4 border-l border-border">
                  <ul className="space-y-2">
                    {(c.avantages || []).map((item, idx) => (
                      <li key={idx} className="flex items-start gap-2">
                        <CheckCircle2 className="h-3.5 w-3.5 text-success mt-0.5 shrink-0" />
                        <span className="text-xs text-foreground/70 leading-snug">{item}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              ))}
            </div>

            {/* Défis Section */}
            <div
              className="grid"
              style={{ gridTemplateColumns: `180px repeat(${comparisons.length}, minmax(240px, 1fr))` }}
            >
              <div className="flex items-start gap-2.5 p-4 border-r border-border pt-5 sticky left-0 bg-card z-10">
                <XCircle className="h-4 w-4 text-destructive shrink-0 mt-0.5" />
                <span className="text-sm font-medium text-muted-foreground">Défis</span>
              </div>
              {comparisons.map((c) => (
                <div key={c.id} className="p-4 border-l border-border">
                  <ul className="space-y-2">
                    {(c.inconvenients || []).map((item, idx) => (
                      <li key={idx} className="flex items-start gap-2">
                        <XCircle className="h-3.5 w-3.5 text-destructive mt-0.5 shrink-0" />
                        <span className="text-xs text-foreground/70 leading-snug">{item}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Mobile View - Card Layout */}
        <div className="lg:hidden space-y-4 px-4 sm:px-6 max-h-[calc(100vh-280px)] overflow-y-auto">
          {comparisons.map((comp) => (
            <Link key={comp.id} to={comp.universite_id ? `/university/${comp.universite_id}` : "/dashboard/search"}>
              <div className="rounded-xl border border-border bg-card p-5 shadow-card hover:shadow-card-hover transition-all">
                <div className="flex items-start justify-between mb-4">
                  <div className="flex-1 pr-3">
                    <h3 className="font-semibold text-foreground text-sm leading-snug">{comp.nom}</h3>
                    <p className="text-xs text-muted-foreground mt-0.5">
                      {comp.universite}
                      {comp.ville ? ` · ${comp.ville}` : ""}
                    </p>
                  </div>
                  <div
                    className={cn(
                      "flex h-12 w-12 items-center justify-center rounded-full text-card-foreground font-bold text-sm shrink-0",
                      scoreColor(comp.score_retour_investissement)
                    )}
                  >
                    {comp.score_retour_investissement ? comp.score_retour_investissement.toFixed(1) : "—"}
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-2 mb-4">
                  {[
                    { label: "Type", value: formatType(comp.type_universite) },
                    { label: "Niveaux", value: comp.niveaux && comp.niveaux.length > 0 ? comp.niveaux.join(", ") : "—" },
                    { label: "Durée", value: comp.duree_annees || "—" },
                    { label: "Coût", value: formatMoney(comp.cout_annuel) },
                  ].map((item) => (
                    <div key={item.label} className="bg-muted rounded-lg px-3 py-2">
                      <p className="text-[10px] text-muted-foreground font-medium uppercase tracking-wide">{item.label}</p>
                      <p className="text-xs font-semibold text-foreground mt-0.5">{item.value}</p>
                    </div>
                  ))}
                </div>

                <div className="flex items-center gap-1 text-primary font-medium text-sm">
                  Voir détails <ArrowRight className="h-4 w-4" />
                </div>
              </div>
            </Link>
          ))}
        </div>

      </div>

      {/* Fixed bottom section */}
      <div className="fixed bottom-0 left-0 right-0 border-t border-border bg-background py-6 px-4 sm:px-6 lg:px-8 lg:ml-64 z-40">
        <div className="rounded-2xl border border-primary/30 bg-accent p-6 text-center">
          <h3 className="text-base font-semibold text-foreground mb-1">Personnaliser votre comparaison</h3>
          <p className="text-sm text-muted-foreground mb-4">
            Explorez toutes les filières disponibles et choisissez celles qui correspondent le mieux à votre profil.
          </p>
          <Link to="/dashboard/search">
            <Button variant="default" className="bg-primary hover:bg-primary/90">
              <Briefcase className="mr-2 h-4 w-4" /> Recherche avancée
            </Button>
          </Link>
        </div>
      </div>
    </DashboardLayout>
  );
};

export default Compare;
