import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Heart, Zap, BookOpen } from "lucide-react";
import { useTranslation } from "react-i18next";

interface UniversityParcours {
  id: number;
  nom: string;
  specialisation?: string | null;
}

interface FiliereCardProps {
  filiere: {
    id: number;
    nom: string;
    code?: string | null;
    domaine?: string | null;
    specialite?: string | null;
    niveaux?: string[] | null;
    duree_annees?: string | null;
    cout_annuel?: number | null;
    cout_description?: string | null;
    langue?: string | null;
    moyenne_min_requise?: number | null;
    difficulte?: string | null;
    taux_emploi?: number | null;
    debouches?: string[] | null;
    description?: string | null;
    parcours?: UniversityParcours[];
  };
  isSaved: boolean;
  onToggleFavorite: () => void;
  recommendation?: {
    score_compatibilite: number;
  };
  isSaving?: boolean;
}

export function FiliereCard({
  filiere,
  isSaved,
  onToggleFavorite,
  recommendation,
  isSaving = false
}: FiliereCardProps) {
  const { t } = useTranslation();

  const formatMoney = (amount?: number | null) => {
    if (amount == null) return null;
    return `${new Intl.NumberFormat("fr-FR").format(amount)} DA`;
  };

  const specialite = filiere.specialite || filiere.domaine || filiere.nom;
  const score = recommendation?.score_compatibilite || 0;

  // Collecter les champs à afficher (non vides)
  const fields = [
    filiere.duree_annees && {
      label: t("universityDetails.duration"),
      value: filiere.duree_annees,
      icon: "⏱️"
    },
    formatMoney(filiere.cout_annuel) && {
      label: t("universityDetails.cost"),
      value: formatMoney(filiere.cout_annuel),
      icon: "💰",
      description: filiere.cout_description
    },
    filiere.langue && {
      label: t("universityDetails.language"),
      value: filiere.langue,
      icon: "🌐"
    },
    filiere.taux_emploi && {
      label: t("universityDetails.employmentRate"),
      value: `${Math.round(filiere.taux_emploi)}%`,
      icon: "📊"
    }
  ].filter(Boolean);

  return (
    <div className="rounded-xl border bg-card p-6 shadow-card hover:shadow-md transition-shadow">
      {/* Indicateur de recommandation */}
      {recommendation && (
        <div className="mb-4 rounded-lg bg-primary/5 border border-primary/20 p-3 flex items-center gap-2">
          <Zap className="h-4 w-4 text-primary flex-shrink-0" />
          <p className="text-xs font-semibold text-primary">
            Recommandée ({Math.round(score)}%)
          </p>
        </div>
      )}

      <div className="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
        <div className="flex-1 min-w-0">
          {/* Titre et badges */}
          <div className="flex items-center gap-2 flex-wrap mb-3">
            <h3 className="font-semibold text-lg">{filiere.nom}</h3>
            {filiere.niveaux && filiere.niveaux.map(n => (
              <Badge key={n} variant="secondary" className="text-xs">
                {n}
              </Badge>
            ))}
            {filiere.difficulte && (
              <Badge variant="outline" className="text-xs">
                {filiere.difficulte}
              </Badge>
            )}
          </div>

          {/* Sous-titre */}
          {specialite !== filiere.nom && (
            <p className="text-sm text-muted-foreground mb-4">{specialite}</p>
          )}

          {/* Grille d'informations - affichage conditionnel */}
          {fields.length > 0 && (
            <div className={`grid gap-3 mb-4 ${
              fields.length <= 2 ? 'grid-cols-2' :
              fields.length === 3 ? 'sm:grid-cols-3' :
              'sm:grid-cols-2 lg:grid-cols-4'
            }`}>
              {fields.map((field, idx) => (
                <div key={idx} className="rounded-lg bg-muted p-3">
                  <p className="text-xs uppercase tracking-wider text-muted-foreground mb-1">
                    {field.label}
                  </p>
                  <p className="font-medium text-sm">{field.value}</p>
                  {field.description && (
                    <p className="text-xs text-muted-foreground mt-1">{field.description}</p>
                  )}
                </div>
              ))}
            </div>
          )}

          {/* Parcours */}
          {filiere.parcours && filiere.parcours.length > 0 && (
            <div>
              <p className="text-xs font-semibold uppercase tracking-wider text-muted-foreground mb-2 flex items-center gap-1">
                <BookOpen className="h-3 w-3" />
                {t("universityDetails.programs")}
              </p>
              <div className="flex flex-wrap gap-2">
                {filiere.parcours.map((parcours) => (
                  <span 
                    key={parcours.id} 
                    className="rounded-full bg-primary/10 text-primary px-3 py-1 text-xs font-medium"
                  >
                    {parcours.nom}
                  </span>
                ))}
              </div>
            </div>
          )}
        </div>

        {/* Bouton favoris */}
        <div className="flex flex-col gap-2 lg:w-48 shrink-0">
          <Button
            variant={isSaved ? "default" : "outline"}
            onClick={onToggleFavorite}
            disabled={isSaving}
            className="w-full"
          >
            <Heart className={`mr-1 h-4 w-4 ${isSaved ? "fill-current" : ""}`} />
            {isSaved ? t("universityDetails.saved") : t("universityDetails.save")}
          </Button>
        </div>
      </div>
    </div>
  );
}
