import AdminLayout from "@/components/AdminLayout";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
import {
  Settings,
  Plus,
  MoreHorizontal,
  Pencil,
  Trash2,
  Eye,
  Check,
  AlertCircle,
  Save,
  X,
} from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
  DialogDescription,
} from "@/components/ui/dialog";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { Slider } from "@/components/ui/slider";
import { Switch } from "@/components/ui/switch";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Separator } from "@/components/ui/separator";
import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { admin } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";

const AdminRules = () => {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [rules, setRules] = useState<any[]>([]);
  const [activeRule, setActiveRule] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingRule, setEditingRule] = useState<any | null>(null);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [deletingId, setDeletingId] = useState<number | null>(null);
  const [weightError, setWeightError] = useState<string | null>(null);

  // Form state
  const [formName, setFormName] = useState("");
  const [formDesc, setFormDesc] = useState("");
  const [formMethode, setFormMethode] = useState<"pondere" | "knn" | "decision_tree" | "hybrid">("pondere");
  const [formMoyenneMin, setFormMoyenneMin] = useState(10);
  const [formTopN, setFormTopN] = useState(10);
  const [formFiltreSerieElim, setFormFiltreSerieElim] = useState(true);
  const [formFiltreBudgetElim, setFormFiltreBudgetElim] = useState(false);

  const [weights, setWeights] = useState({
    serie: 25,
    moyenne: 20,
    interet: 20,
    competences: 15,
    budget: 10,
    duree: 5,
    test: 5,
  });

  useEffect(() => {
    fetchRules();
  }, []);

  const fetchRules = async () => {
    try {
      setLoading(true);
      const response = await admin.getRules() as any;

      // Normalize response structure
      let rulesData = [];
      if (Array.isArray(response)) {
        rulesData = response;
      } else if (response?.data?.rules && Array.isArray(response.data.rules)) {
        rulesData = response.data.rules;
      } else if (response?.rules && Array.isArray(response.rules)) {
        rulesData = response.rules;
      }

      setRules(rulesData);

      // Try to find active rule
      const activeRuleData = response?.data?.active || response?.active || rulesData.find((r: any) => r.est_default);
      setActiveRule(activeRuleData);
    } catch (error) {
      toast({
        title: "Erreur",
        description: error instanceof Error ? error.message : "Impossible de charger les règles",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const calculateTotal = (w: typeof weights) => {
    return Object.values(w).reduce((a, b) => a + b, 0);
  };

  const validateWeights = (w: typeof weights) => {
    const total = calculateTotal(w);
    if (total !== 100) {
      setWeightError(`Les poids doivent totaliser 100 (actuellement: ${total})`);
      return false;
    }
    setWeightError(null);
    return true;
  };

  const handleWeightChange = (key: string, value: number) => {
    const newWeights = { ...weights, [key]: value };
    setWeights(newWeights);
    validateWeights(newWeights);
  };

  const openAddDialog = () => {
    setEditingRule(null);
    setFormName("");
    setFormDesc("");
    setFormMethode("pondere");
    setFormMoyenneMin(10);
    setFormTopN(10);
    setFormFiltreSerieElim(true);
    setFormFiltreBudgetElim(false);
    setWeights({ serie: 25, moyenne: 20, interet: 20, competences: 15, budget: 10, duree: 5, test: 5 });
    setWeightError(null);
    setDialogOpen(true);
  };

  const openEditDialog = (rule: any) => {
    setEditingRule(rule);
    setFormName(rule.nom || "");
    setFormDesc(rule.description || "");
    setFormMethode((rule.methode_scoring || "pondere") as "pondere" | "knn" | "decision_tree" | "hybrid");
    setFormMoyenneMin(rule.moyenne_min_acceptable || 10);
    setFormTopN(rule.top_n_recommendations || 10);
    setFormFiltreSerieElim(rule.filtre_eliminer_hors_serie !== false);
    setFormFiltreBudgetElim(rule.filtre_eliminer_hors_budget === true);
    setWeights({
      serie: rule.poids_serie || 25,
      moyenne: rule.poids_moyenne || 20,
      interet: rule.poids_interet || 20,
      competences: rule.poids_competences || 15,
      budget: rule.poids_budget || 10,
      duree: rule.poids_duree || 5,
      test: rule.poids_test || 5,
    });
    setWeightError(null);
    setDialogOpen(true);
  };

  const handleSave = async () => {
    if (!validateWeights(weights)) return;

    try {
      if (editingRule) {
        const response = await admin.updateRule(editingRule.id, {
          nom: formName,
          description: formDesc,
          poids_serie: weights.serie,
          poids_moyenne: weights.moyenne,
          poids_interet: weights.interet,
          poids_competences: weights.competences,
          poids_budget: weights.budget,
          poids_duree: weights.duree,
          poids_test: weights.test,
          moyenne_min_acceptable: formMoyenneMin,
          filtre_eliminer_hors_serie: formFiltreSerieElim,
          filtre_eliminer_hors_budget: formFiltreBudgetElim,
          top_n_recommendations: formTopN,
          methode_scoring: formMethode,
        }) as any;

        const updatedRule = response?.data?.rule || { ...editingRule, nom: formName };
        setRules(rules.map((r) => (r.id === editingRule.id ? updatedRule : r)));
        toast({ title: "Règle modifiée", description: `${formName} a été mise à jour.` });
      } else {
        const response = await admin.createRule({
          nom: formName,
          description: formDesc,
          poids_serie: weights.serie,
          poids_moyenne: weights.moyenne,
          poids_interet: weights.interet,
          poids_competences: weights.competences,
          poids_budget: weights.budget,
          poids_duree: weights.duree,
          poids_test: weights.test,
          moyenne_min_acceptable: formMoyenneMin,
          filtre_eliminer_hors_serie: formFiltreSerieElim,
          filtre_eliminer_hors_budget: formFiltreBudgetElim,
          top_n_recommendations: formTopN,
          methode_scoring: formMethode,
        }) as any;

        const newRule = response?.data?.rule || { id: Date.now(), nom: formName };
        setRules([...rules, newRule]);
        toast({ title: "Règle créée", description: `${formName} a été ajoutée avec succès.` });
      }
      setDialogOpen(false);
    } catch (error) {
      toast({
        title: "Erreur",
        description: "Impossible de sauvegarder la règle",
        variant: "destructive",
      });
      console.error("Error saving rule:", error);
    }
  };

  const handleActivate = async (ruleId: number) => {
    try {
      const response = await admin.activateRule(ruleId) as any;
      const updatedRule = response?.data?.rule;
      setActiveRule(updatedRule);
      setRules(
        rules.map((r) => ({
          ...r,
          est_default: r.id === ruleId,
        }))
      );
      toast({ title: "Succès", description: "Règle activée comme défaut." });
    } catch (error) {
      toast({
        title: "Erreur",
        description: "Impossible d'activer la règle",
        variant: "destructive",
      });
      console.error("Error activating rule:", error);
    }
  };

  const handleDelete = async () => {
    if (deletingId === null) return;
    try {
      await admin.deleteRule(deletingId);
      setRules(rules.filter((r) => r.id !== deletingId));
      toast({ title: "Règle supprimée", variant: "destructive" });
    } catch (error) {
      toast({
        title: "Erreur",
        description: error instanceof Error ? error.message : "Impossible de supprimer la règle",
        variant: "destructive",
      });
      console.error("Error deleting rule:", error);
    } finally {
      setDeleteDialogOpen(false);
      setDeletingId(null);
    }
  };

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-screen">
          <p className="text-muted-foreground">Chargement des règles...</p>
        </div>
      </AdminLayout>
    );
  }

  const total = calculateTotal(weights);

  return (
    <AdminLayout>
      <div className="animate-fade-in">
        <div className="mb-8 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div>
            <h1 className="text-3xl font-bold">Définir les règles de recommandation</h1>
            <p className="mt-1 text-muted-foreground">
              Configurez les poids et filtres du système de recommandation IA
            </p>
          </div>
          <Button size="sm" onClick={openAddDialog}>
            <Plus className="h-4 w-4 mr-1" /> Nouvelle règle
          </Button>
        </div>

        {/* Règle active */}
        {activeRule && (
          <div className="mb-8 rounded-xl border-2 border-primary/50 bg-primary/5 p-6 shadow-sm">
            <div className="flex items-center gap-3 mb-4">
              <Check className="h-5 w-5 text-primary" />
              <h2 className="text-lg font-semibold">Règle active</h2>
              <Badge className="bg-primary">{activeRule.nom}</Badge>
            </div>
            <p className="text-sm text-muted-foreground mb-4">
              {activeRule.description || "Aucune description"}
            </p>
            <div className="grid gap-3 sm:grid-cols-4 text-sm">
              <div>
                <p className="font-medium">Méthode</p>
                <p className="text-muted-foreground">{activeRule.methode_scoring}</p>
              </div>
              <div>
                <p className="font-medium">Top N</p>
                <p className="text-muted-foreground">{activeRule.top_n_recommendations}</p>
              </div>
              <div>
                <p className="font-medium">Moyenne min</p>
                <p className="text-muted-foreground">{activeRule.moyenne_min_acceptable}/20</p>
              </div>
              <div>
                <p className="font-medium">Version</p>
                <p className="text-muted-foreground">{activeRule.version || "1.0"}</p>
              </div>
            </div>
          </div>
        )}

        {/* Liste des règles */}
        <div className="space-y-4">
          <h3 className="text-lg font-semibold">Toutes les règles ({rules.length})</h3>
          {rules.length === 0 ? (
            <div className="p-12 text-center text-muted-foreground rounded-xl border bg-card">
              <Settings className="h-10 w-10 mx-auto mb-2 opacity-40" />
              <p>Aucune règle configurée. Créez-en une pour commencer.</p>
            </div>
          ) : (
            rules.map((rule) => (
              <div
                key={rule.id}
                className={`rounded-xl border bg-card shadow-sm overflow-hidden transition-colors ${
                  rule.est_default ? "border-primary/50" : ""
                }`}
              >
                <div className="p-5">
                  <div className="flex items-start justify-between gap-4 mb-3">
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-1">
                        <h3 className="font-semibold">{rule.nom}</h3>
                        {rule.est_default && <Badge className="bg-primary/80 text-xs">Défaut</Badge>}
                        {!rule.actif && <Badge variant="outline" className="text-xs">Inactif</Badge>}
                      </div>
                      <p className="text-xs text-muted-foreground mb-2">
                        {rule.description || "Aucune description"}
                      </p>
                      <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-xs text-muted-foreground">
                        <span>Méthode: {rule.methode_scoring}</span>
                        <span>Top {rule.top_n_recommendations}</span>
                        <span>v{rule.version || "1.0"}</span>
                      </div>
                    </div>

                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon" className="h-8 w-8">
                          <MoreHorizontal className="h-4 w-4" />
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        {!rule.est_default && (
                          <DropdownMenuItem onClick={() => handleActivate(rule.id)}>
                            <Check className="h-4 w-4 mr-2" /> Activer
                          </DropdownMenuItem>
                        )}
                        <DropdownMenuItem onClick={() => openEditDialog(rule)}>
                          <Pencil className="h-4 w-4 mr-2" /> {t("admin.pages.rules.editAction")}
                        </DropdownMenuItem>
                        {!rule.est_default && (
                          <DropdownMenuItem
                            className="text-destructive"
                            onClick={() => { setDeletingId(rule.id); setDeleteDialogOpen(true); }}
                          >
                            <Trash2 className="h-4 w-4 mr-2" /> {t("admin.pages.rules.deleteAction")}
                          </DropdownMenuItem>
                        )}
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </div>

                  {/* Poids affichés */}
                  <div className="bg-muted/30 rounded-lg p-3">
                    <p className="text-xs font-medium mb-2 text-muted-foreground">RÉPARTITION DES POIDS</p>
                    <div className="grid gap-2 grid-cols-2 sm:grid-cols-4 text-xs">
                      <div>
                        <div className="font-medium">{rule.poids_serie}%</div>
                        <div className="text-muted-foreground">Série Bac</div>
                      </div>
                      <div>
                        <div className="font-medium">{rule.poids_moyenne}%</div>
                        <div className="text-muted-foreground">Moyenne</div>
                      </div>
                      <div>
                        <div className="font-medium">{rule.poids_interet}%</div>
                        <div className="text-muted-foreground">Intérêts</div>
                      </div>
                      <div>
                        <div className="font-medium">{rule.poids_competences}%</div>
                        <div className="text-muted-foreground">Compétences</div>
                      </div>
                      <div>
                        <div className="font-medium">{rule.poids_budget}%</div>
                        <div className="text-muted-foreground">Budget</div>
                      </div>
                      <div>
                        <div className="font-medium">{rule.poids_duree}%</div>
                        <div className="text-muted-foreground">Durée</div>
                      </div>
                      <div>
                        <div className="font-medium">{rule.poids_test}%</div>
                        <div className="text-muted-foreground">Test</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            ))
          )}
        </div>

        {/* Dialog Add/Edit */}
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogContent className="max-w-3xl max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle>{editingRule ? "Modifier la règle" : "Créer une nouvelle règle"}</DialogTitle>
              <DialogDescription>
                Configurez les poids et les filtres pour le système de recommandation
              </DialogDescription>
            </DialogHeader>

            <div className="space-y-6 py-4">
              {/* Infos générales */}
              <div className="space-y-4">
                <h3 className="text-sm font-semibold">Informations générales</h3>
                <div className="grid gap-4 sm:grid-cols-2">
                  <div className="space-y-1.5">
                    <Label>Nom de la règle</Label>
                    <Input
                      value={formName}
                      onChange={(e) => setFormName(e.target.value)}
                      placeholder="ex: Règles standard"
                    />
                  </div>
                  <div className="space-y-1.5">
                    <Label>Méthode de scoring</Label>
                    <Select value={formMethode} onValueChange={(value) => setFormMethode(value as "pondere" | "knn" | "decision_tree" | "hybrid")}>
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="pondere">Pondéré</SelectItem>
                        <SelectItem value="knn">KNN</SelectItem>
                        <SelectItem value="decision_tree">Arbre de décision</SelectItem>
                        <SelectItem value="hybrid">Hybride</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
                <div className="space-y-1.5">
                  <Label>Description</Label>
                  <Textarea
                    value={formDesc}
                    onChange={(e) => setFormDesc(e.target.value)}
                    placeholder="Décrivez l'objectif de cette configuration..."
                    rows={2}
                  />
                </div>
              </div>

              <Separator />

              {/* Poids */}
              <div className="space-y-4">
                <div className="flex items-center justify-between">
                  <h3 className="text-sm font-semibold">Répartition des poids</h3>
                  <span
                    className={`text-sm font-medium ${
                      total === 100 ? "text-green-600" : "text-red-600"
                    }`}
                  >
                    Total: {total}%
                  </span>
                </div>

                {weightError && (
                  <Alert variant="destructive">
                    <AlertCircle className="h-4 w-4" />
                    <AlertDescription>{weightError}</AlertDescription>
                  </Alert>
                )}

                <div className="space-y-5">
                  {[
                    { key: "serie", label: "Série du Baccalauréat", icon: "🎓" },
                    { key: "moyenne", label: "Moyenne générale", icon: "📊" },
                    { key: "interet", label: "Centres d'intérêt", icon: "💡" },
                    { key: "competences", label: "Compétences", icon: "🎯" },
                    { key: "budget", label: "Contraintes budgétaires", icon: "💰" },
                    { key: "duree", label: "Durée des études", icon: "⏱️" },
                    { key: "test", label: "Scores du test", icon: "📝" },
                  ].map((item) => (
                    <div key={item.key}>
                      <div className="flex items-center justify-between mb-2">
                        <label className="text-sm font-medium">
                          {item.icon} {item.label}
                        </label>
                        <span className="text-sm font-semibold text-primary">
                          {weights[item.key as keyof typeof weights]}%
                        </span>
                      </div>
                      <Slider
                        value={[weights[item.key as keyof typeof weights]]}
                        onValueChange={(val) =>
                          handleWeightChange(item.key, val[0])
                        }
                        min={0}
                        max={100}
                        step={1}
                        className="w-full"
                      />
                    </div>
                  ))}
                </div>
              </div>

              <Separator />

              {/* Filtres et paramètres */}
              <div className="space-y-4">
                <h3 className="text-sm font-semibold">Filtres et paramètres</h3>

                <div className="grid gap-4 sm:grid-cols-2">
                  <div className="space-y-1.5">
                    <Label>Nombre de recommandations (top N)</Label>
                    <Input
                      type="number"
                      value={formTopN}
                      onChange={(e) => setFormTopN(parseInt(e.target.value))}
                      min="1"
                      max="50"
                    />
                  </div>
                  <div className="space-y-1.5">
                    <Label>Moyenne minimale acceptable</Label>
                    <Input
                      type="number"
                      value={formMoyenneMin}
                      onChange={(e) => setFormMoyenneMin(parseFloat(e.target.value))}
                      min="0"
                      max="20"
                      step="0.5"
                      placeholder="ex: 10"
                    />
                  </div>
                </div>

                <div className="space-y-3">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm font-medium">Éliminer si série non acceptée</p>
                      <p className="text-xs text-muted-foreground">
                        Rejette les filières non adaptées à la série du bac
                      </p>
                    </div>
                    <Switch
                      checked={formFiltreSerieElim}
                      onCheckedChange={setFormFiltreSerieElim}
                    />
                  </div>
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm font-medium">Éliminer si budget insuffisant</p>
                      <p className="text-xs text-muted-foreground">
                        Rejette les filières trop coûteuses par rapport au budget
                      </p>
                    </div>
                    <Switch
                      checked={formFiltreBudgetElim}
                      onCheckedChange={setFormFiltreBudgetElim}
                    />
                  </div>
                </div>
              </div>
            </div>

            <DialogFooter>
              <Button
                variant="outline"
                onClick={() => setDialogOpen(false)}
              >
                <X className="h-4 w-4 mr-2" /> Annuler
              </Button>
              <Button onClick={handleSave} disabled={!formName.trim() || !!weightError}>
                <Save className="h-4 w-4 mr-2" />
                {editingRule ? "Enregistrer" : "Créer"}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Delete Confirmation Dialog */}
        <AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>Supprimer la règle</AlertDialogTitle>
              <AlertDialogDescription>
                Êtes-vous sûr de vouloir supprimer cette règle ? Cette action est irréversible.
              </AlertDialogDescription>
            </AlertDialogHeader>
            <div className="flex gap-3 justify-end">
              <AlertDialogCancel>Annuler</AlertDialogCancel>
              <AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
                Supprimer
              </AlertDialogAction>
            </div>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </AdminLayout>
  );
};

export default AdminRules;
