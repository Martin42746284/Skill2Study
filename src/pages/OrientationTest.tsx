import { useEffect, useState } from "react";
import DashboardLayout from "@/components/DashboardLayout";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { useNavigate, useParams } from "react-router-dom";
import { useTranslation } from "react-i18next";
import { ArrowLeft, ArrowRight, CheckCircle2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";
import { recommendations as recommendationsApi, tests as testsApi } from "@/lib/api";
import { invalidateTestCompletionCache } from "@/hooks/use-test-completion";

interface TestOption {
  id: number;
  texte: string;
}

interface TestQuestion {
  id: number;
  texte: string;
  categorie: string;
  options: TestOption[];
}

const OrientationTest = () => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { toast } = useToast();
  const { id } = useParams();
  const [currentStep, setCurrentStep] = useState(0);
  const [answers, setAnswers] = useState<Record<number, number>>({});
  const [questions, setQuestions] = useState<TestQuestion[]>([]);
  const [sessionId, setSessionId] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;

    const loadTest = async () => {
      try {
        setLoading(true);
        const [questionsResponse, sessionResponse] = await Promise.all([
          testsApi.getQuestions(),
          testsApi.startSession(),
        ]);

        if (!cancelled) {
          setQuestions(Array.isArray(questionsResponse?.questions) ? questionsResponse.questions : []);
          setSessionId(Number(sessionResponse?.session_id));
          setError(null);
        }
      } catch (err) {
        if (!cancelled) {
          setError(err instanceof Error ? err.message : t("orientationTest.errorLoading"));
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    };

    loadTest();
    return () => {
      cancelled = true;
    };
  }, [id]);

  const persistCurrentAnswer = async () => {
    if (!sessionId || questions.length === 0) return;
    const question = questions[currentStep];
    const optionId = answers[question.id];
    if (!optionId) return;
    await testsApi.submitAnswer(sessionId, question.id, optionId);
  };

  const handlePrevious = async () => {
    if (currentStep === 0) return;
    setSubmitting(true);
    try {
      await persistCurrentAnswer();
      setCurrentStep((step) => Math.max(0, step - 1));
    } catch (err) {
      setError(err instanceof Error ? err.message : t("orientationTest.errorSavingAnswer"));
    } finally {
      setSubmitting(false);
    }
  };

  const handleNext = async () => {
    if (currentStep >= questions.length - 1) return;
    setSubmitting(true);
    try {
      await persistCurrentAnswer();
      setCurrentStep((step) => Math.min(questions.length - 1, step + 1));
    } catch (err) {
      setError(err instanceof Error ? err.message : t("orientationTest.errorSavingAnswer"));
    } finally {
      setSubmitting(false);
    }
  };

  const handleFinish = async () => {
    if (!sessionId) return;
    setSubmitting(true);
    try {
      await persistCurrentAnswer();
      await testsApi.endSession(sessionId);
      await recommendationsApi.generate(sessionId);

      invalidateTestCompletionCache();

      toast({
        title: t("orientationTest.testFinished"),
        description: t("orientationTest.testFinishedMessage"),
      });
      navigate("/recommendations");
    } catch (err) {
      setError(err instanceof Error ? err.message : t("orientationTest.errorFinishing"));
    } finally {
      setSubmitting(false);
    }
  };

  if (loading) {
    return (
      <DashboardLayout>
        <div className="mx-auto max-w-2xl text-center py-20">
          <p className="text-muted-foreground">{t("orientationTest.loading")}</p>
        </div>
      </DashboardLayout>
    );
  }

  if (error) {
    return (
      <DashboardLayout>
        <div className="mx-auto max-w-2xl text-center py-20">
          <h1 className="text-2xl font-bold mb-2">{t("orientationTest.unavailable")}</h1>
          <p className="text-muted-foreground mb-6">{error}</p>
          <Button onClick={() => navigate("/tests")}>{t("orientationTest.backToTests")}</Button>
        </div>
      </DashboardLayout>
    );
  }

  if (questions.length === 0) {
    return (
      <DashboardLayout>
        <div className="mx-auto max-w-2xl text-center py-20">
          <h1 className="text-2xl font-bold mb-2">{t("orientationTest.notFound")}</h1>
          <p className="text-muted-foreground mb-6">{t("orientationTest.noQuestions")}</p>
          <Button onClick={() => navigate("/tests")}>{t("orientationTest.backToTests")}</Button>
        </div>
      </DashboardLayout>
    );
  }

  const totalSteps = questions.length;
  const progress = ((currentStep + 1) / totalSteps) * 100;
  const q = questions[currentStep];
  const options = q.options || [];
  const selected = answers[q.id];

  return (
    <DashboardLayout>
      <div className="animate-fade-in h-full flex flex-col px-4 sm:px-6 lg:px-8 py-6">
        <div className="mb-6">
          <h1 className="text-3xl font-bold mb-2">{t("orientationTest.title")}</h1>
          <p className="text-muted-foreground">{t("orientationTest.subtitle")}</p>
        </div>

        <div className="mb-6">
          <div className="flex items-center justify-between mb-2 text-sm">
            <span className="font-medium text-muted-foreground">
              {t("orientationTest.question")} {currentStep + 1} {t("orientationTest.of")} {totalSteps}
            </span>
            <span className="font-semibold text-primary">{Math.round(progress)}%</span>
          </div>
          <Progress value={progress} className="h-2.5" />
          <div className="mt-4 flex justify-between gap-2 overflow-x-auto pb-2">
            {questions.map((_, i) => (
              <div
                key={i}
                className={cn(
                  "flex h-8 w-8 items-center justify-center rounded-full text-xs font-semibold transition-all shrink-0",
                  i < currentStep
                    ? "bg-success text-success-foreground"
                    : i === currentStep
                    ? "bg-primary text-primary-foreground"
                    : "bg-muted text-muted-foreground"
                )}
              >
                {i < currentStep ? <CheckCircle2 className="h-4 w-4" /> : i + 1}
              </div>
            ))}
          </div>
        </div>

        <div className="flex-1 rounded-xl border bg-card p-6 sm:p-8 shadow-card flex flex-col overflow-hidden">
          <div className="mb-2 text-xs font-semibold uppercase tracking-wider text-primary">
            {q.categorie}
          </div>
          <h2 className="text-xl font-semibold mb-6">{q.texte}</h2>
          <div className="flex-1 overflow-y-auto space-y-3 pr-2">
            {options.map((option) => (
              <button
                key={option.id}
                onClick={() => setAnswers((current) => ({ ...current, [q.id]: option.id }))}
                className={cn(
                  "w-full rounded-lg border p-4 text-left text-sm font-medium transition-all duration-200",
                  selected === option.id
                    ? "border-primary bg-accent text-accent-foreground shadow-sm"
                    : "border-border bg-background text-foreground hover:border-primary/30 hover:bg-accent/50"
                )}
              >
                <div className="flex items-center gap-3">
                  <div
                    className={cn(
                      "flex h-5 w-5 shrink-0 items-center justify-center rounded-full border-2 transition-all",
                      selected === option.id
                        ? "border-primary bg-primary"
                        : "border-muted-foreground/30"
                    )}
                  >
                    {selected === option.id && (
                      <CheckCircle2 className="h-3 w-3 text-primary-foreground" />
                    )}
                  </div>
                  {option.texte}
                </div>
              </button>
            ))}
          </div>
        </div>

        <div className="mt-6 flex justify-between gap-3 shrink-0">
          <Button
            variant="outline"
            onClick={handlePrevious}
            disabled={currentStep === 0 || submitting}
          >
            <ArrowLeft className="mr-1 h-4 w-4" /> {t("orientationTest.previous")}
          </Button>
          {currentStep < totalSteps - 1 ? (
            <Button onClick={handleNext} disabled={selected === undefined || submitting}>
              {t("orientationTest.next")} <ArrowRight className="ml-1 h-4 w-4" />
            </Button>
          ) : (
            <Button onClick={handleFinish} disabled={selected === undefined || submitting}>
              {t("orientationTest.finish")} <ArrowRight className="ml-1 h-4 w-4" />
            </Button>
          )}
        </div>
      </div>
    </DashboardLayout>
  );
};

export default OrientationTest;
