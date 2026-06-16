import DashboardLayout from "@/components/DashboardLayout";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import { Slider } from "@/components/ui/slider";
import {
  User,
  Mail,
  Phone,
  GraduationCap,
  MapPin,
  Calendar,
  Save,
  Camera,
  AlertCircle,
  Loader2,
  Sparkles,
  Target,
} from "lucide-react";
import { useState, useRef, useEffect } from "react";
import { useToast } from "@/hooks/use-toast";
import { useTranslation } from "react-i18next";
import { users as usersApi } from "@/lib/api";

const SERIES_BAC_OPTIONS = [
  { value: "A1", label: "seriesBac.serieA1" },
  { value: "A2", label: "seriesBac.serieA2" },
  { value: "C", label: "seriesBac.serieC" },
  { value: "D", label: "seriesBac.serieD" },
  { value: "S", label: "seriesBac.serieS" },
  { value: "OSE", label: "seriesBac.serieOSE" },
  { value: "L", label: "seriesBac.serieL" },
  { value: "Technique", label: "seriesBac.serieTechnique" },
  { value: "Toutes séries", label: "seriesBac.serieToutesSeries" }
];

const CENTRES_INTERET_OPTIONS = [
  "Informatique",
  "Médecine",
  "Droit",
  "Commerce",
  "Sciences",
  "Ingénierie",
  "Arts",
  "Lettres",
  "Histoire",
  "Économie",
  "Psychologie",
  "Environnement",
  "Cuisine",
  "Sports",
  "Musique",
  "Théâtre"
];

const COMPETENCES_OPTIONS = [
  { name: "Logique", key: "logique" },
  { name: "Communication", key: "communication" },
  { name: "Créativité", key: "creativite" },
  { name: "Organisation", key: "organisation" },
  { name: "Leadership", key: "leadership" },
  { name: "Travail en équipe", key: "travail_equipe" },
  { name: "Analyse", key: "analyse" },
  { name: "Résolution de problèmes", key: "resolution_problemes" }
];

const Profile = () => {
  const { toast } = useToast();
  const { t } = useTranslation();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [avatarUrl, setAvatarUrl] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [form, setForm] = useState({
    nom: "",
    prenom: "",
    email: "",
    ville: "",
    budget_mensuel: undefined as number | undefined,
    serie_bac: "A1",
    annee_bac: new Date().getFullYear() + 1,
    mention: "Passable" as "Passable" | "Assez bien" | "Bien" | "Très bien",
    moyenne_generale: undefined as number | undefined,
    competences: {} as Record<string, number>,
    centres_interet: [] as string[],
    objectifs_professionnels: "",
    secteur_vise: "",
    budget_max_mensuel: undefined as number | undefined,
    distance_max_km: undefined as number | undefined,
    duree_max_etudes: undefined as number | undefined,
    preference_type_univ: "indifferent" as "publique" | "privee" | "indifferent",
    ville_preference: "",
  });

  useEffect(() => {
    const loadProfile = async () => {
      try {
        setLoading(true);
        const profilResponse = await usersApi.getProfil() as any;

        if (profilResponse) {
          setAvatarUrl(profilResponse?.avatar_url || null);
          setForm((prev) => ({
            ...prev,
            nom: profilResponse?.nom || "",
            prenom: profilResponse?.prenom || "",
            email: profilResponse?.email || "",
            ville: profilResponse?.ville || "",
            budget_mensuel: profilResponse?.budget_mensuel,
            serie_bac: profilResponse?.profil_academique?.serie_bac || "",
            annee_bac: profilResponse?.profil_academique?.annee_bac || new Date().getFullYear() + 1,
            mention: profilResponse?.profil_academique?.mention || "Passable",
            moyenne_generale: profilResponse?.profil_academique?.moyenne_generale,
            competences: profilResponse?.profil_academique?.competences || {},
            centres_interet: profilResponse?.profil_academique?.centres_interet || [],
            objectifs_professionnels: profilResponse?.profil_academique?.objectifs_professionnels || "",
            secteur_vise: profilResponse?.profil_academique?.secteur_vise || "",
            budget_max_mensuel: profilResponse?.profil_academique?.budget_max_mensuel,
            distance_max_km: profilResponse?.profil_academique?.distance_max_km,
            duree_max_etudes: profilResponse?.profil_academique?.duree_max_etudes,
            preference_type_univ: profilResponse?.profil_academique?.preference_type_univ || "indifferent",
            ville_preference: profilResponse?.profil_academique?.ville_preference || "",
          }));
        }
        setError(null);
      } catch (err) {
        const message = err instanceof Error ? err.message : t("profile.errorLoading");
        setError(message);
        toast({
          title: t("profile.errorLoadingTitle"),
          description: message,
          variant: "destructive",
        });
      } finally {
        setLoading(false);
      }
    };

    loadProfile();
  }, [toast]);

  const handleChange = (field: string, value: any) => {
    setForm((prev) => ({ ...prev, [field]: value }));
  };

  const handleSave = async () => {
    try {
      setSaving(true);

      await usersApi.updateProfil({
        nom: form.nom,
        prenom: form.prenom,
        ville: form.ville,
        budget_mensuel: form.budget_mensuel,
      });

      await usersApi.updateProfilAcademique({
        serie_bac: form.serie_bac,
        annee_bac: form.annee_bac,
        mention: form.mention,
        moyenne_generale: form.moyenne_generale,
        competences: form.competences,
        centres_interet: form.centres_interet,
        objectifs_professionnels: form.objectifs_professionnels,
        secteur_vise: form.secteur_vise,
        budget_max_mensuel: form.budget_max_mensuel,
        distance_max_km: form.distance_max_km,
        duree_max_etudes: form.duree_max_etudes,
        preference_type_univ: form.preference_type_univ,
        ville_preference: form.ville_preference,
      });

      toast({
        title: t("profile.saved"),
        description: t("profile.savedMessage"),
      });
    } catch (err) {
      const message = err instanceof Error ? err.message : t("profile.errorSavingMessage");
      toast({
        title: t("profile.errorSaving"),
        description: message,
        variant: "destructive",
      });
    } finally {
      setSaving(false);
    }
  };

  const handleAvatarChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    if (!file.type.startsWith("image/")) {
      toast({ title: t("profile.invalidFormat"), description: t("profile.invalidFormatMessage"), variant: "destructive" });
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      toast({ title: t("profile.fileTooLarge"), description: t("profile.fileTooLargeMessage"), variant: "destructive" });
      return;
    }
    try {
      const reader = new FileReader();
      reader.onload = async (event) => {
        const dataUrl = event.target?.result as string;
        setAvatarUrl(dataUrl);
        // Save avatar to backend
        await usersApi.updateAvatar(dataUrl);
        toast({ title: t("profile.photoUpdated") });
      };
      reader.readAsDataURL(file);
    } catch (err) {
      const message = err instanceof Error ? err.message : t("profile.errorSavingMessage");
      toast({
        title: t("profile.errorSaving"),
        description: message,
        variant: "destructive",
      });
    }
  };

  if (loading) {
    return (
      <DashboardLayout>
        <div className="flex items-center justify-center py-20">
          <div className="text-center">
            <Loader2 className="h-8 w-8 animate-spin mx-auto mb-3 text-primary" />
            <p className="text-muted-foreground">{t("profile.loadingProfile")}</p>
          </div>
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout>
      <div className="animate-fade-in h-full flex flex-col px-4 sm:px-6 lg:px-8 py-6 overflow-hidden">
        <div className="mb-6 shrink-0">
          <h1 className="text-3xl font-bold">{t("profile.title")}</h1>
          <p className="mt-1 text-muted-foreground">
            {t("profile.subtitle")}
          </p>
        </div>

        <div className="flex-1 overflow-y-auto pr-2 space-y-6">
          {error && (
            <div className="rounded-xl border border-destructive/50 bg-destructive/5 p-4 flex items-start gap-3 shrink-0">
              <AlertCircle className="h-5 w-5 text-destructive flex-shrink-0 mt-0.5" />
              <div>
                <p className="font-semibold text-destructive">{t("profile.error")}</p>
                <p className="text-sm text-destructive/80">{error}</p>
              </div>
            </div>
          )}

          {/* Avatar section */}
          <div className="rounded-xl border bg-card p-6 shadow-card">
            <div className="flex items-center gap-6">
              <div className="relative">
                <input
                  ref={fileInputRef}
                  type="file"
                  accept="image/*"
                  className="hidden"
                  onChange={handleAvatarChange}
                />
                {avatarUrl ? (
                  <img
                    src={avatarUrl}
                    alt={t("profile.uploadPhoto")}
                    className="h-20 w-20 rounded-full object-cover"
                  />
                ) : (
                  <div className="flex h-20 w-20 items-center justify-center rounded-full bg-accent text-2xl font-bold text-accent-foreground">
                    {form.prenom[0]}{form.nom[0]}
                  </div>
                )}
                <button
                  onClick={() => fileInputRef.current?.click()}
                  className="absolute -bottom-1 -right-1 flex h-8 w-8 items-center justify-center rounded-full bg-primary text-primary-foreground shadow-md hover:bg-primary/90 transition-colors"
                >
                  <Camera className="h-4 w-4" />
                </button>
              </div>
              <div>
                <h2 className="text-xl font-semibold">{form.prenom} {form.nom}</h2>
                <p className="text-sm text-muted-foreground">{form.email}</p>
                <div className="mt-1 flex items-center gap-2 text-xs text-muted-foreground">
                  <GraduationCap className="h-3.5 w-3.5" />
                  Bac {form.annee_bac} — {form.serie_bac}
                </div>
              </div>
            </div>
          </div>

          {/* Personal Information */}
          <div className="rounded-xl border bg-card p-6 shadow-card">
            <h3 className="mb-5 text-lg font-semibold flex items-center gap-2">
              <User className="h-5 w-5 text-primary" />
              {t("profile.personalInfo")}
            </h3>
            <div className="grid gap-5 sm:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="prenom">{t("profile.firstName")}</Label>
                <Input
                  id="prenom"
                  value={form.prenom}
                  onChange={(e) => handleChange("prenom", e.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="nom">{t("profile.lastName")}</Label>
                <Input
                  id="nom"
                  value={form.nom}
                  onChange={(e) => handleChange("nom", e.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="email">
                  <span className="flex items-center gap-1.5">
                    <Mail className="h-3.5 w-3.5" /> {t("profile.email")}
                  </span>
                </Label>
                <Input
                  id="email"
                  type="email"
                  value={form.email}
                  disabled
                  className="opacity-70"
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="ville">
                  <span className="flex items-center gap-1.5">
                    <MapPin className="h-3.5 w-3.5" /> {t("profile.city")}
                  </span>
                </Label>
                <Input
                  id="ville"
                  value={form.ville}
                  onChange={(e) => handleChange("ville", e.target.value)}
                />
              </div>
            </div>
          </div>

          {/* Academic Information */}
          <div className="rounded-xl border bg-card p-6 shadow-card">
            <h3 className="mb-5 text-lg font-semibold flex items-center gap-2">
              <GraduationCap className="h-5 w-5 text-primary" />
              {t("profile.academicProfile")}
            </h3>
            <div className="grid gap-5 sm:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="serie_bac">{t("profile.bacSeries")}</Label>
                <select
                  id="serie_bac"
                  value={form.serie_bac}
                  onChange={(e) => handleChange("serie_bac", e.target.value)}
                  className="w-full flex h-10 rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                >
                  {SERIES_BAC_OPTIONS.map((option) => (
                    <option key={option.value} value={option.value}>
                      {t(option.label)}
                    </option>
                  ))}
                </select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="annee_bac">{t("profile.bacYear")}</Label>
                <Input
                  id="annee_bac"
                  type="number"
                  value={form.annee_bac}
                  onChange={(e) => handleChange("annee_bac", parseInt(e.target.value))}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="mention">{t("profile.mention")}</Label>
                <select
                  id="mention"
                  value={form.mention}
                  onChange={(e) => handleChange("mention", e.target.value as any)}
                  className="w-full flex h-10 rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                >
                  <option value="Passable">{t("profile.mentionPassable")}</option>
                  <option value="Assez bien">{t("profile.mentionGood")}</option>
                  <option value="Bien">{t("profile.mentionVeryGood")}</option>
                  <option value="Très bien">{t("profile.mentionExcellent")}</option>
                </select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="moyenne_generale">{t("profile.averageScore")}</Label>
                <Input
                  id="moyenne_generale"
                  type="number"
                  min="0"
                  max="20"
                  step="0.1"
                  value={form.moyenne_generale || ""}
                  onChange={(e) => handleChange("moyenne_generale", e.target.value ? parseFloat(e.target.value) : undefined)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="objectifs_professionnels">{t("profile.professionalGoals")}</Label>
                <Input
                  id="objectifs_professionnels"
                  value={form.objectifs_professionnels}
                  onChange={(e) => handleChange("objectifs_professionnels", e.target.value)}
                  placeholder={t("profile.goalsPlaceholder")}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="secteur_vise">{t("profile.targetSector")}</Label>
                <Input
                  id="secteur_vise"
                  value={form.secteur_vise}
                  onChange={(e) => handleChange("secteur_vise", e.target.value)}
                  placeholder={t("profile.sectorPlaceholder")}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="preference_type_univ">{t("profile.universityType")}</Label>
                <select
                  id="preference_type_univ"
                  value={form.preference_type_univ}
                  onChange={(e) => handleChange("preference_type_univ", e.target.value as any)}
                  className="w-full flex h-10 rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                >
                  <option value="indifferent">{t("profile.typeIndifferent")}</option>
                  <option value="publique">{t("profile.typePublic")}</option>
                  <option value="privee">{t("profile.typePrivate")}</option>
                </select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="ville_preference">{t("profile.preferredCity")}</Label>
                <Input
                  id="ville_preference"
                  value={form.ville_preference}
                  onChange={(e) => handleChange("ville_preference", e.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="distance_max_km">{t("profile.maxDistance")}</Label>
                <Input
                  id="distance_max_km"
                  type="number"
                  value={form.distance_max_km || ""}
                  onChange={(e) => handleChange("distance_max_km", e.target.value ? parseFloat(e.target.value) : undefined)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="duree_max_etudes">{t("profile.maxDuration")}</Label>
                <Input
                  id="duree_max_etudes"
                  type="number"
                  value={form.duree_max_etudes || ""}
                  onChange={(e) => handleChange("duree_max_etudes", e.target.value ? parseFloat(e.target.value) : undefined)}
                />
              </div>
            </div>
          </div>

          {/* Interests Section */}
          <div className="rounded-xl border bg-card p-6 shadow-card">
            <h3 className="mb-5 text-lg font-semibold flex items-center gap-2">
              <Target className="h-5 w-5 text-primary" />
              Centres d'Intérêt
            </h3>
            <p className="text-sm text-muted-foreground mb-4">
              Sélectionnez vos domaines d'intérêt pour améliorer la qualité de vos recommandations
            </p>
            <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4">
              {CENTRES_INTERET_OPTIONS.map((interet) => (
                <div key={interet} className="flex items-center space-x-2">
                  <Checkbox
                    id={`interet_${interet}`}
                    checked={form.centres_interet.includes(interet)}
                    onCheckedChange={(checked) => {
                      if (checked) {
                        handleChange("centres_interet", [...form.centres_interet, interet]);
                      } else {
                        handleChange("centres_interet", form.centres_interet.filter(i => i !== interet));
                      }
                    }}
                  />
                  <Label htmlFor={`interet_${interet}`} className="text-sm font-medium cursor-pointer">
                    {interet}
                  </Label>
                </div>
              ))}
            </div>
            {form.centres_interet.length === 0 && (
              <div className="mt-4 p-3 rounded-md bg-accent/50 text-sm text-muted-foreground">
                💡 Conseil : Sélectionner au moins 2-3 domaines d'intérêt pour des recommandations plus pertinentes
              </div>
            )}
          </div>

          {/* Competences Section */}
          <div className="rounded-xl border bg-card p-6 shadow-card">
            <h3 className="mb-5 text-lg font-semibold flex items-center gap-2">
              <Sparkles className="h-5 w-5 text-primary" />
              Vos Compétences
            </h3>
            <p className="text-sm text-muted-foreground mb-6">
              Évaluez votre niveau pour chaque compétence (1 = Faible, 5 = Excellent)
            </p>
            <div className="space-y-6">
              {COMPETENCES_OPTIONS.map((comp) => (
                <div key={comp.key} className="space-y-2">
                  <div className="flex items-center justify-between">
                    <Label htmlFor={`competence_${comp.key}`} className="text-sm font-medium">
                      {comp.name}
                    </Label>
                    <span className="text-xs bg-primary/10 text-primary px-2 py-1 rounded-full font-semibold">
                      {form.competences[comp.key] || 0}/5
                    </span>
                  </div>
                  <Slider
                    id={`competence_${comp.key}`}
                    min={0}
                    max={5}
                    step={1}
                    value={[form.competences[comp.key] || 0]}
                    onValueChange={(value) => {
                      handleChange("competences", {
                        ...form.competences,
                        [comp.key]: value[0]
                      });
                    }}
                    className="w-full"
                  />
                  <div className="flex gap-1">
                    {[...Array(5)].map((_, i) => (
                      <div
                        key={i}
                        className={`h-2 w-full rounded-full ${
                          i < (form.competences[comp.key] || 0)
                            ? "bg-primary"
                            : "bg-muted"
                        }`}
                      />
                    ))}
                  </div>
                </div>
              ))}
            </div>
            {Object.keys(form.competences).length === 0 && (
              <div className="mt-6 p-3 rounded-md bg-accent/50 text-sm text-muted-foreground">
                Conseil : Remplir vos compétences aide le modèle IA à mieux vous recommander des filières adaptées
              </div>
            )}
          </div>
        </div>

        <div className="flex justify-end gap-3 mt-6 shrink-0 pt-6 border-t">
          <Button variant="outline" size="lg" disabled={saving}>
            {t("common.cancel")}
          </Button>
          <Button
            variant="hero"
            size="lg"
            onClick={handleSave}
            disabled={saving}
          >
            {saving ? (
              <>
                <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                {t("profile.saving")}
              </>
            ) : (
              <>
                <Save className="h-4 w-4 mr-2" />
                {t("profile.saveChanges")}
              </>
            )}
          </Button>
        </div>
      </div>
    </DashboardLayout>
  );
};

export default Profile;
