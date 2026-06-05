import AdminLayout from "@/components/AdminLayout";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  BookOpen,
  Search,
  Plus,
  MoreHorizontal,
  Eye,
  Pencil,
  Trash2,
  Building2,
  ChevronDown,
  ChevronRight,
  Layers,
} from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
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
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { filieres, universities } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import { downloadCSV } from "@/lib/export";
import type { Filiere, University, Parcours } from "@/types";

const AdminFilieres = () => {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [search, setSearch] = useState("");
  const [niveauFilter, setNiveauFilter] = useState("all");
  const [univFilter, setUnivFilter] = useState("all");
  const [filiereList, setFiliereList] = useState<Filiere[]>([]);
  const [univerList, setUniversList] = useState<University[]>([]);
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingFiliere, setEditingFiliere] = useState<Filiere | null>(null);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [deletingId, setDeletingId] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);

  // Form state
  const [formUniversiteId, setFormUniversiteId] = useState("");
  const [formNom, setFormNom] = useState("");
  const [formDomaine, setFormDomaine] = useState("");
  const [formNiveaux, setFormNiveaux] = useState<string[]>(["Licence"]);
  const [formDifficulte, setFormDifficulte] = useState("moyen");
  const [formDescription, setFormDescription] = useState("");
  const [formDuree, setFormDuree] = useState("");
  const [formCout, setFormCout] = useState("");
  const [formCoutDescription, setFormCoutDescription] = useState("");
  const [formParcours, setFormParcours] = useState<Array<{ nom: string; specialisation?: string; duree_mois?: number; description?: string }>>([]);
  const [newParcoursNom, setNewParcoursNom] = useState("");
  const [newParcoursSpec, setNewParcoursSpec] = useState("");
  const [newParcoursDuree, setNewParcoursDuree] = useState("");
  const [newParcoursDesc, setNewParcoursDesc] = useState("");
  const [showParcoursForm, setShowParcoursForm] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const [filiereRes, univRes] = await Promise.all([
          filieres.getAll(),
          universities.getAll(),
        ]);

        let filList: Filiere[] = [];
        const filiereResAny = filiereRes as unknown;
        if (Array.isArray(filiereResAny)) {
          filList = filiereResAny;
        } else if (typeof filiereResAny === 'object' && filiereResAny !== null && 'filieres' in filiereResAny && Array.isArray((filiereResAny as any).filieres)) {
          filList = (filiereResAny as any).filieres;
        } else if (typeof filiereResAny === 'object' && filiereResAny !== null && 'data' in filiereResAny && Array.isArray((filiereResAny as any).data)) {
          filList = (filiereResAny as any).data;
        }

        let univs: University[] = [];
        const univResAny = univRes as unknown;
        if (Array.isArray(univResAny)) {
          univs = univResAny;
        } else if (typeof univResAny === 'object' && univResAny !== null && 'universites' in univResAny && Array.isArray((univResAny as any).universites)) {
          univs = (univResAny as any).universites;
        } else if (typeof univResAny === 'object' && univResAny !== null && 'data' in univResAny && Array.isArray((univResAny as any).data)) {
          univs = (univResAny as any).data;
        }

        setFiliereList(filList);
        setUniversList(univs);
      } catch (error) {
        toast({
          title: t("common.error"),
          description: error instanceof Error ? error.message : t("admin.pages.filieres.loadingError"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [toast]);

  const niveaux = ["Licence", "Master", "Doctorat", "DTS", "DUT", "Ingénieur"];
  const difficultes = ["facile", "moyen", "difficile", "tres_difficile"];
  const domaines = Array.from(new Set(filiereList.map((f) => f.domaine).filter(Boolean))) as string[];

  const filtered = filiereList.filter((f) => {
    const nomMatch = (f.nom || '').toLowerCase().includes(search.toLowerCase());
    const niveauMatch = niveauFilter === "all" || (f.niveaux && f.niveaux.includes(niveauFilter));
    const univMatch = univFilter === "all" || String(f.universite_id) === univFilter;
    return nomMatch && niveauMatch && univMatch;
  });

  const handleExportCSV = () => {
    const data = filiereList.map(f => {
      const uni = univerList.find(u => u.id === f.universite_id);
      return {
        ID: f.id,
        Nom: f.nom,
        Domaine: f.domaine || '',
        Niveaux: f.niveaux?.join(', ') || 'Licence',
        Université: uni?.nom || 'N/A',
        Durée: f.duree_annees || '',
        Difficulté: f.difficulte || 'moyen',
        'Taux Emploi': f.taux_emploi ? `${f.taux_emploi}%` : '',
      } as Record<string, unknown>;
    });
    downloadCSV(data, `filieres-${new Date().toLocaleDateString('fr-FR')}.csv`);
    toast({ title: t("common.success"), description: `${filiereList.length} ${t("admin.pages.filieres.noResults").toLowerCase()}` });
  };

  const openAddDialog = () => {
    setEditingFiliere(null);
    setFormUniversiteId("");
    setFormNom("");
    setFormDomaine("");
    setFormNiveaux(["Licence"]);
    setFormDifficulte("moyen");
    setFormDescription("");
    setFormDuree("");
    setFormCout("");
    setFormCoutDescription("");
    setFormParcours([]);
    setNewParcoursNom("");
    setNewParcoursSpec("");
    setNewParcoursDuree("");
    setNewParcoursDesc("");
    setShowParcoursForm(false);
    setDialogOpen(true);
  };

  const openEditDialog = (fil: Filiere) => {
    setEditingFiliere(fil);
    setFormUniversiteId(String(fil.universite_id));
    setFormNom(fil.nom || "");
    setFormDomaine(fil.domaine || "");
    setFormNiveaux(fil.niveaux || ["Licence"]);
    setFormDifficulte(fil.difficulte || "moyen");
    setFormDescription(fil.description || "");
    setFormDuree(fil.duree_annees ? String(fil.duree_annees) : "");
    setFormCout(fil.cout_annuel ? String(fil.cout_annuel) : "");
    setFormCoutDescription(fil.cout_description || "");
    setFormParcours(fil.parcours ? fil.parcours.map(p => ({ nom: p.nom, specialisation: p.specialisation, duree_mois: p.duree_mois, description: p.description })) : []);
    setNewParcoursNom("");
    setNewParcoursSpec("");
    setNewParcoursDuree("");
    setNewParcoursDesc("");
    setShowParcoursForm(false);
    setDialogOpen(true);
  };

  const handleSave = async () => {
    try {
      if (!formUniversiteId || !formNom || formNiveaux.length === 0) {
        toast({
          title: "Erreur",
          description: "Veuillez remplir tous les champs obligatoires",
          variant: "destructive"
        });
        return;
      }

      const data = {
        universite_id: parseInt(formUniversiteId),
        nom: formNom.trim(),
        domaine: formDomaine.trim(),
        niveaux: formNiveaux,
        difficulte: formDifficulte,
        ...(formDescription && { description: formDescription }),
        ...(formDuree && { duree_annees: formDuree.trim() }),
        ...(formCout && { cout_annuel: parseFloat(formCout) }),
        ...(formCoutDescription && { cout_description: formCoutDescription.trim() }),
        ...(formParcours.length > 0 && { parcours: formParcours }),
      };

      if (editingFiliere) {
        const updateData = {
          universite_id: data.universite_id,
          nom: data.nom,
          domaine: data.domaine,
          niveaux: data.niveaux,
          difficulte: data.difficulte as "facile" | "moyen" | "difficile" | "tres_difficile",
          ...(data.description && { description: data.description }),
          ...(data.duree_annees && { duree_annees: data.duree_annees }),
          ...(data.cout_annuel && { cout_annuel: data.cout_annuel }),
          ...(data.cout_description && { cout_description: data.cout_description }),
          ...(data.parcours && { parcours: data.parcours }),
        };
        await filieres.update(editingFiliere.id, updateData);
        const updatedFiliere: Filiere = { ...editingFiliere, ...updateData };
        setFiliereList(filiereList.map((f) => (f.id === editingFiliere.id ? updatedFiliere : f)));
        toast({ title: "Filière modifiée", description: `${formNom} a été mise à jour.` });
      } else {
        const createData = {
          ...data,
          difficulte: data.difficulte as "facile" | "moyen" | "difficile" | "tres_difficile"
        };
        const response = await filieres.create(createData);
        const newFiliere: Filiere = (typeof response === 'object' && response !== null && 'filiere' in response)
          ? (response as any).filiere
          : { id: Date.now(), ...createData, actif: true, parcours: formParcours };
        setFiliereList([...filiereList, newFiliere]);
        toast({ title: "Filière ajoutée", description: `${formNom} a été ajoutée avec succès.` });
      }
      setDialogOpen(false);
    } catch (error) {
      toast({
        title: "Erreur",
        description: error instanceof Error ? error.message : "Impossible de sauvegarder la filière",
        variant: "destructive"
      });
    }
  };

  const handleDelete = async () => {
    if (deletingId === null) return;
    try {
      await filieres.delete(deletingId);
      const deletedFil = filiereList.find((f) => f.id === deletingId);
      setFiliereList(filiereList.filter((f) => f.id !== deletingId));
      toast({
        title: t("admin.pages.filieres.deleteFiliere"),
        description: deletedFil ? `${deletedFil.nom} ${t("admin.pages.filieres.deletedMsg")}.` : t("admin.pages.filieres.deleteSuccess"),
        variant: "destructive"
      });
    } catch (error) {
      toast({
        title: t("common.error"),
        description: error instanceof Error ? error.message : t("admin.pages.filieres.deletingError"),
        variant: "destructive"
      });
    } finally {
      setDeleteDialogOpen(false);
      setDeletingId(null);
    }
  };

  const handleAddParcours = () => {
    if (!newParcoursNom.trim()) {
      toast({ title: "Erreur", description: "Veuillez entrer un nom de parcours", variant: "destructive" });
      return;
    }
    setFormParcours([...formParcours, {
      nom: newParcoursNom.trim(),
      specialisation: newParcoursSpec.trim() || undefined,
      duree_mois: newParcoursDuree ? parseInt(newParcoursDuree) : undefined,
      description: newParcoursDesc.trim() || undefined
    }]);
    setNewParcoursNom("");
    setNewParcoursSpec("");
    setNewParcoursDuree("");
    setNewParcoursDesc("");
  };

  const handleRemoveParcours = (index: number) => {
    setFormParcours(formParcours.filter((_, i) => i !== index));
  };

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-screen">
          <p className="text-muted-foreground">Chargement des filières...</p>
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout>
      <div className="animate-fade-in">
        <div className="mb-8 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div>
            <h1 className="text-3xl font-bold">{t("admin.pages.filieres.title")}</h1>
            <p className="mt-1 text-muted-foreground">{filiereList.length} {t("admin.pages.filieres.noResults").toLowerCase()}</p>
          </div>
          <div className="flex gap-2">
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button size="sm" variant="outline">
                  <Plus className="h-4 w-4 mr-1" /> {t("common.filter")}
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end">
                <DropdownMenuItem onClick={handleExportCSV}>
                  {t("admin.pages.filieres.exportCSV")}
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
            <Button size="sm" onClick={openAddDialog}>
              <Plus className="h-4 w-4 mr-1" /> {t("admin.pages.filieres.addNew")}
            </Button>
          </div>
        </div>

        <div className="mb-6 flex flex-col sm:flex-row gap-3">
          <div className="relative flex-1 max-w-md">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
            <Input placeholder={t("admin.pages.filieres.searchPlaceholder")} value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
          </div>
          <Select value={niveauFilter} onValueChange={setNiveauFilter}>
            <SelectTrigger className="w-full sm:w-[180px]">
              <SelectValue placeholder={t("admin.pages.filieres.niveau")} />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("admin.pages.filieres.all")}</SelectItem>
              {niveaux.map((n) => <SelectItem key={n} value={n}>{n}</SelectItem>)}
            </SelectContent>
          </Select>
          <Select value={univFilter} onValueChange={setUnivFilter}>
            <SelectTrigger className="w-full sm:w-[180px]">
              <SelectValue placeholder={t("admin.pages.filieres.filterByUniversity")} />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("admin.pages.filieres.all")}</SelectItem>
              {univerList.map((u) => <SelectItem key={u.id} value={String(u.id)}>{u.nom}</SelectItem>)}
            </SelectContent>
          </Select>
        </div>

        <div className="space-y-4">
          {filtered.map((fil) => {
            const isExpanded = expandedId === String(fil.id);
            const univ = univerList.find((u) => u.id === fil.universite_id);
            return (
              <div key={fil.id} className="rounded-xl border bg-card shadow-sm overflow-hidden">
                <div
                  className="p-5 cursor-pointer hover:bg-muted/30 transition-colors"
                  onClick={() => setExpandedId(isExpanded ? null : String(fil.id))}
                >
                  <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                    <div className="flex items-start gap-4 flex-1">
                      <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg bg-primary/10">
                        <BookOpen className="h-5 w-5 text-primary" />
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2 mb-1 flex-wrap">
                          {isExpanded ? <ChevronDown className="h-4 w-4" /> : <ChevronRight className="h-4 w-4" />}
                          <h3 className="font-semibold">{fil.nom}</h3>
                          {fil.niveaux && fil.niveaux.map(n => (
                            <Badge key={n} className="text-[10px]">{n}</Badge>
                          ))}
                          <Badge variant="secondary" className="text-[10px]">{fil.difficulte}</Badge>
                        </div>
                        <div className="flex items-center gap-2 text-xs text-muted-foreground mt-1">
                          <Building2 className="h-3 w-3" />
                          {univ?.nom}
                        </div>
                      </div>
                    </div>

                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon" className="h-8 w-8" onClick={(e) => e.stopPropagation()}>
                          <MoreHorizontal className="h-4 w-4" />
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => setExpandedId(isExpanded ? null : String(fil.id))}>
                          <Eye className="h-4 w-4 mr-2" /> {t("admin.pages.filieres.viewDetails")}
                        </DropdownMenuItem>
                        <DropdownMenuItem onClick={() => openEditDialog(fil)}>
                          <Pencil className="h-4 w-4 mr-2" /> {t("admin.pages.filieres.editAction")}
                        </DropdownMenuItem>
                        <DropdownMenuItem className="text-destructive" onClick={() => { setDeletingId(fil.id); setDeleteDialogOpen(true); }}>
                          <Trash2 className="h-4 w-4 mr-2" /> {t("admin.pages.filieres.deleteAction")}
                        </DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </div>
                </div>

                {isExpanded && (
                  <div className="border-t px-5 py-4 bg-muted/20 space-y-4">
                    <div className="grid gap-3 sm:grid-cols-2 text-sm">
                      <div className="rounded-lg border bg-card p-3">
                        <p className="text-muted-foreground">{t("admin.pages.filieres.domain")}</p>
                        <p className="font-medium">{fil.domaine || "Non spécifié"}</p>
                      </div>
                      <div className="rounded-lg border bg-card p-3">
                        <p className="text-muted-foreground">{t("admin.pages.filieres.duration")}</p>
                        <p className="font-medium">{fil.duree_annees ? `${fil.duree_annees} ans` : "Non spécifiée"}</p>
                      </div>
                      <div className="rounded-lg border bg-card p-3">
                        <p className="text-muted-foreground">{t("admin.pages.filieres.cost")}</p>
                        <p className="font-medium">{fil.cout_annuel ? `${fil.cout_annuel.toLocaleString()}` : "Non spécifié"}</p>
                        {fil.cout_description && (
                          <p className="text-xs text-muted-foreground mt-1">{fil.cout_description}</p>
                        )}
                      </div>
                      <div className="rounded-lg border bg-card p-3">
                        <p className="text-muted-foreground">{t("admin.pages.filieres.employmentRate")}</p>
                        <p className="font-medium">{fil.taux_emploi ? `${fil.taux_emploi}%` : "Non spécifié"}</p>
                      </div>
                    </div>
                    {fil.description && (
                      <div className="rounded-lg border bg-card p-3">
                        <p className="text-muted-foreground text-sm">{t("admin.pages.filieres.formDescription")}</p>
                        <p className="text-sm mt-1">{fil.description}</p>
                      </div>
                    )}
                    {fil.parcours && fil.parcours.length > 0 && (
                      <div className="rounded-lg border bg-card p-3">
                        <div className="flex items-center gap-2 mb-2">
                          <Layers className="h-4 w-4 text-primary" />
                          <p className="font-medium">{fil.parcours.length} {t("admin.pages.filieres.formDescription")}</p>
                        </div>
                        <div className="space-y-1">
                          {fil.parcours.map((p) => (
                            <div key={p.id} className="text-sm text-muted-foreground">
                              • {p.nom}
                            </div>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </div>
            );
          })}
        </div>

        {filtered.length === 0 && (
          <div className="p-12 text-center text-muted-foreground">
            <BookOpen className="h-10 w-10 mx-auto mb-2 opacity-40" />
            <p>{t("admin.pages.filieres.noResults")}</p>
          </div>
        )}

        {/* Add/Edit Dialog */}
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogContent className="max-w-2xl max-h-[90vh] flex flex-col">
            <DialogHeader>
              <DialogTitle>{editingFiliere ? t("admin.pages.filieres.editFiliere") : t("admin.pages.filieres.addFiliere")}</DialogTitle>
            </DialogHeader>
            <div className="space-y-4 py-2 overflow-y-auto flex-1 pr-4">
              <div className="space-y-1.5">
                <Label>{t("admin.pages.filieres.formUniversity")} *</Label>
                <Select value={formUniversiteId} onValueChange={setFormUniversiteId}>
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {univerList.map((u) => (
                      <SelectItem key={u.id} value={String(u.id)}>
                        {u.nom}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.filieres.formName")} *</Label>
                <Input value={formNom} onChange={(e) => setFormNom(e.target.value)} placeholder="ex: Informatique" />
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.filieres.formDomain")}</Label>
                <Input value={formDomaine} onChange={(e) => setFormDomaine(e.target.value)} placeholder="ex: Sciences & Technologies" />
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.filieres.formNiveaux")} *</Label>
                <div className="space-y-2 p-3 border rounded-md bg-muted/30">
                  {niveaux.map((n) => (
                    <label key={n} className="flex items-center gap-2 cursor-pointer">
                      <input
                        type="checkbox"
                        checked={formNiveaux.includes(n)}
                        onChange={(e) => {
                          if (e.target.checked) {
                            setFormNiveaux([...formNiveaux, n]);
                          } else {
                            setFormNiveaux(formNiveaux.filter(niv => niv !== n));
                          }
                        }}
                        className="rounded border-input cursor-pointer"
                      />
                      <span className="text-sm">{n}</span>
                    </label>
                  ))}
                </div>
              </div>
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.filieres.formDifficulty")}</Label>
                  <Select value={formDifficulte} onValueChange={setFormDifficulte}>
                    <SelectTrigger>
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      {difficultes.map((d) => (
                        <SelectItem key={d} value={d}>
                          {d.charAt(0).toUpperCase() + d.slice(1)}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.filieres.formDuration")}</Label>
                  <Input type="text" value={formDuree} onChange={(e) => setFormDuree(e.target.value)} placeholder="ex: 3 - 5 ou 2 ans" />
                </div>
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.filieres.formCost")}</Label>
                <Input type="number" value={formCout} onChange={(e) => setFormCout(e.target.value)} placeholder="ex: 5000" />
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.filieres.formCostDescription")} <span className="text-xs text-muted-foreground">(optionnel)</span></Label>
                <Input value={formCoutDescription} onChange={(e) => setFormCoutDescription(e.target.value)} placeholder="ex: Généralement pris en charge par l'État" />
              </div>
              <div className="space-y-3 border-t pt-4">
                <button
                  type="button"
                  onClick={() => setShowParcoursForm(!showParcoursForm)}
                  className="flex items-center justify-between w-full p-3 hover:bg-muted/50 rounded-lg transition-colors"
                >
                  <div className="flex items-center gap-2">
                    {showParcoursForm ? <ChevronDown className="h-4 w-4" /> : <ChevronRight className="h-4 w-4" />}
                    <Label className="text-base font-semibold cursor-pointer">{formParcours.length > 0 ? `${t("admin.pages.filieres.parcoursCount")} (${formParcours.length})` : t("admin.pages.filieres.addParcours")}</Label>
                  </div>
                </button>

                {showParcoursForm && (
                  <div className="space-y-3">
                    {formParcours.length > 0 && (
                      <div className="space-y-2 max-h-40 overflow-y-auto">
                        {formParcours.map((p, idx) => (
                          <div key={idx} className="p-2 bg-muted rounded text-sm">
                            <div className="flex items-start justify-between gap-2">
                              <div className="flex-1 min-w-0">
                                <p className="font-medium">{p.nom}</p>
                                <div className="text-xs text-muted-foreground space-y-0.5">
                                  {p.specialisation && <p>Spéc: {p.specialisation}</p>}
                                  {p.duree_mois && <p>Durée: {p.duree_mois} mois</p>}
                                </div>
                              </div>
                              <button
                                type="button"
                                onClick={() => handleRemoveParcours(idx)}
                                className="text-destructive hover:text-destructive/90 text-xs whitespace-nowrap"
                              >
                                ✕
                              </button>
                            </div>
                          </div>
                        ))}
                      </div>
                    )}

                    <div className="space-y-2 p-3 bg-muted/50 rounded-lg">
                      <div className="space-y-1.5">
                        <Label className="text-sm">{t("admin.pages.filieres.parcoursName")} *</Label>
                        <Input
                          value={newParcoursNom}
                          onChange={(e) => setNewParcoursNom(e.target.value)}
                          placeholder="ex: Développement web"
                          size={32}
                        />
                      </div>
                      <div className="grid gap-2 grid-cols-2">
                        <div className="space-y-1.5">
                          <Label className="text-sm">{t("admin.pages.filieres.parcoursSpecialisation")}</Label>
                          <Input
                            value={newParcoursSpec}
                            onChange={(e) => setNewParcoursSpec(e.target.value)}
                            placeholder="ex: Frontend"
                            size={32}
                          />
                        </div>
                        <div className="space-y-1.5">
                          <Label className="text-sm">{t("admin.pages.filieres.parcoursDuration")}</Label>
                          <Input
                            type="number"
                            min="0"
                            value={newParcoursDuree}
                            onChange={(e) => setNewParcoursDuree(e.target.value)}
                            placeholder="ex: 36"
                          />
                        </div>
                      </div>
                      <div className="space-y-1.5">
                        <Label className="text-sm">{t("admin.pages.filieres.parcoursDescription")}</Label>
                        <textarea
                          value={newParcoursDesc}
                          onChange={(e) => setNewParcoursDesc(e.target.value)}
                          placeholder={t("admin.pages.filieres.parcoursDescriptionPlaceholder")}
                          rows={2}
                          className="w-full px-3 py-2 rounded-md border border-input bg-background text-sm resize-none focus:outline-none focus:ring-2 focus:ring-ring"
                        />
                      </div>
                      <Button
                        type="button"
                        size="sm"
                        variant="secondary"
                        onClick={handleAddParcours}
                        className="w-full"
                      >
                        <Plus className="h-4 w-4 mr-1" /> {t("admin.pages.filieres.parcoursAdd")}
                      </Button>
                    </div>
                  </div>
                )}
              </div>
            </div>
            <DialogFooter className="border-t pt-4 mt-4 flex-shrink-0">
              <Button variant="outline" onClick={() => setDialogOpen(false)}>{t("admin.pages.filieres.cancel")}</Button>
              <Button onClick={handleSave} disabled={!formUniversiteId || !formNom || formNiveaux.length === 0}>
                {editingFiliere ? t("admin.pages.filieres.save") : t("admin.pages.filieres.addNew")}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Delete Confirmation Dialog */}
        <AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.pages.filieres.deleteConfirmTitle")}</AlertDialogTitle>
              <AlertDialogDescription>
                {t("admin.pages.filieres.confirmDelete")}
              </AlertDialogDescription>
            </AlertDialogHeader>
            <div className="flex gap-3 justify-end">
              <AlertDialogCancel>{t("admin.pages.filieres.cancel")}</AlertDialogCancel>
              <AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
                {t("admin.pages.filieres.delete")}
              </AlertDialogAction>
            </div>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </AdminLayout>
  );
};

export default AdminFilieres;
