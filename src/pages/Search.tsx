import { useEffect, useMemo, useState } from "react";
import DashboardLayout from "@/components/DashboardLayout";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";
import { useTranslation } from "react-i18next";
import {
  Search as SearchIcon,
  Building2,
  GraduationCap,
  MapPin,
  Filter,
  X,
  ArrowRight,
} from "lucide-react";
import { universities as universitiesApi } from "@/lib/api";
import { cn } from "@/lib/utils";

interface SearchUniversity {
  id: number;
  name: string;
  province: string;
  city: string;
  type: "Public" | "Privé";
  specialties: string[];
  filieresCount: number;
  description?: string;
  logoUrl?: string;
}

const mapUniversity = (uni: any): SearchUniversity => {
  const filieres = Array.isArray(uni.filieres) ? uni.filieres : [];
  const specialties = filieres
    .map((f: any) => f.specialite || f.domaine || f.nom)
    .filter(Boolean);

  return {
    id: uni.id,
    name: uni.nom,
    province: uni.wilaya || uni.ville,
    city: uni.ville,
    type: uni.type === "publique" ? "Public" : "Privé",
    specialties,
    filieresCount: filieres.length,
    description: uni.description,
    logoUrl: uni.logo_url,
  };
};

const Search = () => {
  const { t } = useTranslation();
  const [query, setQuery] = useState("");
  const [typeFilter, setTypeFilter] = useState(t("search.all"));
  const [provinceFilter, setProvinceFilter] = useState(t("search.all"));
  const [universities, setUniversities] = useState<SearchUniversity[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;

    const loadUniversities = async () => {
      try {
        setLoading(true);
        const response = await universitiesApi.getAll(1, 10000);
        const items = Array.isArray(response?.universites) ? response.universites : [];
        if (!cancelled) {
          setUniversities(items.map(mapUniversity));
          setError(null);
        }
      } catch (err) {
        if (!cancelled) {
          setError(err instanceof Error ? err.message : t("common.loading"));
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    };

    loadUniversities();
    return () => {
      cancelled = true;
    };
  }, []);

  const typeFilters = [t("search.all"), "Public", "Privé"];
  const provinces = useMemo(() => [t("search.all"), ...Array.from(new Set(universities.map((uni) => uni.province)))], [universities]);

  const results = useMemo(() => {
    let filtered = universities;

    if (query.trim()) {
      const q = query.toLowerCase();
      filtered = filtered.filter((uni) => {
        const searchable = [
          uni.name,
          uni.city,
          uni.province,
          uni.description || "",
          ...uni.specialties,
        ]
          .join(" ")
          .toLowerCase();
        return searchable.includes(q);
      });
    }

    if (typeFilter !== t("search.all")) {
      filtered = filtered.filter((uni) => uni.type === typeFilter);
    }

    if (provinceFilter !== t("search.all")) {
      filtered = filtered.filter((uni) => uni.province === provinceFilter);
    }

    return filtered.sort((a, b) => a.name.localeCompare(b.name));
  }, [query, typeFilter, provinceFilter, universities]);

  return (
    <DashboardLayout>
      <div className="animate-fade-in">
        <div className="mb-8">
          <h1 className="text-3xl font-bold">{t("search.title")}</h1>
          <p className="mt-1 text-muted-foreground">
            {t("dashboard.searchDesc")}
          </p>
        </div>

        <div className="mb-6 space-y-4">
          <div className="relative">
            <SearchIcon className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
            <Input
              placeholder={t("search.searchPlaceholder")}
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              className="pl-10"
            />
            {query && (
              <button
                onClick={() => setQuery("")}
                className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground"
              >
                <X className="h-4 w-4" />
              </button>
            )}
          </div>

          <div className="flex flex-wrap gap-2">
            <div className="flex items-center gap-2 flex-wrap">
              <Filter className="h-4 w-4 text-muted-foreground" />
              <div className="flex flex-wrap gap-2">
                {typeFilters.map((type) => (
                  <Button
                    key={type}
                    variant={typeFilter === type ? "default" : "outline"}
                    size="sm"
                    onClick={() => setTypeFilter(type)}
                  >
                    {type}
                  </Button>
                ))}
              </div>
            </div>
          </div>

          <div className="flex items-center gap-2 flex-wrap">
            <MapPin className="h-4 w-4 text-muted-foreground" />
            <div className="flex flex-wrap gap-2">
              {provinces.map((province) => (
                <Button
                  key={province}
                  variant={provinceFilter === province ? "default" : "outline"}
                  size="sm"
                  onClick={() => setProvinceFilter(province)}
                  className="text-xs"
                >
                  {province}
                </Button>
              ))}
            </div>
          </div>
        </div>

        <div className="mb-4 flex items-center justify-between">
          <p className="text-sm text-muted-foreground">
            {results.length} établissement{results.length !== 1 ? "s" : ""} trouvé{results.length !== 1 ? "s" : ""}
          </p>
        </div>

        {loading ? (
          <div className="rounded-xl border bg-card p-12 text-center shadow-card">
            <p className="text-sm text-muted-foreground">{t("common.loading")}</p>
          </div>
        ) : error ? (
          <div className="rounded-xl border bg-card p-12 text-center shadow-card">
            <p className="text-sm text-destructive">{error}</p>
          </div>
        ) : results.length === 0 ? (
          <div className="flex flex-col items-center justify-center rounded-xl border bg-card p-12 text-center shadow-card">
            <SearchIcon className="h-12 w-12 text-muted-foreground mb-4" />
            <h3 className="text-lg font-semibold mb-2">{t("search.noResults")}</h3>
            <p className="text-sm text-muted-foreground">
              {t("search.filterBy")}
            </p>
          </div>
        ) : (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {results.map((uni) => (
              <Link key={uni.id} to={`/university/${uni.id}`}>
                <div
                  className="group h-full overflow-hidden rounded-xl border shadow-card transition-all duration-300 hover:-translate-y-1 hover:shadow-card-hover relative"
                  style={{
                    backgroundImage: uni.logoUrl ? `url(${uni.logoUrl})` : undefined,
                    backgroundSize: 'cover',
                    backgroundPosition: 'center',
                  }}
                >
                  {/* Blurred background overlay */}
                  {uni.logoUrl && (
                    <div className="absolute inset-0 bg-card/55 backdrop-blur-xs" />
                  )}
                  <div className="flex h-full flex-col p-5 relative z-10">
                    <div className="mb-3 flex items-start justify-between">
                      <div className="flex h-11 w-11 items-center justify-center rounded-lg bg-primary/10 overflow-hidden flex-shrink-0">
                        {uni.logoUrl ? (
                          <img
                            src={uni.logoUrl}
                            alt={uni.name}
                            className="h-full w-full object-cover"
                            onError={(e) => {
                              (e.target as HTMLImageElement).style.display = 'none';
                            }}
                          />
                        ) : (
                          <Building2 className="h-5 w-5 text-primary" />
                        )}
                      </div>
                      <Badge
                        variant="outline"
                        className={cn(
                          uni.type === "Public"
                            ? "border-success text-success"
                            : "border-info text-info"
                        )}
                      >
                        {uni.type}
                      </Badge>
                    </div>
                    <h3 className="mb-1 line-clamp-2 font-semibold text-foreground">{uni.name}</h3>
                    <div className="mb-2 flex items-center gap-1 text-sm text-foreground">
                      <MapPin className="h-3.5 w-3.5 shrink-0" />
                      <span className="text-xs">{uni.city}, {uni.province}</span>
                    </div>
                    <div className="mb-3 flex items-center gap-1 text-xs text-foreground">
                      <GraduationCap className="h-3.5 w-3.5 shrink-0" />
                      {uni.filieresCount} filière{uni.filieresCount > 1 ? "s" : ""}
                    </div>
                    <div className="mb-3 flex flex-1 flex-wrap gap-1.5">
                      {uni.specialties.slice(0, 2).map((spec) => (
                        <Badge key={spec} variant="secondary" className="text-xs font-normal">
                          {spec}
                        </Badge>
                      ))}
                      {uni.specialties.length > 2 && (
                        <Badge variant="secondary" className="text-xs font-normal">
                          +{uni.specialties.length - 2}
                        </Badge>
                      )}
                    </div>
                    <div className="mt-auto flex items-center gap-1 text-xs font-medium text-primary group-hover:gap-2 transition-all">
                      Détails <ArrowRight className="h-3.5 w-3.5" />
                    </div>
                  </div>
                </div>
              </Link>
            ))}
          </div>
        )}
      </div>
    </DashboardLayout>
  );
};

export default Search;
