import { Heart, Sparkles, Check } from "lucide-react";
import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";

interface InterestsSectionProps {
  interests: string[];
  options: string[];
  onInterestChange: (interests: string[]) => void;
  title?: string;
  description?: string;
}

export function InterestsSection({
  interests,
  options,
  onInterestChange,
  title = "profile.interestsTitle",
  description = "profile.interestsDescription"
}: InterestsSectionProps) {
  const { t } = useTranslation();

  const toggleInterest = (interest: string) => {
    if (interests.includes(interest)) {
      onInterestChange(interests.filter(i => i !== interest));
    } else {
      onInterestChange([...interests, interest]);
    }
  };

  return (
    <div className="rounded-xl border bg-card p-6 shadow-card">
      <h3 className="mb-2 text-lg font-semibold flex items-center gap-2">
        <Heart className="h-5 w-5 text-rose-500" />
        {t(title)}
      </h3>
      <p className="text-sm text-muted-foreground mb-8">
        {t(description)}
      </p>

      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3 mb-6">
        {options.map((interest) => {
          const isSelected = interests.includes(interest);
          return (
            <button
              key={interest}
              onClick={() => toggleInterest(interest)}
              className={cn(
                "px-4 py-3 rounded-lg text-sm font-medium transition-all duration-200",
                "flex items-center justify-between cursor-pointer",
                isSelected
                  ? "bg-primary text-primary-foreground shadow-sm"
                  : "bg-background border border-input text-foreground hover:bg-accent hover:text-accent-foreground"
              )}
            >
              <span className="flex-1 text-left">{interest}</span>
              {isSelected && (
                <Check className="h-4 w-4 ml-2 flex-shrink-0" />
              )}
            </button>
          );
        })}
      </div>

      {interests.length === 0 && (
        <div className="p-4 rounded-lg border border-dashed border-muted-foreground/30 bg-muted/30 flex items-start gap-3">
          <Sparkles className="h-5 w-5 text-amber-500 flex-shrink-0 mt-0.5" />
          <p className="text-sm text-muted-foreground">
            {t("profile.interestsTip")}
          </p>
        </div>
      )}

      {interests.length > 0 && (
        <div className="p-4 rounded-lg border border-muted-foreground/20 bg-muted">
          <p className="text-xs font-semibold text-foreground mb-3">
            Intérêts sélectionnés ({interests.length})
          </p>
          <div className="flex flex-wrap gap-2">
            {interests.map((interest) => (
              <span
                key={interest}
                className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-primary/10 border border-primary/30 text-primary text-xs font-medium"
              >
                {interest}
                <button
                  onClick={() => toggleInterest(interest)}
                  className="ml-1 hover:text-primary-foreground transition-colors"
                  title="Supprimer"
                >
                  ✕
                </button>
              </span>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
