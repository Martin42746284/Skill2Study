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
import { useInfiniteScroll } from "@/hooks/useInfiniteScroll";
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
  const [univerList, setUniversList] = useState<University[]>([]);
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingFiliere, setEditingFiliere] = useState<Filiere | null>(null);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [deletingId, setDeletingId] = useState<number | null>(null);

  // Form state
  const [formUniversiteId, setFormUniversiteId] = useState("");
  const [formNom, setFormNom] = useState("");
  const [formDomaine, setFormDomaine] = useState("");
  const [formNiveaux, setFormNiveaux] = useState<string[]>(["Licence"]);
  const [formSeriesBac, setFormSeriesBac] = useState<string[]>([]);
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

  // Series bac options from translation
  const seriesBacOptions = [
    { value: "A1", label: t("seriesBac.serieA1") },
    { value: "A2", label: t("seriesBac.serieA2") },
    { value: "C", label: t("seriesBac.serieC") },
    { value: "D", label: t("seriesBac.serieD") },
    { value: "S", label: t("seriesBac.serieS") },
    { value: "OSE", label: t("seriesBac.serieOSE") },
    { value: "L", label: t("seriesBac.serieL") },
    { value: "Technique", label: t("seriesBac.serieTechnique") },
    { value: "Toutes séries", label: t("seriesBac.serieToutesSeries") }
  ];

  // Domaines options from translation
  const domainesOptions = [
    { value: "Sciences et Technologies", label: t("domaines.sciences_tech") },
    { value: "Sciences de Gestion", label: t("domaines.sciences_gestion") },
    { value: "Droit et Sciences Politiques", label: t("domaines.droit_sciences_pol") },
    { value: "Arts, Lettres et Communication", label: t("domaines.arts_lettres_comm") },
    { value: "Santé et Paramédical", label: t("domaines.sante_paramedical") },
    { value: "Agriculture et Environnement", label: t("domaines.agriculture_env") },
    { value: "Sciences Humaines et Sociales", label: t("domaines.sciences_humaines") },
    { value: "Défense et Sécurité", label: t("domaines.defense_securite") }
  ];

  const fetchFilieres = async (skip: number, limit: number) => {
    const filiereRes = await filieres.getAll();
    let filList: Filiere[] = [];
    const filiereResAny = filiereRes as unknown;
    if (Array.isArray(filiereResAny)) {
      filList = filiereResAny;
    } else if (typeof filiereResAny === 'object' && filiereResAny !== null && 'filieres' in filiereResAny && Array.isArray((filiereResAny as any).filieres)) {
      filList = (filiereResAny as any).filieres;
    } else if (typeof filiereResAny === 'object' && filiereResAny !== null && 'data' in filiereResAny && Array.isArray((filiereResAny as any).data)) {
      filList = (filiereResAny as any).data;
    }

    // Normaliser: convertir niveau (string) en niveaux (array)
    filList = filList.map(f => ({
      ...f,
      niveaux: f.niveaux || (f.niveau ? [f.niveau] : [])
    }));

    // Appliquer le skip et limit
    return filList.slice(skip, skip + limit);
  };

  const { items: filiereList, isLoading: loading, observerTarget, error: loadError, setItems: setFiliereList } = useInfiniteScroll<Filiere>(
    fetchFilieres,
    { initialPageSize: 30, threshold: 300 }
  );

  useEffect(() => {
    const fetchUniversities = async () => {
      try {
        const univRes = await universities.getAll();
        let univs: University[] = [];
        const univResAny = univRes as unknown;
        if (Array.isArray(univResAny)) {
          univs = univResAny;
        } else if (typeof univResAny === 'object' && univResAny !== null && 'universites' in univResAny && Array.isArray((univResAny as any).universites)) {
          univs = (univResAny as any).universites;
        } else if (typeof univResAny === 'object' && univResAny !== null && 'data' in univResAny && Array.isArray((univResAny as any).data)) {
          univs = (univResAny as any).data;
        }
        setUniversList(univs);
      } catch (error) {
        toast({
          title: t("common.error"),
          description: error instanceof Error ? error.message : t("admin.pages.filieres.loadingError"),
          variant: "destructive"
        });
      }
    };

    fetchUniversities();
  }, [toast]);

  useEffect(() => {
    if (loadError) {
      toast({
        title: t("common.error"),
        description: loadError.message || t("admin.pages.filieres.loadingError"),
        variant: "destructive"
      });
    }
  }, [loadError, toast]);

  const niveaux = ["Licence", "Master", "Doctorat", "DTS", "DUT", "Ingénieur"];
  const niveauxTranslated = [
    { value: "Licence", label: t("niveaux.licence") },
    { value: "Master", label: t("niveaux.master") },
    { value: "Doctorat", label: t("niveaux.doctorat") },
    { value: "DTS", label: t("niveaux.dts") },
    { value: "DUT", label: t("niveaux.dut") },
    { value: "Ingénieur", label: t("niveaux.ingenieur") }
  ];
  const difficultes = ["facile", "moyen", "difficile", "tres_difficile"];
  const difficultesTranslated = [
    { value: "facile", label: t("difficultes.facile") },
    { value: "moyen", label: t("difficultes.moyen") },
    { value: "difficile", label: t("difficultes.difficile") },
    { value: "tres_difficile", label: t("difficultes.tres_difficile") }
  ];
  const domaines = Array.from(new Set(filiereList.map((f) => f.domaine).filter(Boolean))) as string[];

  const filtered = filiereList.filter((f) => {
    const searchLower = search.toLowerCase();
    const univ = univerList.find(u => u.id === f.universite_id);
    const nomMatch = (f.nom || '').toLowerCase().includes(searchLower);
    const domaineMatch = (f.domaine || '').toLowerCase().includes(searchLower);
    const univMatch = (univ?.nom || '').toLowerCase().includes(searchLower);
    const niveauMatch = niveauFilter === "all" || (f.niveaux && f.niveaux.includes(niveauFilter));
    const univFilterMatch = univFilter === "all" || String(f.universite_id) === univFilter;
    return (nomMatch || domaineMatch || univMatch) && niveauMatch && univFilterMatch;
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
    setFormSeriesBac([]);
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
    setFormSeriesBac((fil as any).series_bac_acceptees || []);
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
      if (!formUniversiteId || !formNom || formNiveaux.length === 0 || formSeriesBac.length === 0) {
        toast({
          title: t("common.error"),
          description: t("admin.pages.filieres.formRequiredFields"),
          variant: "destructive"
        });
        return;
      }

      const niveau = formNiveaux[0] as 'Licence' | 'Master' | 'Doctorat' | 'DTS' | 'DUT' | 'Ingénieur' || 'Licence';

      if (editingFiliere) {
        const updateData: any = {
          nom: formNom.trim(),
          domaine: formDomaine.trim(),
          niveau,
          series_bac_acceptees: formSeriesBac,
          difficulte: formDifficulte as "facile" | "moyen" | "difficile" | "tres_difficile",
          parcours: formParcours,
        };

        if (formDescription) updateData.description = formDescription;
        if (formDuree && formDuree.trim()) updateData.duree_annees = formDuree.trim(); // Garder comme string
        if (formCout && formCout.trim()) updateData.cout_annuel = parseFloat(formCout);
        if (formCoutDescription) updateData.cout_description = formCoutDescription.trim();

        //console.log('UpdateData envoyé:', updateData);

        try {
          await filieres.update(editingFiliere.id, updateData);
        } catch (error) {
          console.error('Erreur lors de l\'update:', error);
          throw error;
        }
        const updatedFiliere: Filiere = { ...editingFiliere, ...updateData, niveaux: formNiveaux, duree_annees: formDuree };
        setFiliereList(filiereList.map((f) => (f.id === editingFiliere.id ? updatedFiliere : f)));
        toast({ title: "Filière modifiée", description: `${formNom} a été mise à jour.` });
      } else {
        const createData: any = {
          universite_id: parseInt(formUniversiteId),
          nom: formNom.trim(),
          domaine: formDomaine.trim(),
          niveau,
          series_bac_acceptees: formSeriesBac,
          difficulte: formDifficulte as "facile" | "moyen" | "difficile" | "tres_difficile",
        };

        if (formDescription) createData.description = formDescription;
        if (formDuree && formDuree.trim()) createData.duree_annees = formDuree.trim();
        if (formCout && formCout.trim()) createData.cout_annuel = parseFloat(formCout);
        if (formCoutDescription) createData.cout_description = formCoutDescription.trim();

        const response = await filieres.create(createData);
        const newFiliere: Filiere = (typeof response === 'object' && response !== null && 'filiere' in response)
          ? (response as any).filiere
          : { id: Date.now(), ...createData, actif: true, niveaux: formNiveaux, duree_annees: formDuree };
        setFiliereList([...filiereList, newFiliere]);
        toast({ title: "Filière ajoutée", description: `${formNom} a été ajoutée avec succès.` });
      }
      setDialogOpen(false);
    } catch (error) {
      toast({
        title: t("common.error"),
        description: error instanceof Error ? error.message : t("admin.pages.filieres.savingError"),
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
      toast({ title: t("common.error"), description: t("admin.pages.parcours.formNamePlaceholder"), variant: "destructive" });
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

  return (
    <AdminLayout>
      <div className="animate-fade-in">
        <div className="mb-8 space-y-3">
          {/* Search & Filters - Full width on mobile */}
          <div className="flex flex-col sm:flex-row gap-3">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input placeholder={t("admin.pages.filieres.searchPlaceholder")} value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9 h-10 w-full" />
            </div>
            <Select value={niveauFilter} onValueChange={setNiveauFilter}>
              <SelectTrigger className="h-10 sm:w-[160px] w-full">
                <SelectValue placeholder={t("admin.pages.filieres.niveau")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin.pages.filieres.all")}</SelectItem>
                {niveaux.map((n) => <SelectItem key={n} value={n}>{n}</SelectItem>)}
              </SelectContent>
            </Select>
            <Select value={univFilter} onValueChange={setUnivFilter}>
              <SelectTrigger className="h-10 sm:w-[160px] w-full">
                <SelectValue placeholder={t("admin.pages.filieres.filterByUniversity")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin.pages.filieres.all")}</SelectItem>
                {univerList.map((u) => <SelectItem key={u.id} value={String(u.id)}>{u.nom}</SelectItem>)}
              </SelectContent>
            </Select>
          </div>

          {/* Counter & Buttons */}
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
            <div className="flex items-center px-3 py-1 rounded-lg bg-accent/30 border border-accent/50">
              <span className="text-xs font-medium text-muted-foreground">
                {filiereList.length} {t("admin.pages.filieres.noResults").toLowerCase()}
              </span>
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
                          {fil.niveaux && fil.niveaux.length > 0 ? (
                            fil.niveaux.map(n => (
                              <Badge key={n} className="text-[10px]">{n}</Badge>
                            ))
                          ) : fil.niveau ? (
                            <Badge className="text-[10px]">{fil.niveau}</Badge>
                          ) : null}
                          {fil.difficulte && <Badge variant="secondary" className="text-[10px]">{fil.difficulte}</Badge>}
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

        {/* Infinite scroll loading indicator */}
        {loading && (
          <div className="flex justify-center py-6">
            <div className="animate-spin">
              <svg className="h-6 w-6 text-muted-foreground" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
            </div>
          </div>
        )}

        <div ref={observerTarget} className="h-10" />

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
                <Label>{t("domaines.label")}</Label>
                <Select value={formDomaine} onValueChange={setFormDomaine}>
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {domainesOptions.map((d) => (
                      <SelectItem key={d.value} value={d.value}>
                        {d.label}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.filieres.formNiveaux")} *</Label>
                <div className="flex flex-wrap gap-3 p-3 border rounded-md bg-muted/30 justify-between">
                  {niveauxTranslated.map((n) => (
                    <button
                      key={n.value}
                      type="button"
                      onClick={() => {
                        if (formNiveaux.includes(n.value)) {
                          setFormNiveaux(formNiveaux.filter(niv => niv !== n.value));
                        } else {
                          setFormNiveaux([...formNiveaux, n.value]);
                        }
                      }}
                      className={`flex-1 min-w-fit px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                        formNiveaux.includes(n.value)
                          ? 'bg-primary text-primary-foreground'
                          : 'bg-muted border border-input hover:bg-muted/70'
                      }`}
                    >
                      {n.label}
                    </button>
                  ))}
                </div>
              </div>
              <div className="space-y-1.5">
                <Label>{t("seriesBac.label")} *</Label>
                <div className="flex flex-wrap gap-3 p-3 border rounded-md bg-muted/30 justify-between">
                  {seriesBacOptions.map((serie) => (
                    <button
                      key={serie.value}
                      type="button"
                      onClick={() => {
                        if (formSeriesBac.includes(serie.value)) {
                          setFormSeriesBac(formSeriesBac.filter(s => s !== serie.value));
                        } else {
                          setFormSeriesBac([...formSeriesBac, serie.value]);
                        }
                      }}
                      className={`flex-1 min-w-fit px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                        formSeriesBac.includes(serie.value)
                          ? 'bg-primary text-primary-foreground'
                          : 'bg-muted border border-input hover:bg-muted/70'
                      }`}
                    >
                      {serie.label}
                    </button>
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
                      {difficultesTranslated.map((d) => (
                        <SelectItem key={d.value} value={d.value}>
                          {d.label}
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
              <Button onClick={handleSave} disabled={!formUniversiteId || !formNom || formNiveaux.length === 0 || formSeriesBac.length === 0}>
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
