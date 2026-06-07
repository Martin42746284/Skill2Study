import { useEffect, useMemo, useState } from "react";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import {
  ArrowRight,
  Building2,
  ClipboardCheck,
  GraduationCap,
  Heart,
  Loader2,
  MapPinned,
  Search,
  Target,
  TrendingUp,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import DashboardLayout from "@/components/DashboardLayout";
import { auth, recommendations as recommendationsApi, stats as statsApi, tests as testsApi, users as usersApi } from "@/lib/api";


import type { User, Recommendation, Favorite, TestSession } from '@/types';

type DashboardState = {
  user: User | null;
  stats: Record<string, unknown> | null;
  recommendations: Recommendation[];
  favorites: Favorite[];
  sessions: TestSession[];
  loading: boolean;
  error: string | null;
};

const formatDate = (value?: string | null) => {
  if (!value) return "—";
  return new Intl.DateTimeFormat("fr-FR", {
    day: "numeric",
    month: "long",
    year: "numeric",
  }).format(new Date(value));
};

const Dashboard = () => {
  const { t, i18n } = useTranslation();
  const quickActions = [
    {
      title: t("dashboard.orientationTest"),
      description: t("dashboard.orientationTestDesc"),
      icon: ClipboardCheck,
      url: "/tests",
      color: "bg-primary/10 text-primary",
    },
    {
      title: t("dashboard.recommendations"),
      description: t("dashboard.recommendationsDesc"),
      icon: Target,
      url: "/recommendations",
      color: "bg-secondary/10 text-secondary",
    },
    {
      title: t("dashboard.search"),
      description: t("dashboard.searchDesc"),
      icon: Search,
      url: "/dashboard/search",
      color: "bg-info/10 text-info",
    },
    {
      title: t("dashboard.universityMap"),
      description: t("dashboard.universityMapDesc"),
      icon: MapPinned,
      url: "/dashboard/map",
      color: "bg-warning/10 text-warning",
    },
  ];

  const [state, setState] = useState<DashboardState>({
    user: null,
    stats: null,
    recommendations: [],
    favorites: [],
    sessions: [],
    loading: true,
    error: null,
  });

  useEffect(() => {
    let active = true;

    const loadDashboard = async () => {
      try {
        const [meRes, statsRes, recsRes, historyRes, favorisRes] = await Promise.all([
          auth.me(),
          statsApi.getMine(),
          recommendationsApi.getMine(),
          testsApi.getHistory(),
          usersApi.getFavoris(),
        ]) as unknown[];

        if (!active) return;

        const meData = typeof meRes === 'object' && meRes !== null && 'user' in meRes ? (meRes as any).user : meRes;
        const statsData = typeof statsRes === 'object' && statsRes !== null && 'stats' in statsRes ? (statsRes as any).stats : statsRes;
        const recsData = Array.isArray(recsRes) ? recsRes : (typeof recsRes === 'object' && recsRes !== null && 'recommendations' in recsRes ? (recsRes as any).recommendations : []);
        const favorisData = Array.isArray(favorisRes) ? favorisRes : (typeof favorisRes === 'object' && favorisRes !== null && 'favoris' in favorisRes ? (favorisRes as any).favoris : []);
        const historyData = Array.isArray(historyRes) ? historyRes : (typeof historyRes === 'object' && historyRes !== null && 'sessions' in historyRes ? (historyRes as any).sessions : []);

        setState({
          user: meData as User | null,
          stats: statsData as Record<string, unknown> | null,
          recommendations: (recsData as Recommendation[]) || [],
          favorites: (favorisData as Favorite[]) || [],
          sessions: (historyData as TestSession[]) || [],
          loading: false,
          error: null,
        });
      } catch (err) {
        if (!active) return;
        setState((current) => ({
          ...current,
          loading: false,
          error: err instanceof Error ? err.message : "Impossible de charger le tableau de bord.",
        }));
      }
    };

    loadDashboard();
    return () => {
      active = false;
    };
  }, []);

  const profileCompletion = useMemo(() => {
    if (!state.user) return 0;

    const fields = [
      state.user.nom,
      state.user.prenom,
      state.user.email,
      state.user.serie_bac,
      state.user.ville,
      state.user.budget_mensuel,
    ].filter((value) => value !== undefined && value !== null && value !== "");

    return Math.round((fields.length / 6) * 100);
  }, [state.user]);

  const recentActivity = useMemo(() => {
    const activities = [
      ...state.sessions.map((session) => ({
        icon: ClipboardCheck,
        text: session.complete ? t("dashboard.testCompleted") : t("dashboard.testInProgress"),
        date: formatDate(session.updatedAt || session.createdAt),
        createdAt: session.updatedAt || session.createdAt || new Date().toISOString(),
      })),
      ...state.recommendations.map((rec) => ({
        icon: Target,
        text: `${t("dashboard.recommendation")}${rec.filiere?.nom || t("dashboard.field")}`,
        date: formatDate(rec.updatedAt || rec.createdAt),
        createdAt: rec.updatedAt || rec.createdAt || new Date().toISOString(),
      })),
      ...state.favorites.map((fav) => ({
        icon: Heart,
        text: `${t("dashboard.fieldSaved")}${fav.filiere?.nom || t("dashboard.favorite")}`,
        date: formatDate(fav.updatedAt || fav.createdAt),
        createdAt: fav.updatedAt || fav.createdAt || new Date().toISOString(),
      })),
    ]
      .filter((item) => item.createdAt)
      .sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());

    return activities.slice(0, 3);
  }, [state.sessions, state.recommendations, state.favorites, t]);

  if (state.loading) {
    return (
      <DashboardLayout>
        <div className="flex min-h-[50vh] items-center justify-center">
          <div className="flex items-center gap-3 text-muted-foreground">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t("dashboard.loading")}
          </div>
        </div>
      </DashboardLayout>
    );
  }

  if (state.error) {
    return (
      <DashboardLayout>
        <div className="rounded-xl border bg-card p-6 shadow-card">
          <h1 className="text-xl font-semibold">{t("dashboard.errorLoading")}</h1>
          <p className="mt-2 text-sm text-muted-foreground">{state.error}</p>
        </div>
      </DashboardLayout>
    );
  }

  const user = state.user;
  const displayName = user ? [user.prenom, user.nom].filter(Boolean).join(" ") : t("dashboard.student");
  const firstName = user?.prenom || "";
  const initials = user
    ? [user.prenom, user.nom]
        .filter(Boolean)
        .map((part) => part.charAt(0))
        .join("")
        .slice(0, 2)
        .toUpperCase()
    : "ES";

  // Count only unique completed tests (not multiple sessions of the same test)
  const completedTests = Array.from(new Set(
    state.sessions
      .filter((session) => session.complete === true)
      .map((session) => session.test_name || `test_${session.test_id}`)
  )).length;
  const recommendationsCount = typeof state.stats === 'object' && state.stats !== null && 'nb_recommendations' in state.stats
    ? (state.stats as any).nb_recommendations
    : state.recommendations.length;
  const statsObj = typeof state.stats === 'object' && state.stats !== null ? (state.stats as any) : {};
  const bestScore = Math.round((statsObj.meilleure_compatibilite?.score_compatibilite as number) ?? 0);
  const bestRecommendation = statsObj.meilleure_compatibilite?.filiere;

  const welcomeMessage = firstName
    ? (i18n.language === "fr" ? `Bonjour, ${firstName}` : `Hello, ${firstName}`)
    : (i18n.language === "fr" ? "Bonjour" : "Hello");

  return (
    <DashboardLayout>
      <div className="animate-fade-in">
        <div className="mb-6 sm:mb-8">
          <h1 className="text-2xl sm:text-3xl font-bold">{welcomeMessage}</h1>
          <p className="mt-1 text-sm sm:text-base text-muted-foreground">
            {t("dashboard.subtitle")}
          </p>
        </div>

        <div className="mb-6 sm:mb-8 rounded-xl border bg-card p-4 sm:p-6 shadow-card">
          <div className="flex flex-col gap-4 sm:gap-6 sm:flex-row sm:items-center sm:justify-between">
            <div className="flex items-center gap-3 sm:gap-4">
              <div className="flex h-12 sm:h-16 w-12 sm:w-16 items-center justify-center rounded-full bg-accent text-xl sm:text-2xl font-bold text-accent-foreground shrink-0">
                {initials || "ES"}
              </div>
              <div className="min-w-0 flex-1">
                <h2 className="text-lg sm:text-xl font-semibold truncate">{displayName}</h2>
                <p className="text-xs sm:text-sm text-muted-foreground truncate">{user?.email}</p>
                <div className="mt-1 flex items-center gap-2 text-xs text-muted-foreground">
                  <GraduationCap className="h-3 sm:h-3.5 w-3 sm:w-3.5 shrink-0" />
                  <span className="truncate">{t("dashboard.bac")} {user?.serie_bac || "—"}</span>
                </div>
              </div>
            </div>
            <div className="text-right">
              <p className="mb-1 text-sm text-muted-foreground">{t("dashboard.profileCompleted")}</p>
              <Progress value={profileCompletion} className="h-2 w-40" />
              <p className="mt-1 text-xs text-muted-foreground">{profileCompletion}%</p>
            </div>
          </div>
        </div>

        <div className="mb-8 grid gap-4 sm:grid-cols-4">
          <div className="rounded-xl border bg-card p-5 shadow-card">
            <div className="mb-2 flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-primary/10">
                <ClipboardCheck className="h-5 w-5 text-primary" />
              </div>
              <p className="text-sm text-muted-foreground">{t("dashboard.completedTests")}</p>
            </div>
            <p className="text-3xl font-bold">{completedTests}</p>
          </div>
          <div className="rounded-xl border bg-card p-5 shadow-card">
            <div className="mb-2 flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-secondary/10">
                <Target className="h-5 w-5 text-secondary" />
              </div>
              <p className="text-sm text-muted-foreground">{t("dashboard.recommendedFields")}</p>
            </div>
            <p className="text-3xl font-bold">{recommendationsCount}</p>
          </div>
          <div className="rounded-xl border bg-card p-5 shadow-card">
            <div className="mb-2 flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-success/10">
                <TrendingUp className="h-5 w-5 text-success" />
              </div>
              <p className="text-sm text-muted-foreground">{t("dashboard.maxScore")}</p>
            </div>
            <p className="text-3xl font-bold">{bestScore}%</p>
            {bestRecommendation?.nom && (
              <p className="mt-1 text-xs text-muted-foreground truncate">{bestRecommendation.nom}</p>
            )}
          </div>
          <div className="rounded-xl border bg-card p-5 shadow-card">
            <div className="mb-2 flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-destructive/10">
                <Heart className="h-5 w-5 text-destructive" />
              </div>
              <p className="text-sm text-muted-foreground">{t("dashboard.favorites")}</p>
            </div>
            <p className="text-3xl font-bold">{state.favorites.length}</p>
          </div>
        </div>

        <div className="mb-8">
          <h2 className="mb-4 text-xl font-semibold">{t("dashboard.quickAccess")}</h2>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            {quickActions.map((action) => (
              <Link key={action.title} to={action.url}>
                <div className="group rounded-xl border bg-card p-5 shadow-card transition-all duration-300 hover:-translate-y-1 hover:shadow-card-hover">
                  <div className={`mb-3 flex h-11 w-11 items-center justify-center rounded-lg ${action.color}`}>
                    <action.icon className="h-5 w-5" />
                  </div>
                  <h3 className="mb-1 font-semibold">{action.title}</h3>
                  <p className="text-xs text-muted-foreground">{action.description}</p>
                  <ArrowRight className="mt-3 h-4 w-4 text-muted-foreground transition-transform group-hover:translate-x-1" />
                </div>
              </Link>
            ))}
          </div>
        </div>

        <div className="grid gap-8 lg:grid-cols-2">
          <div>
            <h2 className="mb-4 text-xl font-semibold">{t("dashboard.recentActivity")}</h2>
            <div className="divide-y rounded-xl border bg-card shadow-card">
              {recentActivity.length === 0 ? (
                <div className="p-6 text-sm text-muted-foreground">{t("dashboard.noRecentActivity")}</div>
              ) : (
                recentActivity.map((activity, index) => (
                  <div key={`${activity.text}-${index}`} className="flex items-center gap-4 p-4">
                    <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-accent">
                      <activity.icon className="h-4 w-4 text-accent-foreground" />
                    </div>
                    <div className="flex-1">
                      <p className="text-sm font-medium">{activity.text}</p>
                      <p className="text-xs text-muted-foreground">{activity.date}</p>
                    </div>
                  </div>
                ))
              )}
            </div>
          </div>

          <div>
            <div className="mb-4 flex items-center justify-between">
              <h2 className="text-xl font-semibold">{t("dashboard.myFavorites")}</h2>
              <Link to="/dashboard/favorites">
                <Button variant="ghost" size="sm" className="text-xs">
                  {t("dashboard.viewAll")} <ArrowRight className="ml-1 h-3.5 w-3.5" />
                </Button>
              </Link>
            </div>
            <div className="divide-y rounded-xl border bg-card shadow-card">
              {state.favorites.length === 0 ? (
                <div className="flex flex-col items-center px-4 py-8 text-center">
                  <Heart className="mb-2 h-8 w-8 opacity-40 text-muted-foreground" />
                  <p className="text-sm text-muted-foreground">{t("dashboard.noFavoritesSaved")}</p>
                  <Link to="/recommendations" className="mt-2">
                    <Button variant="outline" size="sm">{t("dashboard.explore")}</Button>
                  </Link>
                </div>
              ) : (
                state.favorites.slice(0, 3).map((fav) => (
                  <div key={fav.id} className="flex items-center gap-3 p-4">
                    <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-primary/10">
                      <Building2 className="h-4 w-4 text-primary" />
                    </div>
                    <div className="min-w-0 flex-1">
                      <p className="truncate text-sm font-medium">{fav.filiere?.nom}</p>
                      <p className="text-xs text-muted-foreground">
                        {fav.filiere?.universite?.nom}
                        {fav.filiere?.universite?.ville ? ` • ${fav.filiere.universite.ville}` : ""}
                      </p>
                    </div>
                    {fav.filiere?.universite?.id && (
                      <Link to={`/university/${fav.filiere.universite.id}`}>
                        <Button variant="ghost" size="sm" className="text-xs">{t("dashboard.view")}</Button>
                      </Link>
                    )}
                  </div>
                ))
              )}
            </div>
          </div>
        </div>
      </div>
    </DashboardLayout>
  );
};

export default Dashboard;
