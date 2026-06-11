import AdminLayout from "@/components/AdminLayout";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Layers,
  Search,
  Plus,
  MoreHorizontal,
  Eye,
  Pencil,
  Trash2,
  BookOpen,
  ChevronDown,
  ChevronRight,
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
import { parcours, filieres } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import type { Parcours as ParcoursType, Filiere } from "@/types";
import { downloadCSV } from "@/lib/export";

const AdminParcours = () => {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [search, setSearch] = useState("");
  const [filiereFilter, setFiliereFilter] = useState("all");
  const [filiereList, setFiliereList] = useState<Filiere[]>([]);
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingParcours, setEditingParcours] = useState<ParcoursType | null>(null);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [deletingId, setDeletingId] = useState<number | null>(null);

  // Form state
  const [formFiliereId, setFormFiliereId] = useState("");
  const [formNom, setFormNom] = useState("");
  const [formCode, setFormCode] = useState("");
  const [formDescription, setFormDescription] = useState("");
  const [formDuree, setFormDuree] = useState("");
  const [formSpecialisation, setFormSpecialisation] = useState("");

  const fetchParcours = async (skip: number, limit: number) => {
    const parRes = await parcours.getAll();
    let parList: ParcoursType[] = [];
    const parResponse = parRes as any;
    if (Array.isArray(parResponse)) {
      parList = parResponse;
    } else if (parResponse?.parcours && Array.isArray(parResponse.parcours)) {
      parList = parResponse.parcours;
    } else if (parResponse?.data && Array.isArray(parResponse.data)) {
      parList = parResponse.data;
    }

    // Appliquer le skip et limit
    return parList.slice(skip, skip + limit);
  };

  const { items: parcoursList, isLoading: loading, observerTarget, error: loadError, setItems: setParcoursList } = useInfiniteScroll<ParcoursType>(
    fetchParcours,
    { initialPageSize: 30, threshold: 300 }
  );

  useEffect(() => {
    const fetchFilieres = async () => {
      try {
        const filRes = await filieres.getAll();
        let fils: Filiere[] = [];
        const filResponse = filRes as any;
        if (Array.isArray(filResponse)) {
          fils = filResponse;
        } else if (filResponse?.filieres && Array.isArray(filResponse.filieres)) {
          fils = filResponse.filieres;
        } else if (filResponse?.data && Array.isArray(filResponse.data)) {
          fils = filResponse.data;
        }
        setFiliereList(fils);
      } catch (error) {
        toast({
          title: t("common.error"),
          description: error instanceof Error ? error.message : t("admin.pages.parcours.loadingError"),
          variant: "destructive"
        });
      }
    };

    fetchFilieres();
  }, [toast]);

  useEffect(() => {
    if (loadError) {
      toast({
        title: t("common.error"),
        description: loadError.message || t("admin.pages.parcours.loadingError"),
        variant: "destructive"
      });
    }
  }, [loadError, toast]);

  const filtered = parcoursList.filter((p) => {
    const nomMatch = (p.nom || '').toLowerCase().includes(search.toLowerCase());
    const filiereMatch = filiereFilter === "all" || p.filiere_id === parseInt(filiereFilter);
    return nomMatch && filiereMatch;
  });

  const handleExportCSV = () => {
    const data = parcoursList.map(p => {
      const filiere = filiereList.find(f => f.id === p.filiere_id);
      return {
        ID: p.id,
        Nom: p.nom,
        Code: p.code || '',
        Filière: filiere?.nom || 'N/A',
        Spécialisation: p.specialisation || '',
        Durée: p.duree_mois ? `${p.duree_mois} mois` : '',
        Description: p.description || '',
      };
    });
    downloadCSV(data, `parcours-${new Date().toLocaleDateString('fr-FR')}.csv`);
    toast({ title: t("common.success"), description: `${parcoursList.length} ${t("admin.pages.parcours.indicator")}` });
  };

  const openAddDialog = () => {
    setEditingParcours(null);
    setFormFiliereId("");
    setFormNom("");
    setFormCode("");
    setFormDescription("");
    setFormDuree("");
    setFormSpecialisation("");
    setDialogOpen(true);
  };

  const openEditDialog = (par: ParcoursType) => {
    setEditingParcours(par);
    setFormFiliereId(String(par.filiere_id));
    setFormNom(par.nom || "");
    setFormCode(par.code || "");
    setFormDescription(par.description || "");
    setFormDuree(String(par.duree_mois || ""));
    setFormSpecialisation(par.specialisation || "");
    setDialogOpen(true);
  };

  const handleSave = async () => {
    try {
      if (!formFiliereId || !formNom) {
        toast({
          title: t("common.error"),
          description: t("admin.pages.parcours.requiredFields"),
          variant: "destructive"
        });
        return;
      }

      const data = {
        filiere_id: parseInt(formFiliereId),
        nom: formNom.trim(),
        ...(formCode && { code: formCode.trim() }),
        ...(formDescription && { description: formDescription }),
        ...(formDuree && { duree_mois: parseInt(formDuree) }),
        ...(formSpecialisation && { specialisation: formSpecialisation.trim() }),
      };

      if (editingParcours) {
        await parcours.update(editingParcours.id, data);
        setParcoursList(parcoursList.map((p) => (p.id === editingParcours.id ? { ...p, ...data } : p)));
        toast({ title: t("admin.pages.parcours.updateSuccess"), description: `${formNom} ${t("admin.pages.parcours.updatedMsg")}.` });
      } else {
        await parcours.create(data);
        // Always refetch the complete list from server
        const updatedRes = await parcours.getAll() as any;
        let parList = [];
        if (Array.isArray(updatedRes)) {
          parList = updatedRes;
        } else if (updatedRes?.parcours && Array.isArray(updatedRes.parcours)) {
          parList = updatedRes.parcours;
        } else if (updatedRes?.data && Array.isArray(updatedRes.data)) {
          parList = updatedRes.data;
        }
        setParcoursList(parList);
        toast({ title: t("admin.pages.parcours.addSuccess"), description: `${formNom} ${t("admin.pages.parcours.addedMsg")}.` });
      }
      setDialogOpen(false);
    } catch (error) {
      toast({
        title: t("common.error"),
        description: error instanceof Error ? error.message : t("admin.pages.parcours.savingError"),
        variant: "destructive"
      });
    }
  };

  const handleDelete = async () => {
    if (deletingId === null) return;
    try {
      await parcours.delete(deletingId);
      const deletedPar = parcoursList.find((p) => p.id === deletingId);
      setParcoursList(parcoursList.filter((p) => p.id !== deletingId));
      toast({
        title: t("admin.pages.parcours.deleteSuccess"),
        description: deletedPar ? `${deletedPar.nom} ${t("admin.pages.parcours.deletedMsg")}.` : t("admin.pages.parcours.deletedMsg"),
        variant: "destructive"
      });
    } catch (error) {
      toast({
        title: t("common.error"),
        description: error instanceof Error ? error.message : t("admin.pages.parcours.deletingError"),
        variant: "destructive"
      });
    } finally {
      setDeleteDialogOpen(false);
      setDeletingId(null);
    }
  };

  return (
    <AdminLayout>
      <div className="animate-fade-in">
        <div className="mb-8 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div>
            <p className="text-sm text-muted-foreground">{parcoursList.length} {t("admin.pages.parcours.indicator")}</p>
          </div>
          <div className="flex gap-2">
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button size="sm" variant="outline">
                  <Plus className="h-4 w-4 mr-1" /> {t("admin.pages.parcours.action")}
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end">
                <DropdownMenuItem onClick={handleExportCSV}>
                  {t("admin.pages.parcours.exportCSV")}
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
            <Button size="sm" onClick={openAddDialog}>
              <Plus className="h-4 w-4 mr-1" /> {t("admin.pages.parcours.addNew")}
            </Button>
          </div>
        </div>

        <div className="mb-6 flex flex-col sm:flex-row gap-3">
          <div className="relative flex-1 max-w-md">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
            <Input placeholder={t("admin.pages.parcours.searchPlaceholder")} value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9" />
          </div>
          <Select value={filiereFilter} onValueChange={setFiliereFilter}>
            <SelectTrigger className="w-full sm:w-[220px]">
              <SelectValue placeholder={t("admin.pages.parcours.filterByLevel")} />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("admin.pages.parcours.all")}</SelectItem>
              {filiereList.map((f) => (
                <SelectItem key={f.id} value={String(f.id)}>
                  {f.nom}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        <div className="space-y-4">
          {filtered.map((par) => {
            const isExpanded = expandedId === String(par.id);
            const filiere = filiereList.find((f) => f.id === par.filiere_id);
            return (
              <div key={par.id} className="rounded-xl border bg-card shadow-sm overflow-hidden">
                <div
                  className="p-5 cursor-pointer hover:bg-muted/30 transition-colors"
                  onClick={() => setExpandedId(isExpanded ? null : String(par.id))}
                >
                  <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                    <div className="flex items-start gap-4 flex-1">
                      <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg bg-primary/10">
                        <Layers className="h-5 w-5 text-primary" />
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2 mb-1">
                          {isExpanded ? <ChevronDown className="h-4 w-4" /> : <ChevronRight className="h-4 w-4" />}
                          <h3 className="font-semibold">{par.nom}</h3>
                          {par.code && <Badge variant="outline" className="text-[10px]">{par.code}</Badge>}
                        </div>
                        <div className="flex items-center gap-2 text-xs text-muted-foreground mt-1">
                          <BookOpen className="h-3 w-3" />
                          {filiere?.nom || 'Filière inconnue'}
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
                        <DropdownMenuItem onClick={() => setExpandedId(isExpanded ? null : String(par.id))}>
                          <Eye className="h-4 w-4 mr-2" /> {t("admin.pages.parcours.viewDetails")}
                        </DropdownMenuItem>
                        <DropdownMenuItem onClick={() => openEditDialog(par)}>
                          <Pencil className="h-4 w-4 mr-2" /> {t("admin.pages.parcours.editAction")}
                        </DropdownMenuItem>
                        <DropdownMenuItem className="text-destructive" onClick={() => { setDeletingId(par.id); setDeleteDialogOpen(true); }}>
                          <Trash2 className="h-4 w-4 mr-2" /> {t("admin.pages.parcours.deleteAction")}
                        </DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </div>
                </div>

                {isExpanded && (
                  <div className="border-t px-5 py-4 bg-muted/20 space-y-4">
                    <div className="grid gap-3 sm:grid-cols-2 text-sm">
                      {par.specialisation && (
                        <div className="rounded-lg border bg-card p-3">
                          <p className="text-muted-foreground">{t("admin.pages.parcours.specialisation")}</p>
                          <p className="font-medium">{par.specialisation}</p>
                        </div>
                      )}
                      {par.duree_mois && (
                        <div className="rounded-lg border bg-card p-3">
                          <p className="text-muted-foreground">{t("admin.pages.parcours.duration")}</p>
                          <p className="font-medium">{par.duree_mois} {t("admin.pages.parcours.months")}</p>
                        </div>
                      )}
                    </div>
                    {par.description && (
                      <div className="rounded-lg border bg-card p-3">
                        <p className="text-muted-foreground text-sm">{t("admin.pages.parcours.description")}</p>
                        <p className="text-sm mt-1">{par.description}</p>
                      </div>
                    )}
                    {par.competences_acquises && Array.isArray(par.competences_acquises) && par.competences_acquises.length > 0 && (
                      <div className="rounded-lg border bg-card p-3">
                        <p className="font-medium text-sm mb-2">{t("admin.pages.parcours.skills")}</p>
                        <div className="flex flex-wrap gap-1">
                          {par.competences_acquises.map((c: string, idx: number) => (
                            <Badge key={idx} variant="secondary" className="text-[10px]">
                              {c}
                            </Badge>
                          ))}
                        </div>
                      </div>
                    )}
                    {par.debouches_professionnels && Array.isArray(par.debouches_professionnels) && par.debouches_professionnels.length > 0 && (
                      <div className="rounded-lg border bg-card p-3">
                        <p className="font-medium text-sm mb-2">{t("admin.pages.parcours.opportunities")}</p>
                        <div className="space-y-1">
                          {par.debouches_professionnels.map((d: string, idx: number) => (
                            <div key={idx} className="text-sm text-muted-foreground">
                              • {d}
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
            <Layers className="h-10 w-10 mx-auto mb-2 opacity-40" />
            <p>{t("admin.pages.parcours.noResults")}</p>
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
          <DialogContent className="max-w-lg">
            <DialogHeader>
              <DialogTitle>{editingParcours ? t("admin.pages.parcours.editParcours") : t("admin.pages.parcours.addParcours")}</DialogTitle>
            </DialogHeader>
            <div className="space-y-4 py-2">
              <div className="space-y-1.5">
                <Label>{t("admin.pages.parcours.formField")} *</Label>
                <Select value={formFiliereId} onValueChange={setFormFiliereId}>
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {filiereList.map((f) => (
                      <SelectItem key={f.id} value={String(f.id)}>
                        {f.nom}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.parcours.formName")} *</Label>
                <Input value={formNom} onChange={(e) => setFormNom(e.target.value)} placeholder={t("admin.pages.parcours.formNamePlaceholder")} />
              </div>
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.parcours.formCode")}</Label>
                  <Input value={formCode} onChange={(e) => setFormCode(e.target.value)} placeholder={t("admin.pages.parcours.formCodePlaceholder")} />
                </div>
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.parcours.formDuration")}</Label>
                  <Input type="number" value={formDuree} onChange={(e) => setFormDuree(e.target.value)} placeholder={t("admin.pages.parcours.formDurationPlaceholder")} />
                </div>
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.parcours.formSpecialisation")}</Label>
                <Input value={formSpecialisation} onChange={(e) => setFormSpecialisation(e.target.value)} placeholder={t("admin.pages.parcours.formSpecialisationPlaceholder")} />
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.parcours.formDescription")}</Label>
                <Textarea value={formDescription} onChange={(e) => setFormDescription(e.target.value)} placeholder={t("admin.pages.parcours.formDescriptionPlaceholder")} />
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setDialogOpen(false)}>{t("admin.pages.parcours.cancel")}</Button>
              <Button onClick={handleSave} disabled={!formFiliereId || !formNom}>
                {editingParcours ? t("admin.pages.parcours.save") : t("admin.pages.parcours.addNew")}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Delete Confirmation Dialog */}
        <AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.pages.parcours.deleteConfirmTitle")}</AlertDialogTitle>
              <AlertDialogDescription>
                {t("admin.pages.parcours.confirmDelete")}
              </AlertDialogDescription>
            </AlertDialogHeader>
            <div className="flex gap-3 justify-end">
              <AlertDialogCancel>{t("admin.pages.parcours.cancel")}</AlertDialogCancel>
              <AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
                {t("admin.pages.parcours.delete")}
              </AlertDialogAction>
            </div>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </AdminLayout>
  );
};

export default AdminParcours;
