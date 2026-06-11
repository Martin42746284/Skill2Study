import { useEffect, useMemo, useState } from "react";
import DashboardLayout from "@/components/DashboardLayout";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Link, useParams } from "react-router-dom";
import { useTranslation } from "react-i18next";
import {
  ArrowLeft,
  MapPin,
  Clock,
  Briefcase,
  GraduationCap,
  Globe,
  BookOpen,
  Building2,
  CheckCircle2,
  ExternalLink,
  Phone,
  Heart,
  Award,
} from "lucide-react";
import { users as usersApi, universities as universitiesApi } from "@/lib/api";

interface UniversityParcours {
  id: number;
  nom: string;
  specialisation?: string | null;
}

interface UniversityFiliere {
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
}

interface UniversityDetailsData {
  id: number;
  nom: string;
  type: string;
  ville: string;
  wilaya?: string | null;
  adresse?: string | null;
  site_web?: string | null;
  email_contact?: string | null;
  telephone?: string | null;
  description?: string | null;
  date_fondation?: number | null;
  filieres?: UniversityFiliere[];
}

const formatUniversityType = (type: string) => {
  if (type === "publique") return "Public";
  if (type === "privee") return "Privé";
  return type;
};

const formatMoney = (amount?: number | null) => {
  if (amount == null) return "Non renseigné";
  return `${new Intl.NumberFormat("fr-FR").format(amount)} Ar/an`;
};

const UniversityDetails = () => {
  const { id } = useParams();
  const { t } = useTranslation();
  const [university, setUniversity] = useState<UniversityDetailsData | null>(null);
  const [favoriteIds, setFavoriteIds] = useState<number[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [savingId, setSavingId] = useState<number | null>(null);

  useEffect(() => {
    let cancelled = false;

    const loadUniversity = async () => {
      const universityId = Number(id);
      if (!Number.isFinite(universityId)) {
        setError("Université introuvable.");
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        const [universityResponse, favoritesResponse] = await Promise.all([
          universitiesApi.getById(universityId),
          usersApi.getFavoris(),
        ]);

        if (!cancelled) {
          setUniversity(universityResponse?.universite || null);
          const favoris = Array.isArray(favoritesResponse?.favoris) ? favoritesResponse.favoris : [];
          setFavoriteIds(
            favoris
              .map((favori: any) => Number(favori.filiere_id || favori.filiere?.id))
              .filter((value: number) => Number.isFinite(value))
          );
          setError(null);
        }
      } catch (err) {
        if (!cancelled) {
          setError(err instanceof Error ? err.message : "Impossible de charger l'université.");
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    };

    loadUniversity();
    return () => {
      cancelled = true;
    };
  }, [id]);

  const filieres = university?.filieres || [];
  const totalParcours = useMemo(
    () => filieres.reduce((sum, filiere) => sum + (filiere.parcours?.length || 0), 0),
    [filieres]
  );
  const description =
    university?.description ||
    (university
      ? `${university.nom} est un établissement d'enseignement supérieur à ${university.ville}.`
      : "");

  const toggleFavorite = async (filiereId: number) => {
    try {
      setSavingId(filiereId);
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

  if (loading) {
    return (
      <DashboardLayout>
        <div className="animate-fade-in text-center py-20">
          <p className="text-muted-foreground">{t("common.loading")}</p>
        </div>
      </DashboardLayout>
    );
  }

  if (error || !university) {
    return (
      <DashboardLayout>
        <div className="animate-fade-in text-center py-20">
          <Building2 className="h-12 w-12 mx-auto mb-4 text-muted-foreground opacity-40" />
          <h1 className="text-2xl font-bold mb-2">Université introuvable</h1>
          <p className="text-muted-foreground mb-4">{error || "L'université demandée n'existe pas."}</p>
          <Link to="/dashboard/search">
            <Button variant="outline">
              <ArrowLeft className="h-4 w-4 mr-1" /> Retour à la recherche
            </Button>
          </Link>
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout>
      <div className="animate-fade-in">
        <Link to="/dashboard/search" className="inline-flex items-center gap-1 text-sm text-muted-foreground hover:text-foreground mb-6 transition-colors">
          <ArrowLeft className="h-4 w-4" /> Retour à la recherche
        </Link>

        <div className="mb-8 rounded-xl border bg-card p-6 shadow-card">
          <div className="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
            <div className="flex-1">
              <div className="flex items-center gap-2 mb-2 flex-wrap">
                <span className={`rounded-full px-3 py-1 text-xs font-semibold ${
                  university.type === "publique"
                    ? "bg-success/10 text-success"
                    : "bg-info/10 text-info"
                }`}>
                  {formatUniversityType(university.type)}
                </span>
                <span className="rounded-full bg-accent px-3 py-1 text-xs font-semibold text-accent-foreground">
                  {filieres.length} filière{filieres.length > 1 ? "s" : ""}
                </span>
                {university.date_fondation && (
                  <span className="rounded-full bg-muted px-3 py-1 text-xs font-semibold text-muted-foreground">
                    Fondée en {university.date_fondation}
                  </span>
                )}
              </div>
              <h1 className="text-3xl font-bold mt-2">{university.nom}</h1>
              <div className="mt-2 flex flex-wrap gap-3 text-sm text-muted-foreground">
                <div className="flex items-center gap-1">
                  <MapPin className="h-4 w-4" /> {university.ville}{university.wilaya ? `, ${university.wilaya}` : ""}
                </div>
                {university.telephone && (
                  <div className="flex items-center gap-1">
                    <Phone className="h-4 w-4" /> {university.telephone}
                  </div>
                )}
                {university.email_contact && (
                  <div className="flex items-center gap-1 break-all">
                    <Globe className="h-4 w-4" /> {university.email_contact}
                  </div>
                )}
              </div>
            </div>
            {university.site_web && (
              <div className="flex flex-col gap-2 sm:flex-row">
                <a href={university.site_web.startsWith("http") ? university.site_web : `https://${university.site_web}`} target="_blank" rel="noopener noreferrer">
                  <Button variant="outline" className="w-full">
                    <ExternalLink className="mr-1 h-4 w-4" /> Site officiel
                  </Button>
                </a>
              </div>
            )}
          </div>
        </div>

        <div className="mb-8 grid gap-4 sm:grid-cols-4">
          <div className="rounded-xl border bg-card p-4 shadow-card">
            <div className="flex items-center gap-2 mb-2">
              <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-primary/10">
                <GraduationCap className="h-4 w-4 text-primary" />
              </div>
              <p className="text-xs text-muted-foreground">Filières</p>
            </div>
            <p className="text-2xl font-bold">{filieres.length}</p>
          </div>
          <div className="rounded-xl border bg-card p-4 shadow-card">
            <div className="flex items-center gap-2 mb-2">
              <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-success/10">
                <BookOpen className="h-4 w-4 text-success" />
              </div>
              <p className="text-xs text-muted-foreground">Parcours</p>
            </div>
            <p className="text-2xl font-bold">{totalParcours}</p>
          </div>
          <div className="rounded-xl border bg-card p-4 shadow-card">
            <div className="flex items-center gap-2 mb-2">
              <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-warning/10">
                <Clock className="h-4 w-4 text-warning" />
              </div>
              <p className="text-xs text-muted-foreground">Ville</p>
            </div>
            <p className="text-sm font-bold">{university.ville}</p>
          </div>
          <div className="rounded-xl border bg-card p-4 shadow-card">
            <div className="flex items-center gap-2 mb-2">
              <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-secondary/10">
                <Award className="h-4 w-4 text-secondary" />
              </div>
              <p className="text-xs text-muted-foreground">Type</p>
            </div>
            <p className="text-sm font-bold">{formatUniversityType(university.type)}</p>
          </div>
        </div>

        <div className="mb-8 rounded-xl border bg-card p-6 shadow-card">
          <h2 className="text-lg font-semibold mb-3">À propos</h2>
          <p className="text-sm text-muted-foreground leading-relaxed">{description}</p>
          <div className="mt-4 flex flex-wrap gap-4 text-xs text-muted-foreground pt-4 border-t">
            {university.adresse && (
              <span className="flex items-center gap-1">
                <MapPin className="h-3.5 w-3.5" /> {university.adresse}
              </span>
            )}
            {university.telephone && (
              <span className="flex items-center gap-1">
                <Phone className="h-3.5 w-3.5" /> {university.telephone}
              </span>
            )}
            {university.site_web && (
              <span className="flex items-center gap-1 break-all">
                <Globe className="h-3.5 w-3.5" /> {university.site_web}
              </span>
            )}
          </div>
        </div>

        <div className="mb-8 rounded-xl border bg-card p-6 shadow-card">
          <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
            <GraduationCap className="h-5 w-5 text-primary" />
            Filières ({filieres.length})
          </h2>
          <div className="space-y-4">
            {filieres.length === 0 ? (
              <div className="rounded-lg border p-4 text-sm text-muted-foreground">
                Aucune filière disponible pour cet établissement.
              </div>
            ) : (
              filieres.map((filiere) => {
                const isSaved = favoriteIds.includes(filiere.id);
                const specialite = filiere.specialite || filiere.domaine || filiere.nom;
                return (
                  <div key={filiere.id} className="rounded-xl border p-5">
                    <div className="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-2 flex-wrap mb-2">
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
                        <p className="text-sm text-muted-foreground mb-4">{specialite}</p>
                        <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4 text-sm">
                          <div className="rounded-lg bg-accent/50 p-3">
                            <p className="text-xs uppercase tracking-wider text-muted-foreground mb-1">Durée</p>
                            <p className="font-medium">{filiere.duree_annees || "Non renseignée"}</p>
                          </div>
                          <div className="rounded-lg bg-accent/50 p-3">
                            <p className="text-xs uppercase tracking-wider text-muted-foreground mb-1">Coût</p>
                            <p className="font-medium">{formatMoney(filiere.cout_annuel)}</p>
                            {filiere.cout_description && (
                              <p className="text-xs text-muted-foreground mt-1">{filiere.cout_description}</p>
                            )}
                          </div>
                          <div className="rounded-lg bg-accent/50 p-3">
                            <p className="text-xs uppercase tracking-wider text-muted-foreground mb-1">Langue</p>
                            <p className="font-medium">{filiere.langue || "Non renseignée"}</p>
                          </div>
                          <div className="rounded-lg bg-accent/50 p-3">
                            <p className="text-xs uppercase tracking-wider text-muted-foreground mb-1">Emploi</p>
                            <p className="font-medium">{filiere.taux_emploi ? `${Math.round(filiere.taux_emploi)}%` : "Non renseigné"}</p>
                          </div>
                        </div>
                        {filiere.parcours && filiere.parcours.length > 0 && (
                          <div className="mt-4">
                            <p className="text-xs font-semibold uppercase tracking-wider text-muted-foreground mb-2">
                              Parcours
                            </p>
                            <div className="flex flex-wrap gap-2">
                              {filiere.parcours.map((parcours) => (
                                <span key={parcours.id} className="rounded-full bg-muted px-3 py-1 text-xs font-medium text-muted-foreground">
                                  {parcours.nom}
                                </span>
                              ))}
                            </div>
                          </div>
                        )}
                      </div>
                      <div className="flex flex-col gap-2 lg:w-56">
                        <Button
                          variant={isSaved ? "default" : "outline"}
                          onClick={() => toggleFavorite(filiere.id)}
                          disabled={savingId === filiere.id}
                        >
                          <Heart className={`mr-1 h-4 w-4 ${isSaved ? "fill-current" : ""}`} />
                          {isSaved ? "Sauvegardée" : "Sauvegarder"}
                        </Button>
                      </div>
                    </div>
                  </div>
                );
              })
            )}
          </div>
        </div>

        <div className="mt-8 rounded-xl border bg-gradient-to-r from-primary/10 to-accent/10 p-6 text-center">
          <h3 className="text-lg font-semibold mb-2">Intéressé par cet établissement ?</h3>
          <p className="text-sm text-muted-foreground mb-4">
            Consultez les filières disponibles et sauvegardez celles qui correspondent à votre profil.
          </p>
          <div className="flex flex-col gap-2 sm:flex-row sm:justify-center">
            <Link to="/recommendations">
              <Button variant="default">
                <Heart className="mr-1 h-4 w-4" /> Voir mes recommandations
              </Button>
            </Link>
            {university.site_web && (
              <a href={university.site_web.startsWith("http") ? university.site_web : `https://${university.site_web}`} target="_blank" rel="noopener noreferrer">
                <Button variant="outline">
                  <ExternalLink className="mr-1 h-4 w-4" /> Visiter le site
                </Button>
              </a>
            )}
          </div>
        </div>
      </div>
    </DashboardLayout>
  );
};

export default UniversityDetails;
