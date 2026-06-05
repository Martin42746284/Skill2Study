import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { Heart, Eye, Trash2, Building2, BookOpen, Inbox, Loader2 } from "lucide-react";
import { useTranslation } from "react-i18next";
import { Button } from "@/components/ui/button";
import DashboardLayout from "@/components/DashboardLayout";
import { users as usersApi } from "@/lib/api";

type FavoriteRecord = {
  id: number;
  createdAt?: string;
  filiere: {
    id: number;
    nom: string;
    domaine?: string;
    niveau?: string;
    universite?: {
      id: number;
      nom: string;
      ville?: string;
    };
  };
};

const Favorites = () => {
  const { t } = useTranslation();
  const [favorites, setFavorites] = useState<FavoriteRecord[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [removingId, setRemovingId] = useState<number | null>(null);

  useEffect(() => {
    let active = true;

    const loadFavorites = async () => {
      try {
        const response = await usersApi.getFavoris();
        if (!active) return;
        setFavorites(response.favoris || []);
      } catch (err) {
        if (!active) return;
        setError(err instanceof Error ? err.message : t("favorites.error"));
      } finally {
        if (active) setLoading(false);
      }
    };

    loadFavorites();
    return () => {
      active = false;
    };
  }, []);

  const removeFavorite = async (filiereId: number) => {
    setRemovingId(filiereId);
    try {
      await usersApi.removeFavori(filiereId);
      setFavorites((current) => current.filter((fav) => fav.filiere.id !== filiereId));
    } finally {
      setRemovingId(null);
    }
  };

  if (loading) {
    return (
      <DashboardLayout>
        <div className="flex min-h-[40vh] items-center justify-center">
          <div className="flex items-center gap-3 text-muted-foreground">
            <Loader2 className="h-5 w-5 animate-spin" />
            {t("favorites.loading")}
          </div>
        </div>
      </DashboardLayout>
    );
  }

  if (error) {
    return (
      <DashboardLayout>
        <div className="rounded-xl border bg-card p-6 shadow-card">
          <h1 className="text-xl font-semibold">{t("favorites.error")}</h1>
          <p className="mt-2 text-sm text-muted-foreground">{error}</p>
        </div>
      </DashboardLayout>
    );
  }

  const universityCount = new Set(favorites.map((fav) => fav.filiere.universite?.id).filter(Boolean)).size;

  return (
    <DashboardLayout>
      <div className="animate-fade-in">
        <div className="mb-6 sm:mb-8">
          <div className="mb-1 flex items-center gap-2">
            <Heart className="h-4 sm:h-5 w-4 sm:w-5 text-primary shrink-0" />
            <h1 className="text-2xl sm:text-3xl font-bold">{t("favorites.title")}</h1>
          </div>
          <p className="text-xs sm:text-sm text-muted-foreground">{t("dashboard.sidebar.favorites")}</p>
        </div>

        <div className="mb-6 sm:mb-8 grid gap-3 sm:gap-4 grid-cols-1 sm:grid-cols-2">
          <div className="rounded-xl border bg-card p-4 sm:p-5 shadow-card">
            <div className="mb-2 flex items-center gap-2 sm:gap-3">
              <div className="flex h-9 sm:h-10 w-9 sm:w-10 items-center justify-center rounded-lg bg-primary/10 shrink-0">
                <Building2 className="h-4 sm:h-5 w-4 sm:w-5 text-primary" />
              </div>
              <p className="text-xs sm:text-sm text-muted-foreground">{t("search.fields")}</p>
            </div>
            <p className="text-2xl sm:text-3xl font-bold">{favorites.length}</p>
          </div>
          <div className="rounded-xl border bg-card p-4 sm:p-5 shadow-card">
            <div className="mb-2 flex items-center gap-2 sm:gap-3">
              <div className="flex h-9 sm:h-10 w-9 sm:w-10 items-center justify-center rounded-lg bg-secondary/10 shrink-0">
                <BookOpen className="h-4 sm:h-5 w-4 sm:w-5 text-secondary" />
              </div>
              <p className="text-xs sm:text-sm text-muted-foreground">{t("search.universities")}</p>
            </div>
            <p className="text-2xl sm:text-3xl font-bold">{universityCount}</p>
          </div>
        </div>

        {favorites.length === 0 ? (
          <div className="flex flex-col items-center justify-center rounded-xl border bg-card p-8 sm:p-12 text-center shadow-card">
            <Inbox className="mb-4 h-10 sm:h-12 w-10 sm:w-12 text-muted-foreground/40" />
            <h3 className="mb-2 text-base sm:text-lg font-semibold">{t("favorites.empty")}</h3>
            <p className="mb-4 text-xs sm:text-sm text-muted-foreground">
              {t("dashboard.recommendationsDesc")}
            </p>
            <Link to="/recommendations">
              <Button variant="hero" className="text-sm">{t("recommendations.viewRecommendations")}</Button>
            </Link>
          </div>
        ) : (
          <div className="space-y-2 sm:space-y-3">
            {favorites.map((fav) => (
              <div
                key={fav.id}
                className="rounded-xl border bg-card p-4 sm:p-5 shadow-card transition-all hover:shadow-card-hover"
              >
                <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 sm:gap-4">
                  <div className="flex min-w-0 flex-1 items-center gap-2 sm:gap-3">
                    <div className="flex h-9 sm:h-10 w-9 sm:w-10 shrink-0 items-center justify-center rounded-lg bg-primary/10">
                      <Building2 className="h-4 sm:h-5 w-4 sm:w-5 text-primary" />
                    </div>
                    <div className="min-w-0 flex-1">
                      <p className="truncate font-semibold text-sm sm:text-base">{fav.filiere.nom}</p>
                      <p className="text-xs text-muted-foreground truncate">
                        {fav.filiere.universite?.nom}
                        {fav.filiere.universite?.ville ? ` · ${fav.filiere.universite.ville}` : ""}
                        {fav.createdAt
                          ? ` · ${t("history.date")} ${new Date(fav.createdAt).toLocaleDateString("fr-FR", {
                              day: "numeric",
                              month: "long",
                              year: "numeric",
                            })}`
                          : ""}
                      </p>
                    </div>
                  </div>
                  <div className="flex shrink-0 items-center gap-2 sm:flex-col sm:gap-2">
                    {fav.filiere.universite?.id && (
                      <Link to={`/university/${fav.filiere.universite.id}`}>
                        <Button variant="outline" size="sm" className="text-xs">
                          <Eye className="mr-1 h-3 sm:h-4 w-3 sm:w-4" />
                          {t("favorites.view")}
                        </Button>
                      </Link>
                    )}
                    <Button
                      variant="ghost"
                      size="sm"
                      className="text-destructive hover:text-destructive"
                      onClick={() => removeFavorite(fav.filiere.id)}
                      disabled={removingId === fav.filiere.id}
                    >
                      <Trash2 className="h-3 sm:h-4 w-3 sm:w-4" />
                    </Button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </DashboardLayout>
  );
};

export default Favorites;
