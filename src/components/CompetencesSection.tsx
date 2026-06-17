import { Sparkles } from "lucide-react";
import { useTranslation } from "react-i18next";
import { Label } from "@/components/ui/label";
import { cn } from "@/lib/utils";

interface Competence {
  name: string;
  key: string;
}

interface CompetencesSectionProps {
  competences: Record<string, number>;
  options: Competence[];
  onCompetenceChange: (key: string, value: number) => void;
  title?: string;
  description?: string;
}

export function CompetencesSection({
  competences,
  options,
  onCompetenceChange,
  title = "profile.competencesTitle",
  description = "profile.competencesDescription"
}: CompetencesSectionProps) {
  const { t } = useTranslation();

  const getCompetenceColor = (level: number) => {
    if (level === 0) return "bg-slate-200 dark:bg-slate-700";
    if (level === 1) return "bg-blue-300 dark:bg-blue-600";
    if (level === 2) return "bg-cyan-400 dark:bg-cyan-500";
    if (level === 3) return "bg-green-400 dark:bg-green-500";
    if (level === 4) return "bg-amber-400 dark:bg-amber-500";
    return "bg-red-500 dark:bg-red-600";
  };

  const getLevelLabel = (level: number) => {
    const labels = ["Novice", "Débutant", "Intermédiaire", "Avancé", "Expert", "Maître"];
    return labels[level] || "Novice";
  };

  return (
    <div className="rounded-xl border bg-card p-6 shadow-card">
      <h3 className="mb-2 text-lg font-semibold flex items-center gap-2">
        <Sparkles className="h-5 w-5 text-primary" />
        {t(title)}
      </h3>
      <p className="text-sm text-muted-foreground mb-8">
        {t(description)}
      </p>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {options.map((comp) => {
          const level = competences[comp.key] || 0;
          return (
            <div key={comp.key} className="space-y-3">
              {/* Competence Header */}
              <div className="flex items-center justify-between">
                <Label htmlFor={`competence_${comp.key}`} className="text-sm font-semibold text-foreground">
                  {comp.name}
                </Label>
                <div className="flex items-center gap-2">
                  <span className="text-xs font-bold text-primary">
                    {level}/5
                  </span>
                  <span className="text-xs px-2 py-1 rounded-full bg-primary/10 text-primary font-medium">
                    {getLevelLabel(level)}
                  </span>
                </div>
              </div>

              {/* Stars / Rating System */}
              <div className="flex gap-1.5">
                {[0, 1, 2, 3, 4].map((i) => (
                  <button
                    key={i}
                    onClick={() => onCompetenceChange(comp.key, i + 1)}
                    className={cn(
                      "flex-1 h-2 rounded-full transition-all duration-200 hover:h-3 cursor-pointer",
                      i < level ? "bg-primary" : "bg-muted hover:bg-muted-foreground/50"
                    )}
                    title={`${i + 1}/5`}
                  />
                ))}
              </div>

              {/* Color Progress Bar */}
              <div
                className={cn(
                  "h-2 rounded-full transition-all duration-300 w-full",
                  getCompetenceColor(level)
                )}
                style={{ width: `${(level / 5) * 100}%` }}
              />
            </div>
          );
        })}
      </div>

      {Object.keys(competences).length === 0 && (
        <div className="mt-8 p-4 rounded-lg border border-dashed border-muted-foreground/30 bg-muted/30">
          <p className="text-sm text-muted-foreground text-center">
            {t("profile.noCompetences")}
          </p>
        </div>
      )}
    </div>
  );
}
