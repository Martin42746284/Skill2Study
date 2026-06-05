import { useEffect, useMemo, useState } from "react";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import {
  History as HistoryIcon,
  ClipboardCheck,
  Eye,
  RotateCcw,
  Calendar,
  Clock,
  Target,
  TrendingUp,
  Loader2,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import DashboardLayout from "@/components/DashboardLayout";
import { recommendations as recommendationsApi, tests as testsApi } from "@/lib/api";

type SessionRow = {
  id: number;
  createdAt?: string;
  date_completion?: string;
  complete: boolean;
  reponses?: Record<string, number>;
  scores?: Record<string, number>;
};

const History = () => {
  const { t } = useTranslation();
  const [sessions, setSessions] = useState<SessionRow[]>([]);
  const [topRecommendation, setTopRecommendation] = useState<string>("—");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let active = true;

    const loadHistory = async () => {
      try {
        const [historyResponse, recResponse] = await Promise.all([
          testsApi.getHistory(),
          recommendationsApi.getMine(),
        ]);

        if (!active) return;

        setSessions(historyResponse.sessions || []);
        setTopRecommendation(recResponse.recommendations?.[0]?.filiere?.nom || "—");
      } catch (err) {
        if (!active) return;
        setError(err instanceof Error ? err.message : t("common.loading"));
      } finally {
        if (active) setLoading(false);
      }
    };

    loadHistory();
    return () => {
      active = false;
    };
  }, []);

  const completedTests = useMemo(() => sessions.filter((session) => session.complete), [sessions]);
  const avgScore = useMemo(() => {
    if (completedTests.length === 0) return 0;

    const scores = completedTests.map((session) => {
      const values = Object.values(session.scores || {});
      if (!values.length) return 0;
      return Math.round(values.reduce((sum, value) => sum + Number(value), 0) / values.length);
    });

    return Math.round(scores.reduce((sum, value) => sum + value, 0) / scores.length);
  }, [completedTests]);

  const formatDate = (value?: string) => {
    if (!value) return "—";
    return new Intl.DateTimeFormat("fr-FR", {
      day: "numeric",
      month: "numeric",
      year: "numeric",
    }).format(new Date(value));
  };

  if (loading) {
    return (
      <DashboardLayout>
        <div className="flex min-h-[40vh] items-center justify-center">
          <div className="flex items-center gap-3 text-muted-foreground">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t("common.loading")}
          </div>
        </div>
      </DashboardLayout>
    );
  }

  if (error) {
    return (
      <DashboardLayout>
        <div className="rounded-xl border bg-card p-6 shadow-card">
          <h1 className="text-xl font-semibold">{t("history.title")}</h1>
          <p className="mt-2 text-sm text-muted-foreground">{error}</p>
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout>
      <div className="animate-fade-in">
        <div className="mb-8">
          <h1 className="flex items-center gap-2 text-3xl font-bold">
            <HistoryIcon className="h-7 w-7 text-primary" />
            {t("history.title")}
          </h1>
          <p className="mt-1 text-muted-foreground">{t("dashboard.sidebar.history")}</p>
        </div>

        <div className="mb-8 grid gap-4 sm:grid-cols-3">
          <div className="rounded-xl border bg-card p-5 shadow-card">
            <div className="mb-2 flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-primary/10">
                <ClipboardCheck className="h-5 w-5 text-primary" />
              </div>
              <p className="text-sm text-muted-foreground">{t("orientationTest.title")}</p>
            </div>
            <p className="text-3xl font-bold">{sessions.length}</p>
          </div>
          <div className="rounded-xl border bg-card p-5 shadow-card">
            <div className="mb-2 flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-success/10">
                <Target className="h-5 w-5 text-success" />
              </div>
              <p className="text-sm text-muted-foreground">{t("orientationTest.testCompleted")}</p>
            </div>
            <p className="text-3xl font-bold">{completedTests.length}</p>
          </div>
          <div className="rounded-xl border bg-card p-5 shadow-card">
            <div className="mb-2 flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-secondary/10">
                <TrendingUp className="h-5 w-5 text-secondary" />
              </div>
              <p className="text-sm text-muted-foreground">{t("testResults.yourScore")}</p>
            </div>
            <p className="text-3xl font-bold">{avgScore}%</p>
          </div>
        </div>

        <div className="space-y-4">
          {sessions.map((session) => {
            const values = Object.values(session.scores || {});
            const score = values.length
              ? Math.round(values.reduce((sum, value) => sum + Number(value), 0) / values.length)
              : 0;
            const answered = Object.keys(session.reponses || {}).length;

            return (
              <div
                key={session.id}
                className="rounded-xl border bg-card p-5 shadow-card transition-shadow hover:shadow-card-hover"
              >
                <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                  <div className="flex flex-1 items-start gap-4">
                    <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg bg-primary/10">
                      <ClipboardCheck className="h-5 w-5 text-primary" />
                    </div>
                    <div className="flex-1">
                      <div className="mb-1 flex items-center gap-2">
                        <h3 className="font-semibold">{t("orientationTest.title")}</h3>
                        <Badge variant={session.complete ? "default" : "outline"} className="text-[10px]">
                          {session.complete ? t("orientationTest.testCompleted") : t("orientationTest.testInProgress")}
                        </Badge>
                      </div>
                      <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-xs text-muted-foreground">
                        <span className="flex items-center gap-1">
                          <Calendar className="h-3 w-3" /> {formatDate(session.date_completion || session.createdAt)}
                        </span>
                        <span className="flex items-center gap-1">
                          <Clock className="h-3 w-3" /> {session.complete ? t("common.success") : "—"}
                        </span>
                        <span>{answered} {t("orientationTest.question")}</span>
                      </div>
                      {session.complete && (
                        <>
                          <div className="mt-2 flex items-center gap-2">
                            <Progress value={score} className="h-1.5 flex-1 max-w-[200px]" />
                            <span className="text-xs font-medium">{score}%</span>
                          </div>
                          <p className="mt-1.5 text-xs text-muted-foreground">
                            🎯 {t("recommendations.title")} : <strong>{topRecommendation}</strong>
                          </p>
                        </>
                      )}
                    </div>
                  </div>

                  <div className="flex shrink-0 gap-2">
                    {session.complete && (
                      <Link to="/recommendations">
                        <Button variant="outline" size="sm">
                          <Eye className="mr-1 h-3.5 w-3.5" /> {t("testResults.title")}
                        </Button>
                      </Link>
                    )}
                    <Link to="/tests">
                      <Button variant="ghost" size="sm">
                        <RotateCcw className="mr-1 h-3.5 w-3.5" /> {t("orientationTest.continueTest")}
                      </Button>
                    </Link>
                  </div>
                </div>
              </div>
            );
          })}
        </div>

        {sessions.length === 0 && (
          <div className="rounded-xl border bg-card p-12 text-center shadow-card">
            <ClipboardCheck className="mx-auto mb-4 h-12 w-12 text-muted-foreground/40" />
            <h3 className="mb-1 text-lg font-semibold">Aucun test effectué</h3>
            <p className="mb-4 text-sm text-muted-foreground">Commencez un test pour voir votre historique ici.</p>
            <Link to="/tests">
              <Button variant="default">Passer un test</Button>
            </Link>
          </div>
        )}
      </div>
    </DashboardLayout>
  );
};

export default History;
