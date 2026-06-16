import { useEffect, useMemo, useState, useRef, useCallback } from "react";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import {
  Eye,
  Heart,
  Loader2,
  MapPin,
  Search,
  Sparkles,
  Target,
  Clock,
  GraduationCap,
  TrendingUp,
  Info,
  AlertCircle,
  CheckCircle2,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import DashboardLayout from "@/components/DashboardLayout";
import { cn } from "@/lib/utils";
import { useInfiniteScroll } from "@/hooks/useInfiniteScroll";
import { recommendations as recommendationsApi, users as usersApi, tests as testsApi } from "@/lib/api";
import { useTestCompletion } from "@/hooks/use-test-completion";

const getScoreColor = (score: number) => {
  if (score >= 85) return "text-success";
  if (score >= 70) return "text-primary";
  return "text-warning";
};

type RecommendationRow = {
  id: number;
  rang: number;
  score_compatibilite: number;
  justification?: {
    points_forts?: string[];
    points_attention?: string[];
    raisons?: string[];
    pourquoi_cette_recommandation?: {
      titre?: string;
      raisons?: string[];
      resume?: string;
    };
    criteres_analyzes?: Record<string, {
      label: string;
      impact: string;
      score: number;
      detail: string;
    }>;
    scores_details?: {
      methode_ensemble?: number;
      weighted_scoring?: number;
      knn_similarity?: number;
      random_forest?: number;
      poids?: Record<string, string>;
    };
  };
  filiere?: {
    id: number;
    nom: string;
    niveau?: string;
    duree_annees?: number;
    universite?: {
      id: number;
      nom: string;
      ville?: string;
    };
  };
  createdAt?: string;
};

const Recommendations = () => {
  const { t } = useTranslation();
  const { hasCompletedTest, testLoading, testError } = useTestCompletion();
  const [allRecommendations, setAllRecommendations] = useState<RecommendationRow[]>([]);
  const [favoriteIds, setFavoriteIds] = useState<number[]>([]);
  const [savingId, setSavingId] = useState<number | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [refreshKey, setRefreshKey] = useState(0);
  const pageVisitedRef = useRef(false);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [isInitialLoading, setIsInitialLoading] = useState(true);

  // Fetch function pour infinite scroll - DEFINE FIRST
  const fetchRecommendations = useCallback(async (skip: number, limit: number) => {
    return allRecommendations.slice(skip, skip + limit);
  }, [allRecommendations]);

  const { items: recommendations, isLoading: loading, observerTarget, error: infiniteScrollError, setItems: setRecommendations } = useInfiniteScroll<RecommendationRow>(
    fetchRecommendations,
    { initialPageSize: 15, threshold: 300 }
  );

  const loadAllRecommendations = useCallback(async () => {
    setLoadError(null);
    setIsInitialLoading(true);

    try {
      const favorisResponse = await usersApi.getFavoris() as any;
      const existingFavorites = (favorisResponse.favoris || []).map((fav: any) => fav.filiere_id);
      setFavoriteIds(existingFavorites);

      let recResponse = await recommendationsApi.getMine() as any;
      let recs: RecommendationRow[] = recResponse.recommendations || [];

      if (recs.length === 0) {
        // Get the latest session ID to generate recommendations
        const sessionHistory = await testsApi.getHistory() as any;
        const latestSession = sessionHistory?.sessions?.[0];

        if (latestSession?.id) {
          await recommendationsApi.generate(latestSession.id);
          // Petit délai pour que le backend finisse de générer
          await new Promise(resolve => setTimeout(resolve, 500));
        }

        recResponse = await recommendationsApi.getMine() as any;
        recs = recResponse.recommendations || [];
      }

      setAllRecommendations(recs);
      // Charger les premières données du hook
      setRecommendations(recs.slice(0, 15));
    } catch (err) {
      setLoadError(err instanceof Error ? err.message : t("recommendations.noRecommendations"));
    } finally {
      setIsInitialLoading(false);
    }
  }, [t, setRecommendations]);

  useEffect(() => {
    if (hasCompletedTest) {
      loadAllRecommendations();
    }
  }, [hasCompletedTest, loadAllRecommendations]);

  // Recharge les recommandations quand la page devient visible
  useEffect(() => {
    const handleVisibilityChange = () => {
      if (!document.hidden && pageVisitedRef.current) {
        // Page devient visible et on l'a déjà visitée une fois
        // Forcer un recharge des données
        if (hasCompletedTest) {
          loadAllRecommendations();
        }
      }
      if (!document.hidden) {
        pageVisitedRef.current = true;
      }
    };

    document.addEventListener('visibilitychange', handleVisibilityChange);
    return () => document.removeEventListener('visibilitychange', handleVisibilityChange);
  }, [hasCompletedTest, loadAllRecommendations]);

  const summary = useMemo(() => {
    const total = recommendations.length;
    const best = recommendations[0];
    return {
      total,
      bestScore: Math.round(best?.score_compatibilite || 0),
      bestName: best?.filiere?.nom || "",
    };
  }, [recommendations]);

  const toggleFavorite = async (rec: RecommendationRow) => {
    const filiereId = rec.filiere?.id;
    if (!filiereId) return;

    setSavingId(rec.id);
    try {
      if (favoriteIds.includes(filiereId)) {
        await usersApi.removeFavori(filiereId);
        setFavoriteIds((current) => current.filter((id) => id !== filiereId));
      } else {
        await usersApi.addFavori(filiereId);
        setFavoriteIds((current) => [...current, filiereId]);
      }
    } finally {
      setSavingId(null);
    }
  };

  if (testLoading || isInitialLoading) {
    return (
      <DashboardLayout>
        <div className="flex min-h-[50vh] items-center justify-center">
          <div className="flex items-center gap-3 text-muted-foreground">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t("common.loading")}
          </div>
        </div>
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
              <h1 className="text-2xl sm:text-3xl font-bold">{t("recommendations.title")}</h1>
            </div>

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
                  {t("orientationTest.startTest")}
                </Button>
              </Link>
            </div>
          </div>
        </div>
      </DashboardLayout>
    );
  }

  if (loadError) {
    return (
      <DashboardLayout>
        <div className="rounded-xl border bg-card p-6 shadow-card">
          <h1 className="text-xl font-semibold">{t("common.error")}</h1>
          <p className="mt-2 text-sm text-muted-foreground">{loadError}</p>
          <Button className="mt-4" onClick={loadAllRecommendations}>{t("common.back")}</Button>
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout>
      <div className="animate-fade-in overflow-x-hidden w-full">

        <div className="mb-4 sm:mb-6 rounded-xl border bg-accent/50 p-3 sm:p-4 flex items-start gap-2 sm:gap-3 min-h-[60px]">
          <Info className="h-4 sm:h-5 w-4 sm:w-5 text-primary mt-0.5 shrink-0" />
          <div className="min-w-0 flex-1">
            <p className="text-xs sm:text-sm font-medium">
              Vos <strong>{summary.total}</strong> meilleures filière{summary.total > 1 ? "s" : ""} recommandée{summary.total > 1 ? "s" : ""} pour vous.
            </p>
            <p className="mt-1 text-xs text-muted-foreground">
              Basées sur votre profil académique et vos résultats au test d'orientation.
            </p>
          </div>
        </div>

        <div className="mb-4 sm:mb-6 grid gap-2 sm:gap-3 md:gap-4 grid-cols-1 md:grid-cols-3">
          <div className="rounded-xl border bg-card p-3 sm:p-4 md:p-5 shadow-card min-h-[80px]">
            <p className="text-xs text-muted-foreground">{t("recommendations.title")}</p>
            <p className="mt-1 sm:mt-2 text-xl sm:text-2xl md:text-3xl font-bold">{summary.total}</p>
          </div>
          <div className="rounded-xl border bg-card p-3 sm:p-4 md:p-5 shadow-card min-h-[80px]">
            <p className="text-xs text-muted-foreground">{t("testResults.yourScore")}</p>
            <p className={cn("mt-1 sm:mt-2 text-xl sm:text-2xl md:text-3xl font-bold", getScoreColor(summary.bestScore))}>{summary.bestScore}%</p>
          </div>
          <div className="rounded-xl border bg-card p-3 sm:p-4 md:p-5 shadow-card min-h-[80px]">
            <p className="text-xs text-muted-foreground">{t("recommendations.title")}</p>
            <p className="mt-1 sm:mt-2 truncate text-base sm:text-lg md:text-xl font-semibold">{summary.bestName || "—"}</p>
          </div>
        </div>

        <div className="space-y-2 sm:space-y-3 md:space-y-4">
          {recommendations.map((rec, i) => {
            const filiere = rec.filiere;
            const universityId = filiere?.universite?.id;
            const isFavorite = filiere ? favoriteIds.includes(filiere.id) : false;
            const reasons = [
              ...(rec.justification?.points_forts || []),
              ...(rec.justification?.raisons || []),
              ...(rec.justification?.points_attention || []),
            ].filter(Boolean);

            return (
              <div
                key={rec.id}
                className="overflow-hidden rounded-xl border bg-card shadow-card transition-all duration-300 hover:shadow-card-hover animate-fade-in opacity-0 max-w-full w-full"
                style={{ animationDelay: `${i * 80}ms` }}
              >
                <div className="p-3 sm:p-4 md:p-6 flex flex-col gap-3 sm:gap-4 lg:flex-row lg:items-start lg:justify-between">
                  <div className="flex-1 min-w-0">
                    <div className="mb-2 sm:mb-3 flex items-center gap-2 sm:gap-3">
                      <div className="flex h-8 w-8 items-center justify-center rounded-full bg-primary text-xs sm:text-sm font-bold text-primary-foreground shrink-0">
                        {rec.rang}
                      </div>
                      <div className="min-w-0 flex-1">
                        <h3 className="text-sm sm:text-base md:text-lg font-semibold truncate">{filiere?.nom || "Filière"}</h3>
                        <p className="text-xs text-muted-foreground truncate">{filiere?.universite?.nom || "Université"}</p>
                      </div>
                    </div>

                    <div className="mb-2 sm:mb-3 flex flex-wrap gap-1 sm:gap-2 text-xs text-muted-foreground">
                      {filiere?.universite?.ville && (
                        <span className="flex items-center gap-1 min-w-0">
                          <MapPin className="h-3 w-3 shrink-0" />
                          <span className="truncate">{filiere.universite.ville}</span>
                        </span>
                      )}
                      {filiere?.duree_annees && (
                        <span className="flex items-center gap-1">
                          <Clock className="h-3 w-3 shrink-0" />
                          {filiere.duree_annees}a
                        </span>
                      )}
                      <span className="flex items-center gap-1 min-w-0">
                        <GraduationCap className="h-3 w-3 shrink-0" />
                        <span className="truncate text-xs">{filiere?.niveau || "Sup"}</span>
                      </span>
                    </div>

                    {/* Justification simple et professionnelle */}
                    {rec.justification && (
                      <div className="mb-4 sm:mb-5 border-t pt-3 space-y-2">
                        {/* Raisons principales */}
                        {((rec.justification.pourquoi_cette_recommandation?.raisons || rec.justification.raisons) || []).length > 0 && (
                          <div>
                            <p className="mb-2 text-xs font-semibold text-muted-foreground uppercase">Justification</p>
                            <ul className="space-y-1">
                              {((rec.justification.pourquoi_cette_recommandation?.raisons || rec.justification.raisons) || [])
                                .slice(0, 6)
                                .map((reason: string, index: number) => (
                                  <li key={index} className="text-xs text-muted-foreground">
                                    • {reason}
                                  </li>
                                ))}
                            </ul>
                          </div>
                        )}
                      </div>
                    )}
                  </div>

                  <div className="flex flex-col items-center gap-2 w-full sm:w-auto lg:min-w-[130px] shrink-0 border-t sm:border-t-0 sm:border-l pt-2 sm:pt-0 sm:pl-3 lg:pl-0">
                    <div className="text-center w-full">
                      <p className="text-xs text-muted-foreground">{t("recommendations.compatibility")}</p>
                      <p className={cn("text-2xl sm:text-3xl md:text-4xl font-bold", getScoreColor(rec.score_compatibilite))}>
                        {Math.round(rec.score_compatibilite)}%
                      </p>
                      <Progress value={rec.score_compatibilite} className="mt-1 sm:mt-2 h-2 w-20 sm:w-24 mx-auto" />
                    </div>
                    <div className="flex w-full sm:w-auto flex-col gap-2 mt-2">
                      {universityId ? (
                        <Link to={`/university/${universityId}`} className="w-full">
                          <Button variant="outline" size="sm" className="w-full text-xs whitespace-nowrap">
                            <Eye className="mr-1 h-3 w-3" /> {t("recommendations.details")}
                          </Button>
                        </Link>
                      ) : (
                        <Button variant="outline" size="sm" className="w-full text-xs whitespace-nowrap" disabled>
                          <Eye className="mr-1 h-3 w-3" /> {t("recommendations.details")}
                        </Button>
                      )}
                      <Button
                        variant={isFavorite ? "default" : "ghost"}
                        size="sm"
                        className="w-full text-xs whitespace-nowrap"
                        onClick={() => toggleFavorite(rec)}
                        disabled={!filiere?.id || savingId === rec.id}
                      >
                        <Heart className={`mr-1 h-3 w-3 ${isFavorite ? "fill-current" : ""}`} />
                        {isFavorite ? t("recommendations.saved") : t("recommendations.save")}
                      </Button>
                    </div>
                  </div>
                </div>
              </div>
            );
          })}
        </div>

        {recommendations.length === 0 && allRecommendations.length === 0 && (
          <div className="mt-4 sm:mt-6 lg:mt-8 rounded-xl border bg-card p-6 sm:p-8 lg:p-12 text-center shadow-card">
            <Target className="mx-auto mb-3 sm:mb-4 h-9 sm:h-10 lg:h-12 w-9 sm:w-10 lg:w-12 text-muted-foreground/40" />
            <h3 className="mb-1 text-base sm:text-lg font-semibold">{t("recommendations.noRecommendations")}</h3>
            <p className="mb-4 text-xs sm:text-sm text-muted-foreground">
              {t("recommendations.completeProfileToGenerate")}
            </p>
            <Link to="/tests">
              <Button variant="default" className="text-sm">{t("recommendations.takeTest")}</Button>
            </Link>
          </div>
        )}

        {/* Infinite scroll loading indicator */}
        {loading && (
          <div className="flex justify-center py-6">
            <div className="animate-spin">
              <svg className="h-6 w-6 text-muted-foreground" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
            </div>
          </div>
        )}

        <div ref={observerTarget} className="h-10" />

        <div className="mt-4 sm:mt-6 lg:mt-8 rounded-xl border bg-gradient-to-r from-primary/10 to-accent/10 p-4 sm:p-6 text-center">
          <h3 className="mb-2 text-base sm:text-lg font-semibold">{t("recommendations.exploreOtherUniversities")}</h3>
          <p className="mb-3 sm:mb-4 text-xs sm:text-sm text-muted-foreground">
            {t("recommendations.discoverMoreEstablishments")}
          </p>
          <Link to="/dashboard/search">
            <Button variant="default" className="text-sm">
              <Search className="mr-1 h-3 sm:h-4 w-3 sm:w-4" /> {t("recommendations.fullSearch")}
            </Button>
          </Link>
        </div>
      </div>
    </DashboardLayout>
  );
};

export default Recommendations;
