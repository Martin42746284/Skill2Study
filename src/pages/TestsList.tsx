import { useEffect, useMemo, useState } from "react";
import DashboardLayout from "@/components/DashboardLayout";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { useNavigate, useLocation } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { ClipboardCheck, Clock, Users, ArrowRight, CheckCircle2 } from "lucide-react";
import { tests as testsApi } from "@/lib/api";
import { cn } from "@/lib/utils";

const TestsList = () => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const location = useLocation();
  const [questions, setQuestions] = useState<any[]>([]);
  const [history, setHistory] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const loadTests = async () => {
    try {
      setLoading(true);
      const [orientationQuestionsResponse, historyResponse] = await Promise.all([
        testsApi.getQuestions(),
        testsApi.getHistory(),
      ]);

      const orientationQuestions = Array.isArray(orientationQuestionsResponse?.questions) ? orientationQuestionsResponse.questions : [];
      setQuestions(orientationQuestions);

      const sessions = Array.isArray(historyResponse?.sessions) ? historyResponse.sessions : [];
      setHistory(sessions);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : t("common.loading"));
    } finally {
      setLoading(false);
    }
  };

  // Load tests on mount and when location changes
  useEffect(() => {
    loadTests();
  }, [location.pathname]);

  const completedSessions = useMemo(() => history.filter((session) => session.complete), [history]);
  const availableTest = questions.length > 0;

  return (
    <DashboardLayout>
      <div className="animate-fade-in h-full flex flex-col px-3 sm:px-4 md:px-6 lg:px-8 py-4 sm:py-6">
        <div className="mb-4 sm:mb-6">
          <h1 className="text-2xl sm:text-3xl font-bold mb-2">{t("orientationTest.title")}</h1>
          <p className="text-xs sm:text-sm text-muted-foreground">
            {t("testsList.selectTest")}
          </p>
        </div>

        <div className="mb-4 sm:mb-6 grid gap-2 sm:gap-3 grid-cols-1 sm:grid-cols-3 shrink-0">
          {[
            { icon: ClipboardCheck, label: t("testsList.availableTests"), value: availableTest ? 1 : 0, color: "bg-primary/10 text-primary" },
            { icon: CheckCircle2, label: t("testsList.completedTests"), value: completedSessions.length, color: "bg-success/10 text-success" },
            { icon: Users, label: t("testsList.totalQuestions"), value: questions.length, color: "bg-info/10 text-info" },
          ].map((s) => (
            <div key={s.label} className="rounded-xl border bg-card p-3 sm:p-4 shadow-card">
              <div className="flex items-center gap-2 sm:gap-3">
                <div className={`flex h-8 sm:h-9 w-8 sm:w-9 items-center justify-center rounded-lg shrink-0 ${s.color}`}>
                  <s.icon className="h-3.5 sm:h-4 w-3.5 sm:w-4" />
                </div>
                <div className="min-w-0">
                  <p className="text-base sm:text-lg font-bold">{s.value}</p>
                  <p className="text-xs text-muted-foreground truncate">{s.label}</p>
                </div>
              </div>
            </div>
          ))}
        </div>

        <div className="flex-1 flex flex-col overflow-hidden">
          {loading ? (
            <div className="flex items-center justify-center h-full">
              <div className="rounded-xl border bg-card p-12 text-center">
                <p className="text-sm text-muted-foreground">{t("common.loading")}</p>
              </div>
            </div>
          ) : error ? (
            <div className="flex items-center justify-center h-full">
              <div className="rounded-xl border bg-card p-12 text-center">
                <p className="text-sm text-destructive">{error}</p>
              </div>
            </div>
          ) : (
            <div className="space-y-3 sm:space-y-4 flex-1 overflow-y-auto">
              {/* Test d'Orientation Principal */}
              {availableTest && (
                <div className="rounded-xl border bg-card p-4 sm:p-6 shadow-card hover:shadow-card-hover transition-shadow">
                  <div className="flex flex-col sm:flex-row sm:items-center gap-3 sm:gap-4">
                    <div className="flex h-12 sm:h-14 w-12 sm:w-14 shrink-0 items-center justify-center rounded-xl bg-primary/10 text-xl sm:text-2xl">
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 mb-1 flex-wrap">
                        <h3 className="text-base sm:text-lg font-semibold">{t("orientationTest.title")}</h3>
                        {completedSessions.length > 0 && (
                          <Badge variant="default" className="bg-success text-success-foreground text-[9px] sm:text-[10px]">
                            <CheckCircle2 className="h-2.5 w-2.5 sm:h-3 sm:w-3 mr-1" /> {t("testsList.completed")}
                          </Badge>
                        )}
                      </div>
                      <p className="text-xs sm:text-sm text-muted-foreground mb-2 sm:mb-3">
                        {t("testsList.orientationDescription")}
                      </p>
                      <div className="flex flex-wrap items-center gap-x-3 sm:gap-x-4 gap-y-1 text-xs text-muted-foreground">
                        <span className="flex items-center gap-1">
                          <ClipboardCheck className="h-3 sm:h-3.5 w-3 sm:w-3.5 shrink-0" /> {questions.length} {t("testsList.questions")}
                        </span>
                        <span className="flex items-center gap-1">
                          <Clock className="h-3 sm:h-3.5 w-3 sm:w-3.5 shrink-0" /> {t("testsList.duration")}
                        </span>
                        <span className="flex items-center gap-1">
                          <Users className="h-3 sm:h-3.5 w-3 sm:w-3.5 shrink-0" /> {completedSessions.length.toLocaleString()} {t("testsList.completed").toLowerCase()}
                        </span>
                      </div>
                      <div className="mt-2 flex items-center gap-2">
                        <Progress value={questions.length > 0 ? 100 : 0} className="h-1.5 flex-1 max-w-[200px]" />
                        <span className="text-xs font-medium text-muted-foreground">{t("search.all")}</span>
                      </div>
                    </div>
                    <Button
                      onClick={() => navigate("/test/1")}
                      variant={completedSessions.length > 0 ? "outline" : "default"}
                      className="shrink-0 text-xs sm:text-sm"
                    >
                      {completedSessions.length > 0 ? t("testsList.resume") : t("testsList.start")}
                      <ArrowRight className="ml-1 h-3 sm:h-4 w-3 sm:w-4" />
                    </Button>
                  </div>
                </div>
              )}

              {!availableTest && (
                <div className="flex items-center justify-center h-full">
                  <div className="rounded-xl border bg-card p-12 text-center">
                    <ClipboardCheck className="mx-auto h-12 w-12 text-muted-foreground/40 mb-4" />
                    <h3 className="text-lg font-semibold mb-1">{t("testsList.noTestsAvailable")}</h3>
                    <p className="text-sm text-muted-foreground">
                      {t("testsList.noTestsDescription")}
                    </p>
                  </div>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
    </DashboardLayout>
  );
};

export default TestsList;
